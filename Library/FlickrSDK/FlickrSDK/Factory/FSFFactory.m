
//  Created by Prajeesh Prabhakar on 4/9/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import "FSFFactory.h"

#import "DetailPhotoInfo.h"
#import "FSFNetworkManager.h"


@interface FSFFactory()<FSFNetworkManagerDelegate>


@property (nonatomic, copy  , readwrite) void (^downloadSuccessfulBlock)(bool,NSError*);
@property (nonatomic, copy  , readwrite) void (^flikrImageDataBlock)(FlikrImageData *,NSError*);
@property (nonatomic, strong, readwrite) FSFNetworkManager* networkManager;
@property (nonatomic, assign, readwrite) NSInteger pageNumber;
@property (nonatomic, copy  , readwrite) void (^detailPhotoInfoBlock)(DetailPhotoInfo *,NSError*);


@end


// *************************************************************************************************
#pragma mark -
#pragma mark Implementation


@implementation FSFFactory


// *************************************************************************************************
#pragma mark -
#pragma mark Class Methods


+ (FSFFactory *)sharedInstance {
    
    static FSFFactory * sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [FSFFactory new];
    });
    
    return sharedInstance;
}


// *************************************************************************************************
#pragma mark -
#pragma mark NSObject Overrides

- (id)init {
    if (self = [super init]) {
        
        _downloadSuccessfulBlock = nil;
        _flikrImageDataBlock = nil;
        _networkManager = [[FSFNetworkManager alloc]init];
        _networkManager.delegate = self;
        _pageNumber = 1;
        _detailPhotoInfoBlock = nil;
    }
    
    return self;
}


// *************************************************************************************************
#pragma mark -
#pragma mark FSFFactoryDelegate Method



-(void)imageSavedToPhotosAlbum:(bool)isSuccessful WithError:(NSError *)error{
    
    self.downloadSuccessfulBlock(isSuccessful,error);
    
}


-(void) imageSearchReult:(FlikrImageData *) imageData withError:(NSError *) error{
    
    self.flikrImageDataBlock(imageData,error);
}


-(void) detailPhotoInfo:(DetailPhotoInfo *)detailPhotoInfo  withError:(NSError *) error{
    
    self.detailPhotoInfoBlock(detailPhotoInfo,error);
    
}


// *************************************************************************************************
#pragma mark -
#pragma mark Public method


-(void) downloadImage:(PhotoInfo *)photoInfo
          withCompletionHandler:(void(^)(bool,NSError*)) completionBlook{
    
    EXECUTE_BLOCK_ON_BACKGROUND_THREAD(^ {
        self.downloadSuccessfulBlock = completionBlook;
       
        [self.networkManager flickrImageDownloadWithPhotoInfo:photoInfo];
    });
}


-(void) getImageInfoWithPhotoID:(NSString *)photoID
          withCompletionHandler:(void(^)(DetailPhotoInfo *,NSError*)) completionBlook{
    
    EXECUTE_BLOCK_ON_BACKGROUND_THREAD(^ {
        self.detailPhotoInfoBlock = completionBlook;
        [self.networkManager filckrImageInfoRequestHandlerWithImageID:photoID];
    });
    
}



-(void) loadImagesForSearchText:(NSString *)searchText
          withCompletionHandler:(void(^)(FlikrImageData *,NSError*)) completionBlook {
    
    EXECUTE_BLOCK_ON_BACKGROUND_THREAD(^ {
        self.flikrImageDataBlock = completionBlook;
        [self.networkManager filckrSearchRequestHandlerWithSearchText:searchText andPageNumber:self.pageNumber];
    });
 

    self.pageNumber++;
    
}



-(void)setAPIKey:(NSString *)key{
    [self.networkManager apiKey: key];
}

@end
