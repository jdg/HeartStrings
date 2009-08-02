//
//  ShakingView.m
//  feelings
//
//  Created by Seth Raphael on 8/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ShakingView.h"


@implementation ShakingView


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
        if ([delegate respondsToSelector:@selector(wasShaken)]) {
			[delegate performSelector:@selector(wasShaken)];
		}
    }
	
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}

- (void) setDelegate: (id) newDelegate {
	delegate = newDelegate;
}

- (BOOL)canBecomeFirstResponder
{ return YES; }


- (void)dealloc {
    [super dealloc];
}


@end
