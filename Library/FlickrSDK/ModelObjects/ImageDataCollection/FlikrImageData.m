
//  Created by PRABHAKAR, PRAJEESH on 4/10/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//


// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import "FlikrImageData.h"
#import "PhotoInfo.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Private Interface


@interface FlikrImageData()
    
@property (copy, nonatomic, readonly) NSDictionary* dataSource;

@end


// *************************************************************************************************
#pragma mark -
#pragma mark  Implementation


@implementation FlikrImageData


// *************************************************************************************************
#pragma mark -
#pragma mark Getter Overrides


-(NSNumber *) page {
    NSString *returnValue = [_dataSource objectForKey:kPage];
    return  @([returnValue intValue]);
}

-(NSNumber *) pages {
    NSString *returnValue = [_dataSource objectForKey:kPages];
    return  @([returnValue intValue]);
}

-(NSNumber *) perPage {
    NSString *returnValue = [_dataSource objectForKey:kPerpage];
    return  @([returnValue intValue]);
}


-(NSNumber *) total {
    NSString *returnValue = [_dataSource objectForKey:kTotal];
    return  @([returnValue intValue]);
}

-(NSArray *) photos {
    NSArray* rowData = [_dataSource objectForKey:kPhoto];
    NSMutableArray *photoArray = [NSMutableArray array];
    
    for(NSDictionary *row in rowData){
        PhotoInfo * photo = [[PhotoInfo alloc]initWithData:row];
        [photoArray addObject: photo];
    }
    
    return photoArray;
    
   
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
