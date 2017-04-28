
//  Created by PRABHAKAR, PRAJEESH on 4/10/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import <Foundation/Foundation.h>



// *************************************************************************************************
#pragma mark -
#pragma mark Constants


static NSString *kPhotoID   = @"id";
static NSString *kImageOwner= @"owner";
static NSString *kSecret    = @"secret";
static NSString *kServer    = @"server";
static NSString *kFarm      = @"farm";
static NSString *kTitle     = @"title";
static NSString *kURL_t     = @"url_t";
static NSString *kHeight_t  = @"height_t";
static NSString *kWidth_t   = @"width_t";
static NSString *kcontent   = @"_content";
static NSString *kURL_c     = @"url_c";
static NSString *kURL_l     = @"url_l";
static NSString *kURL_o     = @"url_o";

// *************************************************************************************************
#pragma mark -
#pragma mark Interface

@interface PhotoInfo : NSObject


// *************************************************************************************************
#pragma mark -
#pragma mark Public Property


@property (copy , readonly, nonatomic) NSString* farm;
@property (copy , readonly, nonatomic) NSString* photoID;
@property (copy , readonly, nonatomic) NSString* owner;
@property (copy , readonly, nonatomic) NSString* secretKey;
@property (copy , readonly, nonatomic) NSString* server;
@property (copy , readonly, nonatomic) NSString* title;
@property (copy , readonly, nonatomic) NSString* url_t;
@property (copy , readonly, nonatomic) NSString* url_c;
@property (copy , readonly, nonatomic) NSString* url_l;
@property (copy , readonly, nonatomic) NSString* url_o;
@property (copy , readonly, nonatomic) NSString* height;
@property (copy , readonly, nonatomic) NSString* width;
@property (copy , readonly, nonatomic) NSString* content;
@property (copy , readonly, nonatomic) NSURL* optimalURL;


- (id)initWithData:(NSDictionary *)data;


@end
