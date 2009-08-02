//
//  RemoteFeelings.m
//  multicast
//
//  Created by Jonathan George on 8/2/09.
//  Copyright 2009 JDG. All rights reserved.
//

#import "RemoteFeelings.h"


@implementation RemoteFeelings

@synthesize feelings;


- (id) init {
	if (self = [super init]) {
		NSMutableArray *fl = [[NSMutableArray alloc] init];
		self.feelings = fl;
		[fl release];
		lastFeelingId = @"0";
	}
	return self;
}

- (void) dealloc {
	self.feelings = nil;
	[super dealloc];
}

- (NSMutableArray *) loadNewFromRemote {
	NSString *error;
	NSPropertyListFormat format;
	id plist;

	NSString *requestString = [NSString stringWithFormat:@"http://idcfeelings.heroku.com/feelings?last_since_id=%@", lastFeelingId];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestString]];
	[request setHTTPMethod:@"GET"];
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

	plist = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&error];
	if (!plist) {
		NSLog(@"Error reading plist from file error = '%s'", [error UTF8String]);  
		[error release];
		return nil;
	}

	if ([plist count] > 0) {
		lastFeelingId = [[plist lastObject] objectForKey:@"id"];
		NSLog(@"Setting last feeling id: %@ - loaded %d", lastFeelingId, [plist count]);
	}

	[feelings addObjectsFromArray:plist];
	return [[plist retain] autorelease];
}

- (void) sendToRemote:(NSString *)feeling {
	NSLog(@"%@ sendToRemote: %@", self, feeling);

	NSString *requestString = [NSString stringWithFormat:@"&feeling[name]=%@", feeling];
	NSData *data = [NSData dataWithBytes:[requestString UTF8String] 
								  length:[requestString length]];

	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://idcfeelings.heroku.com/feelings"]];
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:data];

	[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
}

@end
