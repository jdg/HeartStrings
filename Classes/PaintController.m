//
//  PaintController.m
//  feelings
//
//  Created by Androidicus Maximus on 8/2/09.
//  Copyright 2009 Stone Design Corp. All rights reserved.
//

#import "PaintController.h"
#import "PaintingView.h"
#import "AudioFX.h"

@implementation PaintController

- (id)init {
    if (self = [super initWithNibName:nil bundle:nil]) {
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"New" image:[UIImage imageNamed:@"brush.png"] tag:2] autorelease];
    }
    return self;
}


#define kPaletteHeight					30
#define kPaletteSize				    5
#define kAccelerometerFrequency			25 //Hz
#define kFilteringFactor				0.1
#define kMinEraseInterval				0.5
#define kEraseAccelerationThreshold		2.0

// Padding for margins
#define kLeftMargin				10.0
#define kTopMargin				10.0
#define kRightMargin			10.0

//FUNCTIONS:
/*
 HSL2RGB Converts hue, saturation, luminance values to the equivalent red, green and blue values.
 For details on this conversion, see Fundamentals of Interactive Computer Graphics by Foley and van Dam (1982, Addison and Wesley)
 You can also find HSL to RGB conversion algorithms by searching the Internet.
 See also http://en.wikipedia.org/wiki/HSV_color_space for a theoretical explanation
 */
static void HSL2RGB(float h, float s, float l, float* outR, float* outG, float* outB)
{
	float			temp1,
	temp2;
	float			temp[3];
	int				i;
	
	// Check for saturation. If there isn't any just return the luminance value for each, which results in gray.
	if(s == 0.0) {
		if(outR)
			*outR = l;
		if(outG)
			*outG = l;
		if(outB)
			*outB = l;
		return;
	}
	
	// Test for luminance and compute temporary values based on luminance and saturation 
	if(l < 0.5)
		temp2 = l * (1.0 + s);
	else
		temp2 = l + s - l * s;
	temp1 = 2.0 * l - temp2;
	
	// Compute intermediate values based on hue
	temp[0] = h + 1.0 / 3.0;
	temp[1] = h;
	temp[2] = h - 1.0 / 3.0;
	
	for(i = 0; i < 3; ++i) {
		
		// Adjust the range
		if(temp[i] < 0.0)
			temp[i] += 1.0;
		if(temp[i] > 1.0)
			temp[i] -= 1.0;
		
		
		if(6.0 * temp[i] < 1.0)
			temp[i] = temp1 + (temp2 - temp1) * 6.0 * temp[i];
		else {
			if(2.0 * temp[i] < 1.0)
				temp[i] = temp2;
			else {
				if(3.0 * temp[i] < 2.0)
					temp[i] = temp1 + (temp2 - temp1) * ((2.0 / 3.0) - temp[i]) * 6.0;
				else
					temp[i] = temp1;
			}
		}
	}
	
	// Assign temporary values to R, G, B
	if(outR)
		*outR = temp[0];
	if(outG)
		*outG = temp[1];
	if(outB)
		*outB = temp[2];
}


- (void)viewDidLoad
{
	CGRect					rect = self.view.frame;
	CGFloat					components[3];
	
	[self.view setBackgroundColor:[UIColor blackColor]];
	
	//Create the OpenGL drawing view and add it to the window
	drawingView = [[PaintingView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)]; // - kPaletteHeight 
	[self.view addSubview:drawingView];
	
	// Create a segmented control so that the user can choose the brush color.
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
											[NSArray arrayWithObjects:
											 [UIImage imageNamed:@"Red.png"],
											 [UIImage imageNamed:@"Yellow.png"],
											 [UIImage imageNamed:@"Green.png"],
											 [UIImage imageNamed:@"Blue.png"],
											 [UIImage imageNamed:@"Purple.png"],
											 nil]];
	
	// Compute a rectangle that is positioned correctly for the segmented control you'll use as a brush color palette
	CGRect frame = CGRectMake(rect.origin.x + kLeftMargin, rect.size.height - kPaletteHeight - kTopMargin, rect.size.width - (kLeftMargin + kRightMargin), kPaletteHeight);
	segmentedControl.frame = frame;
	// When the user chooses a color, the method changeBrushColor: is called.
	[segmentedControl addTarget:self action:@selector(changeBrushColor:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	// Make sure the color of the color complements the black background
	segmentedControl.tintColor = [UIColor darkGrayColor];
	// Set the third color (index values start at 0)
	segmentedControl.selectedSegmentIndex = 2;
	
	// Add the control to the window
	[self.view addSubview:segmentedControl];
	// Now that the control is added, you can release it
	[segmentedControl release];
	
    // Define a starting color 
	HSL2RGB((CGFloat) 2.0 / (CGFloat)kPaletteSize, kSaturation, kLuminosity, &components[0], &components[1], &components[2]);
	// Set the color using OpenGL
	glColor4f(components[0], components[1], components[2], kBrushOpacity);
	
	// Look in the Info.plist file and you'll see the status bar is hidden
	// Set the style to black so it matches the background of the application
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:NO];
	// Now show the status bar, but animate to the style.
//	[application setStatusBarHidden:NO animated:YES];
	
	//Configure and enable the accelerometer
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kAccelerometerFrequency)];
	[[UIAccelerometer sharedAccelerometer] setDelegate:self];
//	//Load the sounds
//	NSBundle *mainBundle = [NSBundle mainBundle];	
//	erasingSound = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"Erase" ofType:@"caf"]];
//	selectSound =  [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"Select" ofType:@"caf"]];
}

- (void)viewDidAppear:(BOOL)ani{
	[drawingView becomeFirstResponder];	
}
// Release resources when they are no longer needed,
- (void) dealloc
{
//	[selectSound release];
//	[erasingSound release];
	[drawingView release];
	
	[super dealloc];
}

// Change the brush color
- (void)changeBrushColor:(id)sender
{
 	CGFloat					components[3];
	
	//Play sound
// 	[selectSound play];
	[AudioFX playAtPath:[[NSBundle mainBundle] pathForResource:@"Select" ofType:@"caf"]];
	//Set the new brush color
 	HSL2RGB((CGFloat)[sender selectedSegmentIndex] / (CGFloat)kPaletteSize, kSaturation, kLuminosity, &components[0], &components[1], &components[2]);
 	glColor4f(components[0], components[1], components[2], kBrushOpacity);
}





@end
