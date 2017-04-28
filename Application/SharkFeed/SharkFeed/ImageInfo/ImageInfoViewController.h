//
//  ImageInfoViewController.h
//  SharkFeed
//
//  Created by PRABHAKAR, PRAJEESH on 4/14/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import <UIKit/UIKit.h>

#import "SharkFeedBaseViewController.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Interface

@interface ImageInfoViewController : SharkFeedBaseViewController


// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods


-(void)populatePhotoInfo:(PhotoInfo *) photoInfo;


@end
