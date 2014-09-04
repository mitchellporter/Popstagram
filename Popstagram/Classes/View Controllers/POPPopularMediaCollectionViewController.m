//
//  POPPopularMediaCollectionViewController.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPPopularMediaCollectionViewController.h"
#import "POPInstagramNetworkingClient.h"
#import "POPMediaItem.h"
#import "POPMediaCollectionViewCell.h"
#import "POPMediaCollectionViewFlowLayout.h"
#import "POPMediaDisplayViewController.h"
#import <MBProgressHUD.h>

#pragma mark - Cell Identifier
static NSString *cellIdentifier = @"cellId";

@interface POPPopularMediaCollectionViewController ()

#pragma mark - Properties
@property (nonatomic) POPInstagramNetworkingClient *sharedPOPInstagramNetworkingClient;
@property (nonatomic) NSArray *mediaItems;
@property (nonatomic) MBProgressHUD *HUD;
@property (nonatomic) POPMediaDisplayViewController *mediaDisplayViewController;

@end

@implementation POPPopularMediaCollectionViewController


#pragma mark - View Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Execute various setup methods
    [self setupTabBarAppearance];
    [self setupTabBarItem];
    [self setupNavigationElements];
    [self setupActivityIndicator];
    [self setupSharedPOPInstagramNetworkingClient];
    [self setupCollectionView];
    [self requestPopularMediaFromInstagram];
}

#pragma mark - Setup Methods
- (void)setupTabBarAppearance
{
    //This sets the color for the tab bar items
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:0.169 green:0.353 blue:0.514 alpha:1];
}

- (void)setupTabBarItem
{
    //This sets up the tab bar items for BOTH tabs
    //This is necessary because by default any tabs after the first will not be set until tapped
    //and we want all tab bar items finalized at the same time
    [[self.tabBarController.viewControllers objectAtIndex:0]tabBarItem].image = [UIImage imageNamed:@"photos-50"];
    [[self.tabBarController.viewControllers objectAtIndex:0]tabBarItem].title = nil;
    
    
    [[self.tabBarController.viewControllers objectAtIndex:1]tabBarItem].image = [UIImage imageNamed:@"search-50"];
    [[self.tabBarController.viewControllers objectAtIndex:1]tabBarItem].title = nil;
    
}

- (void)setupNavigationElements
{
    //Set nav bar's title text and text color
    self.navigationItem.title = @"Popular Instagram Photos";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:0.169 green:0.353 blue:0.514 alpha:1]};
}

- (void)setupActivityIndicator
{
    //Setup and show activity indicator
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.mode = MBProgressHUDAnimationFade;
    [self.HUD show:YES];
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

#pragma mark - Networking Methods
- (void)requestPopularMediaFromInstagram
{
    [self.sharedPOPInstagramNetworkingClient fetchPopularMediaOnSuccess:^(NSURLSessionDataTask *task, NSArray *popularMedia) {
        
        //Set our mediaItems property to returned popular media,
        //hide progress HUD, and reload collection view.
        self.mediaItems = popularMedia;
        [self.HUD hide:YES];
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //Display alert view with error
        [self displayAlertViewForUnsuccessfulRequestForPopularMediaError:error];
    }];
}

#pragma mark - Error Handling
- (void)displayAlertViewForUnsuccessfulRequestForPopularMediaError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:[NSString stringWithFormat:@"There has been an error: %@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
    //and set as cell's thumbnail image view.
    [cell.thumbnailImageView setImage:[self.mediaItems[indexPath.row]thumbnailImage]];
    
    return cell;
}

#pragma mark - Delegate Methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Execute segue
    [self performSegueWithIdentifier:@"popularToMediaDisplaySegue" sender:self];
}

#pragma mark - Segue Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Create index path from selected index paths array,
    //and always grab the last one so if the user selects multiple items
    //during app use, we will always grab the most recently selected item
    NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems]lastObject];
    
    //Create media display controller and set it's standard resolution image
    self.mediaDisplayViewController = segue.destinationViewController;
    self.mediaDisplayViewController.lowResolutionImage = [self.mediaItems[indexPath.row]lowResolutionImage];
    
}

@end
