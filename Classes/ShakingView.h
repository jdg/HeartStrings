//
//  ShakingView.h
//  feelings
//
//  Created by Seth Raphael on 8/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShakingView : UIView {
	id delegate;
}
- (void) setDelegate: (id) newDelegate;
@end
