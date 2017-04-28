//
//  SharkFeedViewController.m
//  sharkfeed
//
//  Created by PRABHAKAR, PRAJEESH on 4/11/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports



#import "SharkFeedBaseViewController.h"



// *************************************************************************************************
#pragma mark -
#pragma mark Private Interface



@interface SharkFeedBaseViewController ()

@end

// *************************************************************************************************
#pragma mark -
#pragma mark Implementation



@implementation SharkFeedBaseViewController

// *************************************************************************************************
#pragma mark -
#pragma mark UIViewController Overrides

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self enableNaviagationBackgroundImage];
}



// *************************************************************************************************
#pragma mark -
#pragma mark Private method


-(void)enableNaviagationBackgroundImage{
    
    UIImage *NavigationPortraitBackground = [[UIImage imageNamed:IMAGE_NAVIFATION]
                                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)resizingMode:UIImageResizingModeStretch];
    
    UIImage *NavigationLandscapeBackground = [[UIImage imageNamed:IMAGE_NAVIFATION]
                                              resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    
    [[UINavigationBar appearance] setBackgroundImage:NavigationPortraitBackground forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:NavigationLandscapeBackground forBarMetrics:UIBarMetricsCompact ];

}


@end
