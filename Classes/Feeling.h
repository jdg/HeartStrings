//
//  Feeling.h
//  feelings
//
//  Created by mary on 8/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Feeling : NSObject {
	NSString *name;
	UIImage *image;
	UIImage *thumbnail;
// audio soundId

}
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) UIImage *thumbnail;

- (Feeling *)initWithName:(NSString *)nombre;

@end
