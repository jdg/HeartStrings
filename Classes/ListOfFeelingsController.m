//
//  ListOfFeelingsController.m
//  feelings
//
//  Created by Anthony Cardinale on 8/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ListOfFeelingsController.h"
#import "FeelingManager.h"

#import "Feeling.h"
#include <stdlib.h>


@implementation ListOfFeelingsController

- (id) init {
    if (self = [super initWithStyle:UITableViewStylePlain]) {
		shakeView = [[ShakingView alloc] init];
		shakeView.delegate = self;
		[self.view addSubview:shakeView];
		self.tabBarItem = [[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1] autorelease];
    }
    return self;
}

- (int)randomIntUpToNotIncluding:(int)maxnum {
	return arc4random() % (maxnum);	
}

- (void)scrollToIndex:(int)which {
	NSArray *feelings = [[FeelingManager sharedFeelings] feelings];
	if (which < feelings.count) {
		[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:which inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
		[[[UIApplication sharedApplication] delegate] feelingChanged:[[feelings objectAtIndex:which] valueForKey:@"name"] ];
	}
}

- (void) wasShaken {
	// get random number:
	NSArray *feelings = [[FeelingManager sharedFeelings] feelings];
	int randy = [self randomIntUpToNotIncluding:feelings.count];
	[self scrollToIndex:randy];
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [shakeView becomeFirstResponder];
}
- (void) viewWillDisappear:(BOOL)animated
{
    [shakeView resignFirstResponder];
    [super viewWillDisappear:animated];
}

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
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


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSMutableArray *)feelings {
    return [[FeelingManager sharedFeelings] feelings];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self feelings].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 387;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		CGRect f = cell.imageView.frame;
		f.origin.x = 0;
		f.origin.y = 0;
		f.size.width = 320;
		f.size.height = 387;
		cell.imageView.frame = f;
    }
    
    // Set up the cell...
	NSArray *feelings = [self feelings];
	if (indexPath.row < feelings.count) {
		Feeling *feeling = [feelings objectAtIndex:indexPath.row];
//		cell.textLabel.text = feeling.name
		cell.imageView.image = feeling.image;
		cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
	}
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
}


@end

