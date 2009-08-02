//
//  feelingsAppDelegate.h
//  feelings
//
//  Created by mary on 8/1/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
@class multicastViewController;

@interface feelingsAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	multicastViewController *multicastGuy;
	
}

- (void)feelingChanged:(NSString *)feelingName;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
