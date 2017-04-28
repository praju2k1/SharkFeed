//
//  ViewController.m
//  SharkFeed
//
//  Created by Prajeesh Prabhakar on 4/9/17.
//  Copyright © 2017 Prajeesh Prabhakar. All rights reserved.
//

// *************************************************************************************************
#pragma mark -
#pragma mark Imports



#import "SharkFeedCollectionViewController.h"


#import "FlickrSharkFeedCollectionViewCell.h"
#import "ImageInfoViewController.h"
#import "SharkFeedUpdatingView.h"


// *********************************************************************************************
#pragma mark -
#pragma mark Constants


static NSString * const reuseIdentifier = @"sharkCell";
static NSString * const segueIdentifier = @"ImageInfo";
static NSString * const DATA_LOADING = @"Loading...";

// *************************************************************************************************
#pragma mark -
#pragma mark Private Interface


@interface SharkFeedCollectionViewController ()

@property (weak,  nonatomic, readwrite) IBOutlet UICollectionView *collectionView;
@property (weak,  nonatomic, readwrite) IBOutlet UICollectionViewFlowLayout *flowlayout;
@property (strong,nonatomic, readwrite) UIRefreshControl *refreshControl;
@property (strong,nonatomic, readwrite) PhotoInfo *selectedPhotoInfo;
@property (strong,nonatomic, readwrite) SharkFeedUpdatingView *updatingView;


@end



// *************************************************************************************************
#pragma mark -
#pragma mark Implementation


@implementation SharkFeedCollectionViewController



// *************************************************************************************************
#pragma mark -
#pragma mark NSObject Overrides


- (id)init {
    if (self = [super init]) {
        _refreshControl = nil;
        _selectedPhotoInfo = nil;
        _updatingView = nil;
        
    }
    
    return self;
}


- (void)dealloc{
    
    // Remove Key value observer 
    @try {
        [APP_MANAGER.sharkFeedDataManager removeObserver:self forKeyPath:KEY_PATH_DETAIL_PHOTO_INFO];
        [APP_MANAGER.sharkFeedDataManager removeObserver:self forKeyPath:KEY_PATH_SHARK_DATA];
    }
    @catch (NSException *exception) {}
}



// *************************************************************************************************
#pragma mark -
#pragma mark UIView Overrides

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // setting delegate and datasourece
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    // Adding Refresh control and reloading method
    _refreshControl = [[UIRefreshControl alloc]init];
    [self.collectionView addSubview:_refreshControl];
    [_refreshControl addTarget:self action:@selector(reloadCollectionView) forControlEvents:UIControlEventValueChanged];
    
    //Adding KVO observes
    [APP_MANAGER.sharkFeedDataManager addObserver:self forKeyPath:KEY_PATH_DETAIL_PHOTO_INFO options:NSKeyValueObservingOptionNew context:nil];
    [APP_MANAGER.sharkFeedDataManager addObserver:self forKeyPath:KEY_PATH_SHARK_DATA options:NSKeyValueObservingOptionNew context:nil];

    
    self.updatingView = [[SharkFeedUpdatingView alloc] initWithText:NSLocalizedString(DATA_LOADING, @"")];
    [self.updatingView addToView:self.view];

    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    if ([segue.identifier isEqualToString:segueIdentifier]) {
        ImageInfoViewController *imageInfoViewController = (ImageInfoViewController *) segue.destinationViewController;
        
  
        [imageInfoViewController populatePhotoInfo:sender];
    }
    
    
    
}

// *************************************************************************************************
#pragma mark -
#pragma mark NSKeyValueObserving Methods


- (void)observeValueForKeyPath:(NSString *)aKeyPath
                      ofObject:(id)anObject
                        change:(NSDictionary *)aChange
                       context:(void *)aContext {
    if (anObject == APP_MANAGER.sharkFeedDataManager && [aKeyPath isEqualToString:KEY_PATH_SHARK_DATA]) {
        
        EXECUTE_BLOCK_ON_MAIN_THREAD( ^{
            [self.refreshControl endRefreshing];
            [self.collectionView reloadData];
        });
    }

    else if (anObject == APP_MANAGER.sharkFeedDataManager && [aKeyPath isEqualToString:KEY_PATH_DETAIL_PHOTO_INFO]) {
        
        EXECUTE_BLOCK_ON_MAIN_THREAD (^{

            [self performSegueWithIdentifier:segueIdentifier sender:self.selectedPhotoInfo];
            [self.updatingView show:NO];
            
        });
    }
    else {
        [super observeValueForKeyPath:aKeyPath ofObject:anObject change:aChange context:aContext];
    }
    
}



// *************************************************************************************************
#pragma mark -
#pragma mark UICollectionViewDatasource Methods


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [APP_MANAGER.sharkFeedDataManager.sharkPhotos count];
}


- (FlickrSharkFeedCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FlickrSharkFeedCollectionViewCell * cell = [ collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    PhotoInfo * sharkPhoto = APP_MANAGER.sharkFeedDataManager.sharkPhotos[indexPath.row];
    
    //Setting image on collection view cell
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:sharkPhoto.url_t]];
    cell.imageview.image = [UIImage imageWithData:imageData];
    

    
    return cell;
}


// *************************************************************************************************
#pragma mark -
#pragma mark UICollectionViewDelegate Methods


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedPhotoInfo = APP_MANAGER.sharkFeedDataManager.sharkPhotos[indexPath.row];
    
    //Image details info call
    [APP_MANAGER.sharkFeedDataManager loadImageInfoForImageID:self.selectedPhotoInfo.photoID];
   
    [self.updatingView show:YES];
    
}


// *************************************************************************************************
#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout Methods


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size;
    
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) || ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown)) {
        size = CGSizeMake([UIScreen mainScreen].bounds.size.width /5,[UIScreen mainScreen].bounds.size.width /5);
    }
    else {
        size = CGSizeMake([UIScreen mainScreen].bounds.size.height /4,[UIScreen mainScreen].bounds.size.height /4);
    }
    
    return size;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return  UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2.0;
    
}

// *************************************************************************************************
#pragma mark -
#pragma mark Public Methods



-(void)reloadFlikrData{
    [self.collectionView reloadData];
}


// *************************************************************************************************
#pragma mark -
#pragma mark Private Methods

-(void)reloadCollectionView{
    
    // reloading shark images on pulling refresh control
    [APP_MANAGER.sharkFeedDataManager loadSharkImages];
}


@end
