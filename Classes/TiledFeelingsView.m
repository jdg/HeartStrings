//
//  TiledFeelingsView.m
//  feelings
//
//  Created by Androidicus Maximus on 8/2/09.
//  Copyright 2009 Stone Design Corp. All rights reserved.
//

#import "TiledFeelingsView.h"
#import "FeelingManager.h"
#import "Feeling.h"


@implementation TiledFeelingsView



/*
- (void)drawRect:(CGRect)rect {
//	if (feelings.count != self.subviews.count) {
//		
//	}
//	unsigned i, cnt = feelings.count;
	int rowcount, colcount;
	int r, c;
	FeelingManager *fm = [FeelingManager sharedFeelings];
	NSArray *sortedFeelingsDict = [fm sortedFeelingsDict];
	if (1 ) {
		rowcount = 7;
		colcount = 6;
	}
#define IM_SIZE	50
#define INTER_X 3
#define INTER_Y 3
#define Y_TOP 40
	for (r = 0; r < rowcount; r++) {
		NSArray *row = [[sortedFeelingsDict objectAtIndex:r] valueForKey:@"feelings"];
		for (c = 0; c < colcount; c++) {
			NSString *name = [row objectAtIndex:c];
			
			CGPoint p = CGPointMake(c * (IM_SIZE) + (c + 1) * INTER_X, (r * IM_SIZE) + (r + 1)* INTER_Y + Y_TOP);
			UIImage *im = [[fm feelingWithName:name] thumbnail];
			[im drawAtPoint:p];
		}
	}
	
}
*/
#define ROW_COUNT 7
#define COL_COUNT 6
- (NSString *)nameForRow:(int)r column:(int)col {
	FeelingManager *fm = [FeelingManager sharedFeelings];
	NSArray *sortedFeelingsDict = [fm sortedFeelingsDict];
	if (r < sortedFeelingsDict.count) {
		NSArray *row = [[sortedFeelingsDict objectAtIndex:r] valueForKey:@"feelings"];
		if (col < row.count) {
			NSString *name = [row objectAtIndex:col];
			return name;
		}
	} else NSLog(@"%d, %d not there??", r, col);
	return nil;
}
- (NSString *)nameForIndex:(int)index {
	return [self nameForRow:index / ROW_COUNT column:index % ROW_COUNT];
}


- (IBAction)buttonTapped:(UIButton *)sender {
	int index = [self.subviews indexOfObject:sender];
	NSString *name = [self nameForIndex:index];
	if (name) [delegate feelingTapped:name];
	
}

- (void)updateFeelings {
//	//	unsigned i, cnt = feelings.count;
	int rowcount, colcount;
	int r, c;
	FeelingManager *fm = [FeelingManager sharedFeelings];
	NSArray *sortedFeelingsDict = [fm sortedFeelingsDict];
	if (1 /*cnt == 42*/) {
		rowcount = ROW_COUNT;
		colcount = COL_COUNT;
	}
#define IM_SIZE	50
#define INTER_X 3
#define INTER_Y 3
#define Y_TOP 40
	for (r = 0; r < rowcount; r++) {
		NSArray *row = [[sortedFeelingsDict objectAtIndex:r] valueForKey:@"feelings"];
		for (c = 0; c < colcount; c++) {
			NSString *name = [row objectAtIndex:c];
			
			CGPoint p = CGPointMake(c * (IM_SIZE) + (c + 1) * INTER_X, (r * IM_SIZE) + (r + 1)* INTER_Y + Y_TOP);
			UIImage *im = [[fm feelingWithName:name] thumbnail];
			UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
			b.frame = CGRectMake(p.x, p.y, IM_SIZE, IM_SIZE);
			[b setImage:im forState:UIControlStateNormal];
			[b addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
			[self addSubview:b];
			
//			[im drawAtPoint:p];
		}
	}
	
}



- (void)dealloc {
    [super dealloc];
}


@end
