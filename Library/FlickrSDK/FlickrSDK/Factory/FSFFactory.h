
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
#pragma mark Interface



@interface FSFFactory : NSObject


// *************************************************************************************************
#pragma mark -
#pragma mark Factory Instance


+ (FSFFactory*)sharedInstance;


// *************************************************************************************************
#pragma mark -
#pragma mark Public Interfaces


/**
 * This API is can be used  to download photo with PhotoInfo.
 
 * @param photoInfo a PhotoInfo representation Photo details.
 * @param completionBlook retuns downloaded image or Error.
 *
 *
 * @see FSFFactory
 * @see PhotoInfo
 */
-(void) downloadImage:(PhotoInfo *)photoInfo
withCompletionHandler:(void(^)(bool,NSError*)) completionBlook;



/**
 * This API is used to get information about a photo with a photo id.
 
 * @param photoID a NSString representation photo id.
 * @param completionBlook retuns Images Info for given ImageID or Error.
 *
 *
 * @see FSFFactory
 * @see FlikrImageData
 */
-(void) getImageInfoWithPhotoID:(NSString *)photoID
          withCompletionHandler:(void(^)(DetailPhotoInfo *,NSError*)) completionBlook;




/**
 * This API is used for list of Images on serch criteria.

 * @param searchText a NSString representation search text.
 * @param completionBlook retuns Images collection for the Search criteria or Error.
 *
 *
 * @see FSFFactory  
 * @see FlikrImageData
 */
-(void) loadImagesForSearchText:(NSString *)searchText
          withCompletionHandler:(void(^)(FlikrImageData *,NSError*)) completionBlook;



/**
 * This API is used set user key .
 * @param key a NSString representation user key .
 *
 * @see FSFFactory
 */
-(void)setAPIKey:(NSString *)key;



@end
