//
//  TiledFeelingsView.h
//  feelings
//
//  Created by Androidicus Maximus on 8/2/09.
//  Copyright 2009 Stone Design Corp. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TiledFeelingsView : UIView {
	IBOutlet id delegate;
}
@property (nonatomic, retain) id delegate;
@end
