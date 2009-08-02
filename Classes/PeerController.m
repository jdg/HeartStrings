//
//  PeerController.m
//  feelings
//
//  Created by Androidicus Maximus on 8/2/09.
//  Copyright 2009 Stone Design Corp. All rights reserved.
//

#import "PeerController.h"


@implementation PeerController

- (id)init {
    if (self = [super initWithNibName:nil bundle:nil]) {
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Friends" image:[UIImage imageNamed:@"public.png"] tag:2] autorelease];
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
