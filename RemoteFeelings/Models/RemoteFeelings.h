//
//  RemoteFeelings.h
//  multicast
//
//  Created by Jonathan George on 8/2/09.
//  Copyright 2009 JDG. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RemoteFeelings : NSObject {
	NSString *lastFeelingId;
	NSMutableArray *feelings;
}

@property (nonatomic, retain) NSMutableArray *feelings;

- (NSMutableArray *) loadNewFromRemote;
- (void) sendToRemote:(NSString *)feeling;

@end
