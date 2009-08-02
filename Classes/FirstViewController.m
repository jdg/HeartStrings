//
//  FirstViewController.m
//  feelings
//
//  Created by mary on 8/1/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "FirstViewController.h"


@implementation FirstViewController
@synthesize topToolBar, titleItem;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	CGRect r = topToolBar.frame;
	r.size.height = 36.0;
	topToolBar.frame = r;
	
    [super viewDidLoad];
	[self.view updateFeelings];
}

- (void)feelingTapped:(NSString *)name {
	NSLog(@"%@ feelingTapped:%@", self, name);
	titleItem.title = name;
	[[[UIApplication sharedApplication] delegate] feelingChanged:name];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
