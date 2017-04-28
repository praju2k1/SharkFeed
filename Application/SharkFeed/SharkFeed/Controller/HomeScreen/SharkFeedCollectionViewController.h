//
//  ViewController.h
//  SharkFeed
//
//  Created by Prajeesh Prabhakar on 4/9/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import <UIKit/UIKit.h>

#import "FlickrSharkFeedDataManager.h"
#import "SharkFeedBaseViewController.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Interface


@interface SharkFeedCollectionViewController : SharkFeedBaseViewController < UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>



// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods


-(void)reloadFlikrData;

@end

