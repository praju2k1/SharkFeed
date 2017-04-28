//
//  DVRSharkFeedSDKManager.m
//  SharkFeed
//
//  Created by Prajeesh Prabhakar on 4/9/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import "FlickrSharkFeedDataManager.h"



// *************************************************************************************************
#pragma mark -
#pragma mark Constants

//Serach String for flikcr API
#define FLICKR_PHOTO_SEARCH_STRING @"sharkPhotos"


// *************************************************************************************************
#pragma mark -
#pragma mark Private Interface


@interface FlickrSharkFeedDataManager()


@property(nonatomic, strong, readwrite) DetailPhotoInfo *detailPhotoInfo;
@property(nonatomic, strong, readwrite) FSFFactory *sharkFeedFactory;
@property(nonatomic, strong, readwrite) NSArray *sharkPhotos;


@end


// *************************************************************************************************
#pragma mark -
#pragma mark Implementation


@implementation FlickrSharkFeedDataManager



// *************************************************************************************************
#pragma mark -
#pragma mark NSObject Overrides

- (id)init {
    if (self = [super init]) {
        
        _sharkFeedFactory = [FSFFactory sharedInstance];
        _sharkPhotos = nil;
        
    }

    return self;
}



// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods


-(void)downloadImageToCameraRoll:(PhotoInfo *) PhotoInfo{
    [self.sharkFeedFactory downloadImage:PhotoInfo withCompletionHandler:^(bool isSuccessful, NSError * error) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:PHOTO_DOWNLOAD_COMPLETED_NOTIFICATION object:error];
    } ];
}



-(void)loadSharkImages{

    // Setting the "Shark" As search criteria
     [self.sharkFeedFactory loadImagesForSearchText:FLICKR_PHOTO_SEARCH_STRING withCompletionHandler:^(FlikrImageData * sharkData, NSError *error ) {
       if (!!sharkData){
           // filter out the photo data set that has a url
           NSString *predicate = @"url_t.length > 0";
           NSPredicate *predicateWithImageURL = [NSPredicate predicateWithFormat:predicate];
           self.sharkPhotos = [sharkData.photos filteredArrayUsingPredicate:predicateWithImageURL];
       }
     }];

}


-(void)loadImageInfoForImageID:(NSString *)imageID{
    // get image details for photo id 
    [self.sharkFeedFactory getImageInfoWithPhotoID:imageID withCompletionHandler:^(DetailPhotoInfo *detailPhotoInfo, NSError *error) {
        if(!!detailPhotoInfo){
            self.detailPhotoInfo = detailPhotoInfo;
        }
        
    }];
}

-(void)populateAPIKey:(NSString *)ApiKey{
    [self.sharkFeedFactory setAPIKey:ApiKey];
}


@end
