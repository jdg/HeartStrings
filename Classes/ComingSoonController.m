//
//  ComingSoonController.m
//  feelings
//
//  Created by Androidicus Maximus on 8/2/09.
//  Copyright 2009 Stone Design Corp. All rights reserved.
//

#import "ComingSoonController.h"


@implementation ComingSoonController


- (id)init {
 if (self = [super initWithNibName:nil bundle:nil]) {
	 self.tabBarItem = [[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:1] autorelease];
    }
    return self;
}


- (void)dealloc {
    [super dealloc];
}


@end
