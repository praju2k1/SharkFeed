
//  Created by PRABHAKAR, PRAJEESH on 4/10/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//

#import "PhotoInfo.h"


@interface PhotoInfo()

@property (copy, nonatomic, readonly) NSDictionary* dataSource;

@end



@implementation PhotoInfo

// *************************************************************************************************
#pragma mark -
#pragma mark Getter Overrides


-(NSString *) farm{
    
    return [_dataSource objectForKey:kFarm];
}


-(NSString *) photoID{
    
    return [_dataSource objectForKey:kPhotoID];
}


-(NSString *) owner{
    
    return [_dataSource objectForKey:kImageOwner];
}


-(NSString *) secretKey{
    
    return [_dataSource objectForKey:kSecret];
}


-(NSString *) server{
    
    return [_dataSource objectForKey:kServer];
}


-(NSString *) title{
    
    return [_dataSource objectForKey:kTitle];
}

-(NSString *) url_t{
    
    return [_dataSource objectForKey:kURL_t];
}

-(NSString *) url_c{
    
    return [_dataSource objectForKey:kURL_c];
}

-(NSString *) url_l{
    
    return [_dataSource objectForKey:kURL_l];
}

-(NSString *) url_o{
    
    return [_dataSource objectForKey:kURL_o];
}


-(NSNumber* ) height{
    NSString *returnValue = [_dataSource objectForKey:kServer];
    return @([returnValue intValue]);
}


-(NSNumber * )width {
    NSString *returnValue = [_dataSource objectForKey:kTitle];
    return @([returnValue intValue]);
}


-(NSURL *) optimalURL{
    NSURL *optimalURL = nil;
    if (!!self.url_o){
        optimalURL = [NSURL URLWithString:self.url_o];

    }
    else if (!!self.url_l ){
        optimalURL = [NSURL URLWithString:self.url_l];
        
    }
    else if (!!self.url_c ){
        optimalURL = [NSURL URLWithString:self.url_c];
    }
    else if (!!self.url_t){
        optimalURL = [NSURL URLWithString:self.url_t];
        
    }

    return optimalURL;
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
