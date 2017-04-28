//
//  FlickrSharkFeedApplicationManager.m
//  SharkFeed
//
//  Created by Prajeesh Prabhakar on 4/9/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import "FlickrSharkFeedApplicationManager.h"




// *************************************************************************************************
#pragma mark -
#pragma mark Private Interface


@interface FlickrSharkFeedApplicationManager ()

@property (nonatomic, strong, readwrite) FlickrSharkFeedDataManager *sharkFeedDataManager;



@end


// *************************************************************************************************
#pragma mark -
#pragma mark Implementation


@implementation FlickrSharkFeedApplicationManager


// *************************************************************************************************
#pragma mark -
#pragma mark Singleton Methods


+ (FlickrSharkFeedApplicationManager *)sharedInstance {
    
    static FlickrSharkFeedApplicationManager * sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [FlickrSharkFeedApplicationManager new];
    });
    
    return sharedInstance;
}


// *************************************************************************************************
#pragma mark -
#pragma mark NSObject Overrides

- (id)init {
    if (self = [super init]) {
        
        
        // Instantiating and setting API key
        _sharkFeedDataManager = [[FlickrSharkFeedDataManager alloc] init];
        
        // set the API KEY
        [_sharkFeedDataManager populateAPIKey:@"949e98778755d1982f537d56236bbb42"];
        

    }
    
    return self;
}

@end
