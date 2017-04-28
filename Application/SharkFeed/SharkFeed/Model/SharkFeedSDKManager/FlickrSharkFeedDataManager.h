//
//  DVRSharkFeedSDKManager.h
//  SharkFeed
//
//  Created by Prajeesh Prabhakar on 4/9/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import <Foundation/Foundation.h>

#import "FSFFactory.h"
#import "PhotoInfo.h"

// *************************************************************************************************
#pragma mark -
#pragma mark Constants


#define KEY_PATH_SHARK_DATA @"sharkPhotos"
#define KEY_PATH_DETAIL_PHOTO_INFO @"detailPhotoInfo"
#define PHOTO_DOWNLOAD_COMPLETED_NOTIFICATION @"photoDownloadCompledNotofication"


// *************************************************************************************************
#pragma mark -
#pragma mark Interface


@interface FlickrSharkFeedDataManager : NSObject


// *************************************************************************************************
#pragma mark -
#pragma mark Public Property

@property(nonatomic, strong, readonly) DetailPhotoInfo *detailPhotoInfo;
@property(nonatomic, strong, readonly) NSArray *sharkPhotos;


// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods


-(void)downloadImageToCameraRoll:(PhotoInfo *)PhotoInfo;
-(void)loadImageInfoForImageID:(NSString *)imageID;
-(void)loadSharkImages;
-(void)populateAPIKey:(NSString *)ApiKey;


@end
