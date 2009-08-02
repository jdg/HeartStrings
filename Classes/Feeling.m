//
//  Feeling.m
//  feelings
//
//  Created by mary on 8/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Feeling.h"
#import "FeelingManager.h"

@implementation Feeling
@synthesize image, name, thumbnail;
- (UIImage *) image {
	if (!image) {
		self.image = [[FeelingManager sharedFeelings] imageWithName:self.name];
		
	}
	return image;
}

- (UIImage *)thumbnail {
	if (!thumbnail) {
		self.thumbnail = [[FeelingManager sharedFeelings] thumbnailImageForName:self.name];
	}
	return thumbnail;
}

- (Feeling *)initWithName:(NSString *)nombre {
	self = [super init];
	self.name = nombre;
	return self;
}

- (void) dealloc
{
	[image release];
	[name release];
	[thumbnail release];
	[super dealloc];
}

@end
