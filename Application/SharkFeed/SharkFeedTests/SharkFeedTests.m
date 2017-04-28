//
//  SharkFeedTests.m
//  SharkFeedTests
//
//  Created by Prajeesh Prabhakar on 4/9/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FSFFactory.h"

@interface SharkFeedTests : XCTestCase

@property(nonatomic, strong, readwrite) FSFFactory *sharkFeedFactory;

@end

@implementation SharkFeedTests

- (void)setUp {
    [super setUp];
    
    _sharkFeedFactory = [FSFFactory sharedInstance];
}


-(void)testGetSharkImageInfoOnSearchKeyword{
    [self.sharkFeedFactory loadImagesForSearchText:@"Shark" withCompletionHandler:^(FlikrImageData * sharkData, NSError *error ) {
        
        XCTAssert(sharkData.photos.count > 0 );
    }];
}


-(void)testGetSharkImageAnyErrorOnSearchKeyWord{
    [self.sharkFeedFactory loadImagesForSearchText:@"Shark" withCompletionHandler:^(FlikrImageData * sharkData, NSError *error ) {
        
        XCTAssert(!(error.localizedDescription.length > 0 || error.code >0 ) );
    }];
}


    
-(void)testGetImageInfoForImageID {
    [self.sharkFeedFactory getImageInfoWithPhotoID:@"22337474460" withCompletionHandler:^(DetailPhotoInfo *details, NSError *error) {
        XCTAssert(!!details);
    }];
        
}

-(void)testGetImageInfoForImageIDWithAnyError {
    [self.sharkFeedFactory getImageInfoWithPhotoID:@"22337474460" withCompletionHandler:^(DetailPhotoInfo *details, NSError *error) {
         XCTAssert(!(error.localizedDescription.length > 0 || error.code >0 ) );
    }];
    
}

-(void)testPhotoDownload {
    __block PhotoInfo * photoInfo = nil;
    [self.sharkFeedFactory loadImagesForSearchText:@"Shark" withCompletionHandler:^(FlikrImageData * sharkData, NSError *error ) {
        
        if (sharkData.photos.count > 0){
            photoInfo =sharkData.photos[0];
        }
        else {
            XCTAssert(NO);
        }
    }];
    
    [self.sharkFeedFactory downloadImage:photoInfo withCompletionHandler:^(bool isSuccessful, NSError *error) {
        if (isSuccessful){
            XCTAssert(YES);
        }
        else {
            XCTAssert(NO);
        }
        
        if (!!error){
           XCTAssert(NO);
        }
    }];
     
}


@end
