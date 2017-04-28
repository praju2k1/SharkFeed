//
//  SharkFeedUpdatingView.h
//  SharkFeed
//
//  Created by Prajeesh Prabhakar on 4/16/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//

#import <UIKit/UIKit.h>

// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


// *************************************************************************************************
#pragma mark -
#pragma mark Interface


@interface SharkFeedUpdatingView : UIView


// *************************************************************************************************
#pragma mark -
#pragma mark Properties


@property (nonatomic, strong, readonly ) UILabel *label;


// *************************************************************************************************
#pragma mark -
#pragma mark NSObject Overrides


// designated initializer
- (id)initWithText:(NSString *) text;


// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods


- (void)addToView:(UIView *)aView;
- (void)show:(BOOL)show;


@end
