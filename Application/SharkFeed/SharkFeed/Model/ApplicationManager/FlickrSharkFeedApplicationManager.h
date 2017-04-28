//
//  FlickrSharkFeedApplicationManager.h
//  SharkFeed
//
//  Created by Prajeesh Prabhakar on 4/9/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import <Foundation/Foundation.h>
#import "FlickrSharkFeedDataManager.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Interface


@interface FlickrSharkFeedApplicationManager : NSObject


// *************************************************************************************************
#pragma mark -
#pragma mark Properties


@property (nonatomic, strong, readonly) FlickrSharkFeedDataManager *sharkFeedDataManager;



// *************************************************************************************************
#pragma mark -
#pragma mark Singleton Methods

+ (FlickrSharkFeedApplicationManager *)sharedInstance;

@end
