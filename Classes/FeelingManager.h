//
//  FeelingManager.h
//  feelings
//
//  Created by mary on 8/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Feeling;

@interface FeelingManager : NSObject {
	NSMutableArray *feelings;
	NSArray *sortedFeelingsDict;
}

@property (nonatomic, retain) NSMutableArray *feelings;
@property (nonatomic, retain) NSArray *sortedFeelingsDict;

+ (FeelingManager *)sharedFeelings;
- (NSMutableArray *)feelings;

- (NSArray *)sortedFeelingsDict;

- (UIImage *)imageWithName:(NSString *)shortName;
- (UIImage *)thumbnailImageForName:(NSString *)shortName;
- (Feeling *)feelingWithName:(NSString *)shortName;

@end
