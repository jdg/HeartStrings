//
//  ListOfFeelingsController.h
//  feelings
//
//  Created by Anthony Cardinale on 8/1/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "ShakingView.h"

@interface ListOfFeelingsController : UITableViewController {
	ShakingView *shakeView;
}
- (void) wasShaken ;
@end
