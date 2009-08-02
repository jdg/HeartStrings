//
//  multicastViewController.m
//  multicast
//
//  Created by Jonathan George on 8/2/09.
//  Copyleft JDG 2009. NO rights reserved.
//

#import "multicastViewController.h"
#import "FeelingManager.h"

@implementation multicastViewController

@synthesize txtDataToSend, log, imageView, remoteFeelings;

- (id)init {
    if (self = [super initWithNibName:nil bundle:nil]) {
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Friends" image:[UIImage imageNamed:@"public.png"] tag:2] autorelease];

		RemoteFeelings *rf = [[RemoteFeelings alloc] init];
		self.remoteFeelings = rf;

		// Hit the server every 5 seconds, to request new feelings.
		refreshTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
	}
    return self;
}

- (void)setMainImageForName:(NSString *)name {
	if (!name) name = @"Happy";
	[imageView setImage:[[FeelingManager sharedFeelings] imageWithName:name]];
}

- (void)viewDidLoad {
	[super viewDidLoad];

	NSString *s = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastfeeling"];
    [self setMainImageForName:s];
}

- (void)dealloc {
	[refreshTimer invalidate];
	[remoteFeelings release];

	self.txtDataToSend = nil;
	self.log = nil;
	self.imageView = nil;
	[super dealloc];
}

- (IBAction) send {
	[remoteFeelings sendToRemote:txtDataToSend.text];
}

- (void) refresh {
	// Will potentially return nil (if an error), or an empty array.
	// The next time it's called, you will not receive any old feelings.  Only new ones
	// since the last call.
	NSMutableArray *feelings = [remoteFeelings loadNewFromRemote];
	if (feelings.count) {
		NSDictionary *d = [feelings lastObject];
		NSString *name = [d valueForKey:@"name"];
		if (name) [self setMainImageForName:name];
	}
	
}

@end
