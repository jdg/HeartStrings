//
//  FirstViewController.h
//  feelings
//
//  Created by mary on 8/1/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController : UIViewController {
	IBOutlet UIToolbar *topToolBar;
	IBOutlet UIBarButtonItem *titleItem;
}
- (void)feelingTapped:(NSString *)name;

@property (nonatomic, retain) IBOutlet UIToolbar *topToolBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *titleItem;
@end
