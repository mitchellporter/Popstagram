//
//  POPTaggedMediaCollectionViewController.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/25/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPTaggedMediaCollectionViewController.h"
#import "POPInstagramNetworkingClient.h"
#import "POPMediaManager.h"
#import "POPMediaItem.h"
#import "POPMediaCollectionViewCell.h"
#import "POPTagTextField.h"
#import <MBProgressHUD.h>

#pragma mark - Cell Identifier
static NSString *cellIdentifier = @"cellId";

@interface POPTaggedMediaCollectionViewController () <UITextFieldDelegate>

#pragma mark - Properties
@property (nonatomic) POPInstagramNetworkingClient *sharedPOPInstagramNetworkingClient;
@property (nonatomic) POPMediaManager *mediaManager;
@property (nonatomic) NSArray *mediaItems;
@property (nonatomic) MBProgressHUD *HUD;
@property (nonatomic) POPTagTextField *tagTextField;

@end

@implementation POPTaggedMediaCollectionViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    
       //Execute various setup methods
    [self setupTabBarItem];
    //[self setupActivityIndicator];
    [self setupSharedPOPInstagramNetworkingClient];
    [self setupNotificationObservers];
    [self setupCollectionView];
    //[self requestPopularMediaFromInstagram];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Setup the hash tag text field
    [self setupTagTextField];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self.collectionViewLayout invalidateLayout];
}

#pragma mark - Setup Methods
- (void)setupTagTextField
{
    self.tagTextField = [[POPTagTextField alloc] initWithFrame:CGRectMake(0.0f, 50.0f, [UIScreen mainScreen].bounds.size.width, 60.0f)];
    self.tagTextField.delegate = self;
    [self.view addSubview:self.tagTextField];
    [self.tagTextField becomeFirstResponder];

}
- (void)setupTabBarItem
{
    self.tabBarItem.title = @"Popular";
    
}
- (void)setupActivityIndicator
{
    //Setup and show activity indicator
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.mode = MBProgressHUDAnimationFade;
    [self.HUD show:YES];
}
- (void)setupNotificationObservers
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setupMediaManagerWithMediaDataInNotification:) name:@"RequestForMediaWithTagSuccessful" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(displayAlertViewForUnsuccessfulRequestForPopularMediaNotification:) name:@"RequestForMediaWithTagUnsuccessful" object:nil];
}

- (void)setupCollectionView
{
    //Register for cell subclass and set background color
    [self.collectionView registerClass:[POPMediaCollectionViewCell class]
            forCellWithReuseIdentifier:cellIdentifier];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
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

#pragma mark - Media Manager Methods
- (void)requestMediaItemsFromMediaManager
{
    //Create and fetch media items from media manager,
    //hude activity indicator, and reload collection view data
    self.mediaItems = [self.mediaManager createAndFetchMediaItemsWithTypeImage];
    [self.HUD hide:YES];
    [self.collectionView reloadData];
    //[(POPMediaCollectionViewFlowLayout *)[self collectionViewLayout] resetLayout];
    
}

#pragma mark - Networking Methods
- (void)requestTaggedMediaFromInstagramWithTag:(NSString *)tag
{
    NSLog(@"bump");
    //Request popular media from Instagram with the passed tag
    [self.sharedPOPInstagramNetworkingClient requestMediaWithTag:tag];
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
    POPMediaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //Get current media item's thumbnailimage,
    //add to image view, and add image view as cell's subview
    //Now our cell displays our media item's thumbnail image
    UIImage *thumbnailImage = [self.mediaItems[indexPath.row]thumbnailImage];
    [cell.thumbnailImageView setImage:thumbnailImage];
    
    return cell;
}

#pragma mark - Delegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //Give up responder status and pass tag
    [textField resignFirstResponder];
    [self requestTaggedMediaFromInstagramWithTag:textField.text];
    
    return NO;
}

#pragma mark - Dealloc
- (void)dealloc
{
    //Remove class from notification center
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
