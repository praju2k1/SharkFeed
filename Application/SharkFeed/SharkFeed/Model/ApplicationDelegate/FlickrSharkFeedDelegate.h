//
//  AppDelegate.h
//  SharkFeed
//
//  Created by Prajeesh Prabhakar on 4/9/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


// *************************************************************************************************
#pragma mark -
#pragma mark Interface



@interface FlickrSharkFeedDelegate : UIResponder <UIApplicationDelegate>


// *************************************************************************************************
#pragma mark -
#pragma mark Properties


@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;


// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods


- (void)saveContext;


@end

