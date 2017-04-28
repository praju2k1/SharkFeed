//
//  SharkFeedLaunchViewController.m
//  sharkfeed
//
//  Created by PRABHAKAR, PRAJEESH on 4/11/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//



// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import "SharkFeedLaunchViewController.h"

#import "SharkFeedCollectionViewController.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Private Interface


@interface SharkFeedLaunchViewController ()


@property (weak, nonatomic, readwrite) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic, readwrite) IBOutlet UIImageView *imageView;
@property (weak, nonatomic, readwrite) IBOutlet UIButton *launchButton;

@end



// *************************************************************************************************
#pragma mark -
#pragma mark Implementation



@implementation SharkFeedLaunchViewController



// *************************************************************************************************
#pragma mark -
#pragma mark NSObject Overrides




- (void)dealloc{
    
    // Remove Key value observer
    @try{
        [APP_MANAGER.sharkFeedDataManager removeObserver:self forKeyPath:KEY_PATH_SHARK_DATA];
    }
    @catch (NSException *exception) {}

}


// *************************************************************************************************
#pragma mark -
#pragma mark UIViewController Overrides



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set background image
    _imageView.image = [UIImage imageNamed:IMAGE_HOMESCREEN];
    [_launchButton setBackgroundImage:[UIImage imageNamed: IMAGE_HOME_BUTTON] forState:UIControlStateNormal];
    [_launchButton setBackgroundImage:[UIImage imageNamed: IMAGE_HOME_BUTTON] forState:UIControlStateSelected];
    
    // hide Activity Indicator
    self.activityIndicator.hidden = YES;
    
    //Adding KVO observes
    [APP_MANAGER.sharkFeedDataManager addObserver:self forKeyPath:KEY_PATH_SHARK_DATA options:NSKeyValueObservingOptionNew context:nil];
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //Stop activity indictor action
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:LAUNCH_HOME_SCREEN]) {
        UINavigationController *navController = (UINavigationController *) segue.destinationViewController;
        SharkFeedCollectionViewController *sharkFeedViewController = [navController.viewControllers firstObject];
        [sharkFeedViewController reloadFlikrData];
    }
 
}


// *************************************************************************************************
#pragma mark -
#pragma mark NSKeyValueObserving Methods


- (void)observeValueForKeyPath:(NSString *)aKeyPath
                      ofObject:(id)anObject
                        change:(NSDictionary *)aChange
                       context:(void *)aContext {
    
    if (anObject == APP_MANAGER.sharkFeedDataManager && [aKeyPath isEqualToString:KEY_PATH_SHARK_DATA]) {
        
        EXECUTE_BLOCK_ON_MAIN_THREAD( ^{
            [self performSegueWithIdentifier:LAUNCH_HOME_SCREEN sender:self];
            
        });
    }
    else {
        [super observeValueForKeyPath:aKeyPath ofObject:anObject change:aChange context:aContext];
    }
    
}
- (IBAction)handleLaunch:(id)sender {
    
    // Start animating activity indicator
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    
    //load shark Images
    [APP_MANAGER.sharkFeedDataManager loadSharkImages];
    
}


@end
