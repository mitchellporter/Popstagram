//
//  POPTaggedMediaCollectionViewController.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/25/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPTaggedMediaCollectionViewController.h"
#import "POPInstagramNetworkingClient.h"
#import "POPMediaItem.h"
#import "POPMediaCollectionViewCell.h"
#import "POPTagTextField.h"
#import "POPMediaDisplayViewController.h"
#import <MBProgressHUD.h>

#pragma mark - Cell Identifier
static NSString *cellIdentifier = @"cellId";

@interface POPTaggedMediaCollectionViewController () <UITextFieldDelegate>

#pragma mark - Properties
@property (nonatomic) POPInstagramNetworkingClient *sharedPOPInstagramNetworkingClient;
@property (nonatomic) NSArray *taggedMediaItems;
@property (nonatomic) MBProgressHUD *HUD;
@property (nonatomic) POPTagTextField *tagTextField;
@property (nonatomic) POPMediaDisplayViewController *mediaDisplayViewController;

@end

@implementation POPTaggedMediaCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Customize the current view by setting background color to white
    //This takes care of empty black space when moving the collection view
    //below the text field
    [self customizeView];
    
    //Execute various setup methods
    [self setupNavigationElements];
    [self setupCollectionView];
    [self setupSharedPOPInstagramNetworkingClient];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Setup the hash tag text field
    [self setupTagTextField];
}

- (void)customizeView
{
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Setup Methods
- (void)setupTagTextField
{
    self.tagTextField = [[POPTagTextField alloc] initWithFrame:CGRectMake(10.0f, 15.0f, [UIScreen mainScreen].bounds.size.width - 20, 60.0f)];
    self.tagTextField.delegate = self;
    [self.view addSubview:self.tagTextField];
}

- (void)setupNavigationElements
{
    //Set nav bar's title text and text color
    self.navigationItem.title = @"Search by Hashtag";
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
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    //Customize the collection view's frame so that it is
    //not blocked by our text field, and so that the bottom row
    //of cells is always fully visible regardless of screen size
    if ([[UIScreen mainScreen]bounds].size.height == 568) {
     
        self.collectionView.frame = CGRectMake(0, 80, 320, 470);
        
    } else {
        
        self.collectionView.frame = CGRectMake(0, 80, 320, 450);
    }

}
- (void)setupSharedPOPInstagramNetworkingClient
{
    //Setup shared networking client for Instagram
    self.sharedPOPInstagramNetworkingClient = [POPInstagramNetworkingClient sharedPOPInstagramNetworkingClient];
}

#pragma mark - Networking Methods
- (void)requestTaggedMediaFromInstagramWithTag:(NSString *)tag
{
    //Request popular media from Instagram with the passed tag
    [self.sharedPOPInstagramNetworkingClient requestMediaWithTag:tag success:^(NSURLSessionDataTask *task, NSArray *taggedMedia) {
        
        //Set taggedMediaItems property to returned tagged media,
        //hide progress HUD and reload collection view data
        self.taggedMediaItems = taggedMedia;
        [self.HUD hide:YES];
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //Display the alert view with error
        [self displayAlertViewForUnsuccessfulRequestForMediaWithTagError:error];
        
    }];
}

#pragma mark - Error Handling
- (void)displayAlertViewForUnsuccessfulRequestForMediaWithTagError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:[NSString stringWithFormat:@"There has been an error: %@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.taggedMediaItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Set cell identifier and grab reusable cell
    POPMediaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //Get current tagged media item's thumbnail image property,
    //and set as the cell's image view image
    [cell.thumbnailImageView setImage:[self.taggedMediaItems[indexPath.row]thumbnailImage]];
    
    return cell;
}

#pragma mark - Delegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //Give up responder status
    [textField resignFirstResponder];
    
    //Check for empty text field text
    if ([textField.text isEqualToString:@""]) {
        return NO;
    }
    
    //Setup and run the activity indicator
    //Will run until ready to reload collection view
    [self setupActivityIndicator];

    //Create new string after removing pound,
    //then a final string after removing any blank space
    NSString *tagTextWithoutPound = [textField.text stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSString *finalTagText2 = [tagTextWithoutPound stringByReplacingOccurrencesOfString:@" " withString:@""];

    //Pass our final tag
    [self requestTaggedMediaFromInstagramWithTag:finalTagText2];
    
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Execute segue
    [self performSegueWithIdentifier:@"taggedToMediaDisplaySegue" sender:self];
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
    self.mediaDisplayViewController.lowResolutionImage = [self.taggedMediaItems[indexPath.row]lowResolutionImage];
    
}

@end
