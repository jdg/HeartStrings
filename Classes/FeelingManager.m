//
//  FeelingManager.m
//  feelings
//
//  Created by mary on 8/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FeelingManager.h"
#import "Feeling.h"


@implementation FeelingManager
@synthesize feelings, sortedFeelingsDict;

- (NSString *)feelingsPath {
	return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ourfeelings"];
}
- (NSString *)thumbsPath {
	return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"thumbs"];
}

- (UIImage *)imageWithName:(NSString *)shortName {
	NSString *path = [NSString stringWithFormat:@"%@/%@.png", [self feelingsPath], shortName];
	
	return [UIImage imageWithContentsOfFile:path];
}

- (UIImage *)thumbnailImageForName:(NSString *)shortName {
	NSString *path = [NSString stringWithFormat:@"%@/%@-t.png", [self thumbsPath], shortName];
	
	return [UIImage imageWithContentsOfFile:path];
}


- (NSMutableDictionary *)propertyListWithData:(NSData *)data {
    NSString * errorString = nil;
	NSPropertyListFormat format;	
	NSMutableDictionary *dict = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&errorString];
	if (errorString) NSLog(errorString);
	return dict;
}

- (NSDictionary *)getSortedFeelings {
	NSString *path = [[NSBundle mainBundle] pathForResource:@"Feelings" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
	return [self propertyListWithData:data];
}

- (Feeling *)feelingWithName:(NSString *)shortName {
	for (Feeling *f in feelings) if ([f.name isEqualToString:shortName]) return f;
	return nil;
}

- (void)scanForFeelings {
	NSFileManager *fm = [NSFileManager defaultManager];
	NSString *path = [self feelingsPath];
	NSArray *folders = [fm directoryContentsAtPath:path];
	
	feelings = [[NSMutableArray alloc] initWithCapacity:folders.count];
	for (NSString *imageFile in folders) {
		NSString *name = [imageFile stringByDeletingPathExtension];
		Feeling *feeling = [[[Feeling alloc]initWithName:name] autorelease];
		[feelings addObject:feeling];
	}
	
	self.sortedFeelingsDict = [self getSortedFeelings];
}
	
	


+ (FeelingManager *)sharedFeelings {
	static FeelingManager *manager=nil;
	if (!manager) {
		manager=[[self alloc] init];
		[manager scanForFeelings];
	}
	return manager;
}	

@end
