
//  Created by Prajeesh Prabhakar on 4/9/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import "FSFNetworkManager.h"

#import <UIKit/UIKit.h>

#import "DetailPhotoInfo.h"
#import "FlikrImageData.h"
#import "PhotoInfo.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Constants

NSString *const baseURL = @"https://api.flickr.com/services/rest/?";
NSString *const searchMethord = @"flickr.photos.search";
NSString *const getInfoMethord = @"flickr.photos.getInfo";


// *************************************************************************************************
#pragma mark -
#pragma mark Private Interface


@interface FSFNetworkManager()
    
@property (strong,nonatomic,readwrite) NSURLSession *urlSession;
@property (copy  ,nonatomic, readwrite) NSString *apiKey;


@end


// *************************************************************************************************
#pragma mark -
#pragma mark Implementation



@implementation FSFNetworkManager



// *************************************************************************************************
#pragma mark -
#pragma mark NSObject Overrides

- (id)init {
    if (self = [super init]) {
        _apiKey = nil;
        _urlSession = [NSURLSession sharedSession];
    }
    return self;
}


// *************************************************************************************************
#pragma mark -
#pragma mark Public Method


-(void) flickrImageDownloadWithPhotoInfo:(PhotoInfo *) photoInfo{
    NSURL *URL = [photoInfo optimalURL];
    NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession]downloadTaskWithURL:URL
                                                                                 completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
            UIImageWriteToSavedPhotosAlbum(downloadedImage, self, @selector(didImageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);
    }];
    [downloadPhotoTask resume];
}



-(void) filckrImageInfoRequestHandlerWithImageID:(NSString *)imageID{
    
    NSURL *URL = [self generateURLRequestForImageInfoWithImageID:imageID];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    // URL Sesstion call
    NSURLSessionDataTask *task = [self.urlSession dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //JSON serialisation
        NSDictionary *sharkData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                        
        //lazy loading of data                                                     
        DetailPhotoInfo *detailPhotInfo = [[DetailPhotoInfo alloc] initWithData:[sharkData objectForKey:PHOTO_NETWORK_MANAGER]];
        
        //Make a delegate call on NSURLSession call back
        if ([self.delegate respondsToSelector:@selector(detailPhotoInfo:withError:)]) {
            [self.delegate detailPhotoInfo:detailPhotInfo withError:error];
        
        }
        
    }];
    
    [task resume];
    
}


-(void) filckrSearchRequestHandlerWithSearchText:(NSString *)searchText andPageNumber:(NSInteger)pageNumber{
    
    NSURL *URL = [self generateURLRequestForSearchWithSearchText:searchText andPageNumber:pageNumber];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
   
    // URL Sesstion call 
    NSURLSessionDataTask *task = [self.urlSession dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //JSON serialisation
        NSDictionary *sharkData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        //lazy loading of data
        FlikrImageData *imageData = [[FlikrImageData alloc] initWithData:[sharkData objectForKey:PHOTOS_NETWORK_MANAGER]];
        
        //Make a delegate call on NSURLSession call back
        if ([self.delegate respondsToSelector:@selector(imageSearchReult:withError:)]) {
                [self.delegate imageSearchReult:imageData withError:error];
        }
    }];
    
    [task resume];
    
}


-(void)apiKey:(NSString *) apiKey{
    self.apiKey = apiKey;
}



// *************************************************************************************************
#pragma mark -
#pragma mark Private Method


-(void) didImageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    //Make a delegate call on Image Save satus to Photo Album
    if ([self.delegate respondsToSelector:@selector(imageSavedToPhotosAlbum:WithError:)]) {
        if (!error ){
            [self.delegate imageSavedToPhotosAlbum:YES WithError:error];
        }
        else {
            [self.delegate imageSavedToPhotosAlbum:NO WithError:error];
        }
        
    }

}


-(NSURL *)generateURLRequestForImageInfoWithImageID:(NSString*)imageID {
    NSString *strURL =
    [NSString stringWithFormat:@"%@method=%@&api_key=%@&photo_id=%@&format=json&nojsoncallback=1",baseURL,getInfoMethord,self.apiKey,imageID];
    
    return [NSURL URLWithString:strURL];
}


-(NSURL *)generateURLRequestForSearchWithSearchText:(NSString*)searchText andPageNumber:(NSInteger) pageNumber{
    NSString *strURL =
    [NSString stringWithFormat:@"%@method=%@&api_key=%@&text=%@&format=json&nojsoncallback=1&page=%ld&extras=url_t,url_c,url_l,url_o",baseURL,searchMethord,self.apiKey,searchText,(long)pageNumber];
    
    return [NSURL URLWithString:strURL];
}



@end
