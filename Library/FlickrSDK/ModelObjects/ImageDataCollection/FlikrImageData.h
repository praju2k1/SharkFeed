
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


static NSString *kPage = @"page";
static NSString *kPages = @"pages";
static NSString *kPerpage = @"perpage";
static NSString *kTotal = @"total";
static NSString *kPhoto = @"photo";


// *************************************************************************************************
#pragma mark -
#pragma mark Interface

@interface FlikrImageData : NSObject


// *************************************************************************************************
#pragma mark -
#pragma mark Public Property

@property (copy, readonly, nonatomic) NSNumber *page;
@property (copy, readonly, nonatomic) NSNumber *pages;
@property (copy, readonly, nonatomic) NSNumber *perPage;
@property (copy, readonly, nonatomic) NSNumber *total;
@property (copy, readonly, nonatomic) NSArray* photos;


- (id)initWithData:(NSDictionary *) data;

@end
