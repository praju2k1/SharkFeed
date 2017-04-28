//
//  DetailPhotoInfo.h
//  FlickrSDK
//
//  Created by Prajeesh Prabhakar on 4/15/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import <Foundation/Foundation.h>


// *************************************************************************************************
#pragma mark -
#pragma mark Constants


static NSString *kDetailTitle   = @"title";
static NSString *kOwner         = @"owner";
static NSString *kRealname      = @"realname";
static NSString *kContent       = @"_content";
static NSString *kPhotourls     = @"urls";
static NSString *kURL           = @"url";

// *************************************************************************************************
#pragma mark -
#pragma mark Interface


@interface DetailPhotoInfo : NSObject


// *************************************************************************************************
#pragma mark -
#pragma mark Public Property


@property (copy , readonly, nonatomic) NSString* title;
@property (copy , readonly, nonatomic) NSString* realname;
@property (copy , readonly, nonatomic) NSString* photoURL;

- (id)initWithData:(NSDictionary *)data;

@end
