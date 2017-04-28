
//  Created by Prajeesh Prabhakar on 4/9/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import <Foundation/Foundation.h>

#import "DetailPhotoInfo.h"
#import "FlikrImageData.h"
#import "PhotoInfo.h"



// *************************************************************************************************
#pragma mark -
#pragma mark Protocol



@protocol FSFNetworkManagerDelegate <NSObject>

@required

-(void)imageSavedToPhotosAlbum:(bool)isSuccessful WithError:(NSError *)error;
-(void)imageSearchReult:(FlikrImageData *) imageData withError:(NSError *) error;
-(void)detailPhotoInfo:(DetailPhotoInfo *)detailPhotoInfo  withError:(NSError *) error;

@end



// *************************************************************************************************
#pragma mark -
#pragma mark Interface


@interface FSFNetworkManager : NSObject<NSURLSessionDelegate>


// *************************************************************************************************
#pragma mark -
#pragma mark Public Property


@property (nonatomic, weak  , readwrite)  NSObject<FSFNetworkManagerDelegate>* delegate;


// *************************************************************************************************
#pragma mark -
#pragma mark Public Method


- (void)flickrImageDownloadWithPhotoInfo:(PhotoInfo *)photoInfo;
- (void)filckrImageInfoRequestHandlerWithImageID:(NSString *)imageID;
- (void)filckrSearchRequestHandlerWithSearchText:(NSString *)searchText
                                   andPageNumber:(NSInteger)pageNumber;
- (void)apiKey:(NSString *) apiKey;



@end
