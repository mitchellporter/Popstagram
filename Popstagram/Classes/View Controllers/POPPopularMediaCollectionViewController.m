//
//  POPPopularMediaCollectionViewController.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPPopularMediaCollectionViewController.h"
#import "POPInstagramNetworkingClient.h"
#import "POPMediaManager.h"
#import "POPMediaItem.h"
#import <MBProgressHUD.h>

@interface POPPopularMediaCollectionViewController ()

#pragma mark - Properties
@property (nonatomic) POPInstagramNetworkingClient *sharedPOPInstagramNetworkingClient;
@property (nonatomic) POPMediaManager *mediaManager;
@property (nonatomic) NSArray *mediaItems;
@property (nonatomic) MBProgressHUD *HUD;

@end

@implementation POPPopularMediaCollectionViewController

#pragma mark - View Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Execute various setup methods
    [self setupActivityIndicator];
    [self setupSharedPOPInstagramNetworkingClient];
    [self setupNotificationObservers];
    [self requestPopularMediaFromInstagram];
}

#pragma mark - Setup Methods
- (void)setupActivityIndicator
{
    //Setup and show activity indicator
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.mode = MBProgressHUDAnimationFade;
    [self.HUD show:YES];
}
- (void)setupNotificationObservers
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setupMediaManagerWithMediaDataInNotification:) name:@"RequestForPopularMediaSuccessful" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(displayAlertViewForUnsuccessfulRequestForPopularMediaNotification:) name:@"RequestForPopularMediaUnsuccessful" object:nil];
}

- (void)setupSharedPOPInstagramNetworkingClient
{
    //Setup shared networking client for Instagram
    self.sharedPOPInstagramNetworkingClient = [POPInstagramNetworkingClient sharedPOPInstagramNetworkingClient];
}

- (void)setupMediaManagerWithMediaDataInNotification:(NSNotification *)notification
{
    self.mediaManager = [[POPMediaManager alloc]initWithMediaData:[notification.userInfo objectForKey:@"requestForPopularMediaResults"]];

    [self requestMediaItemsFromMediaManager];
}

- (void)requestMediaItemsFromMediaManager
{
    //Create and fetch media items from media manager,
    //hude activity indicator, and reload collection view data
    self.mediaItems = [self.mediaManager createAndFetchMediaItemsWithTypeImage];
    [self.HUD hide:YES];
    [self.collectionView reloadData];
    
}

#pragma mark - Networking Methods
- (void)requestPopularMediaFromInstagram
{
    //Request popular media from Instagram
    [self.sharedPOPInstagramNetworkingClient requestPopularMedia];
}

#pragma mark - Error Handling
- (void)displayAlertViewForUnsuccessfulRequestForPopularMediaNotification:(NSNotification *)notification
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:[NSString stringWithFormat:@"There has been an error: %@", [notification.userInfo objectForKey:@"requestForPopularMediaResults"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.mediaItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Set cell identifier and grab reusable cell
    static NSString *cellIdentifier = @"cellId";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //Get current media item's thumbnailimage,
    //add to image view, and add image view as cell's subview
    //Now our cell displays our media item's thumbnail image
    UIImage *image = [self.mediaItems[indexPath.row]thumbnailImage];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [cell.contentView addSubview:imageView];
    
    return cell;
}

#pragma mark - Dealloc
- (void)dealloc
{
    //Remove class from notification center
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
     


@end
