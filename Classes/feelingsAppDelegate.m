//
//  feelingsAppDelegate.m
//  feelings
//
//  Created by mary on 8/1/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "feelingsAppDelegate.h"
#import "multicastViewController.h"
#import "ListOfFeelingsController.h"
#import "ComingSoonController.h"
#import "PaintController.h"
#import "PeerController.h"
#import "AudioFX.h"

@implementation feelingsAppDelegate

@synthesize window;
@synthesize tabBarController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    UIView *tbcv = tabBarController.view;
	NSMutableArray *items = [NSMutableArray arrayWithArray:[NSArray arrayWithObject:[tabBarController.viewControllers objectAtIndex:0]]];
	//
//	[items replaceObjectAtIndex:1 withObject:[[[ListOfFeelingsController alloc]  init]autorelease]];
	[items addObject: [[[ListOfFeelingsController alloc] init] autorelease]];
	
	multicastGuy = [[[multicastViewController alloc] init] autorelease];
	multicastGuy.view;
	
	[items addObject: multicastGuy];
	[items addObject: [[[PaintController alloc] init] autorelease]];
	[items addObject: [[[ComingSoonController alloc] init] autorelease]];
	[tabBarController setViewControllers:items];
	
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
}

- (void)feelingChanged:(NSString *)feelingName {
	NSString *soundPath = [[NSBundle mainBundle] pathForResource:feelingName ofType:@"wav"];
	if (soundPath) {
		[AudioFX playAtPath:soundPath];
	}
	// broadcast feeling!!!!
	[[multicastGuy remoteFeelings] sendToRemote:feelingName];
	[[NSUserDefaults standardUserDefaults] setObject:feelingName forKey:@"lastfeeling"];
}

- (void)dealloc {
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

