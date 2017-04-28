//
//  ImageInfoViewController.m
//  SharkFeed
//
//  Created by PRABHAKAR, PRAJEESH on 4/14/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//



// *************************************************************************************************
#pragma mark -
#pragma mark Imports


#import "ImageInfoViewController.h"
#import "SharkFeedUpdatingView.h"

// *********************************************************************************************
#pragma mark -
#pragma mark Constants

static NSString * const IMAGE_INFO_DOWNLOADING = @"Downloading...";
static NSString * const IMAGE_INFO_SUCCESSFUL = @"Successful";
static NSString * const IMAGE_INFO_SUCCESSFUL_DOWNLOAD_MESSAGE = @"Image successfully saved to photo album";
static NSString * const IMAGE_INFO_FAILED = @"Failed";
static NSString * const IMAGE_INFO_OK = @"OK";

// *************************************************************************************************
#pragma mark -
#pragma mark Private Interface


@interface ImageInfoViewController ()

@property (strong, nonatomic, readwrite) PhotoInfo *photoInfo;
@property (weak  , nonatomic, readwrite) IBOutlet UIImageView *imageView;
@property (weak  , nonatomic, readwrite) IBOutlet UILabel *titleLable;
@property (strong, nonatomic, readwrite) SharkFeedUpdatingView *updatingView;


@end


// *************************************************************************************************
#pragma mark -
#pragma mark Implementation


@implementation ImageInfoViewController



// *************************************************************************************************
#pragma mark -
#pragma mark NSObject Overrides


- (id)init {
    if (self = [super init]) {
        
        _photoInfo = nil;
        _updatingView = nil;
    }
    
    return self;
}


- (void)dealloc{
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:PHOTO_DOWNLOAD_COMPLETED_NOTIFICATION object:nil];
}


// *************************************************************************************************
#pragma mark -
#pragma mark UIView Overrides


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSData *imageData = [NSData dataWithContentsOfURL:self.photoInfo.optimalURL];
    [self.imageView setImage: [UIImage imageWithData:imageData]];
    NSString *owner = APP_MANAGER.sharkFeedDataManager.detailPhotoInfo.realname;
    
    // Image Details
    NSString *details = nil;
    if (!!self.photoInfo.title ){
        details = self.photoInfo.title;
    }
    // Owner Deyails
    if (owner.length > 0 ){
        details = [NSString stringWithFormat:@"%@ By: %@",details, owner];
    }
    self.titleLable.text = details;
    
    // Register notiifcation for photo download
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(photoDownloadCompleteNotification:)
               name:PHOTO_DOWNLOAD_COMPLETED_NOTIFICATION
             object:nil];
    
    // Updating activity indicator
    self.updatingView = [[SharkFeedUpdatingView alloc] initWithText:IMAGE_INFO_DOWNLOADING];
    [self.updatingView addToView:self.view];

    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


// *************************************************************************************************
#pragma mark -
#pragma mark IBAction Methods

- (IBAction)handleDownload:(id)sender {
    [APP_MANAGER.sharkFeedDataManager downloadImageToCameraRoll:self.photoInfo];
    
    //Start showing activity indicator
    [self.updatingView show:YES];
}


- (IBAction)handleShowInFlikr:(id)sender {
    NSLog(@"Deep linking not implimted");
}


// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods


-(void)populatePhotoInfo:(PhotoInfo *) photoInfo{
    self.photoInfo = photoInfo;

}


// *************************************************************************************************
#pragma mark -
#pragma mark Private Notification Methods

- (void)photoDownloadCompleteNotification:(NSNotification *)notification {
    ENSURE_EXECUTION_ON_MAIN_THREAD(notification);
    
    //Stop showing activity indicator
    [self.updatingView show:NO];
    
    
    NSError *error =notification.object;
    
    NSString *message;
    NSString *title;
    
    if (!error) {
        title = NSLocalizedString(IMAGE_INFO_SUCCESSFUL, @"");
        message = NSLocalizedString(IMAGE_INFO_SUCCESSFUL_DOWNLOAD_MESSAGE, @"");
    } else {
        title = NSLocalizedString(IMAGE_INFO_FAILED, @"");
        message = [error description];
    }
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:NSLocalizedString(IMAGE_INFO_OK,@"")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    [alert addAction:noButton];
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
