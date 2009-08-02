//
//  multicastViewController.h
//  multicast
//
//  Created by Jonathan George on 8/2/09.
//  Copyright JDG 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemoteFeelings.h"

@interface multicastViewController : UIViewController {
	IBOutlet UITextField *txtDataToSend;
	IBOutlet UITextView *log;
	IBOutlet UIImageView *imageView;
	RemoteFeelings *remoteFeelings;

	NSTimer *refreshTimer;
}

@property (nonatomic, retain) IBOutlet UITextField *txtDataToSend;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UITextView *log;

@property (nonatomic, retain) RemoteFeelings *remoteFeelings;

- (IBAction) send;

@end

