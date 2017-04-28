//
//  DetailPhotoInfo.m
//  FlickrSDK
//
//  Created by Prajeesh Prabhakar on 4/15/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports

#import "DetailPhotoInfo.h"



// *************************************************************************************************
#pragma mark -
#pragma mark Private Interface


@interface DetailPhotoInfo()

@property (copy, nonatomic, readonly) NSDictionary* dataSource;

@end


// *************************************************************************************************
#pragma mark -
#pragma mark  Implementation



@implementation DetailPhotoInfo


// *************************************************************************************************
#pragma mark -
#pragma mark Getter Overrides


-(NSString *) title{
    
    return [[_dataSource objectForKey:kDetailTitle]objectForKey:kContent];
}


-(NSString *)realname {
    return [[_dataSource objectForKey:kOwner]objectForKey:kRealname];
}


-(NSString *) photoURL{
    NSString *strURL = nil;
 
    // Getting Photo URL
    NSArray *anArray = [[_dataSource objectForKey:kPhotourls]objectForKey:kURL];
    if (anArray.count > 0 ){
        NSArray *filteredarray = [anArray filteredArrayUsingPredicate:
                                  [NSPredicate predicateWithFormat:@"(type == %@)", @"photopage"]];
        
        if (filteredarray.count > 0 ){
            NSDictionary *data = filteredarray[0];
            strURL =  [data objectForKey:kContent];
        }
    }
    return strURL;
}


// *************************************************************************************************
#pragma mark -
#pragma mark NSObject Overrides


- (id)initWithData:(NSDictionary *) data {
    if (self = [super init]) {
        _dataSource = data;
    }
    return self;
}


@end
