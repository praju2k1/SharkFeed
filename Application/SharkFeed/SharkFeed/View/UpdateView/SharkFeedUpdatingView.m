//
//  SharkFeedUpdatingView.m
//  SharkFeed
//
//  Created by Prajeesh Prabhakar on 4/16/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//

#import "SharkFeedUpdatingView.h"

// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import "SharkFeedUpdatingView.h"


// *************************************************************************************************
#pragma mark -
#pragma mark Private Interface


@interface SharkFeedUpdatingView ()


@property (nonatomic, strong, readwrite) UILabel *label;


@end


// *************************************************************************************************
#pragma mark -
#pragma mark Implementation


@implementation SharkFeedUpdatingView


// *************************************************************************************************
#pragma mark -
#pragma mark NSObject Overrides


- (id)initWithText:(NSString *) text {
    if (self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 125.0f, 50.0f)]) {
        // create the background image view
        UIImage *image = [UIImage imageNamed:IMAGE_BACKGROUND_NETWORK];
        image = [image stretchableImageWithLeftCapWidth:30.0f topCapHeight:30.0f];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.image = image;
        [self addSubview:imageView];
        
        // create the activity label
        UIActivityIndicatorView *activityIndicator =
        [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityIndicator.frame = [self newFrame:activityIndicator.frame origin:CGPointMake(13.0f, 15.0f)];
        //[activityIndicator dtvSetFrameOrigin:CGPointMake(13.0f, 15.0f)];
        [activityIndicator startAnimating];
        [self addSubview:activityIndicator];
        
        // create the label
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.text = text;
        _label.font = [UIFont boldSystemFontOfSize:12.0f];
        _label.textColor = [UIColor whiteColor];
        _label.backgroundColor = [UIColor clearColor];
        [_label sizeToFit];
        _label.frame = [self newFrame:_label.frame origin:CGPointMake(CGRectGetMaxX(activityIndicator.frame) + 10.0f, 18.0f)];
        [self addSubview:_label];
        
        self.alpha = 0.0f; // start out hidden
    }
    
    return self;
}


// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods


- (void)addToView:(UIView *)aView {
    // position the view in the bottom left corner and add it to the given view
    self.autoresizingMask =
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    
    self.frame = [self newFrame:self.frame origin:CGPointMake(
                                                              5.0f,
                                                              aView.frame.size.height - self.frame.size.height - 5.0f
                                                              )];
    
    [aView addSubview:self];
}


- (void)show:(BOOL)show {
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (!!weakSelf) {
            weakSelf.alpha = show ? 1.0f : 0.0f;
        }
    }];
}

// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods

- (CGRect)newFrame:(CGRect)rect origin:(CGPoint)aPoint {
    CGRect newFrame = rect;
    newFrame.origin = aPoint;
    
    
    return newFrame;
    
}
@end
