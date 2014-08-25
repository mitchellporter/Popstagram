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

@interface POPPopularMediaCollectionViewController ()

#pragma mark - Properties
@property (nonatomic) POPInstagramNetworkingClient *sharedPOPInstagramNetworkingClient;
@property (nonatomic) POPMediaManager *mediaManager;

@end

@implementation POPPopularMediaCollectionViewController

#pragma mark - View Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Setup shared networking client and request popular media from Instagram
    [self setupSharedPOPInstagramNetworkingClient];
    [self setupNotificationObservers];
    [self requestPopularMediaFromInstagram];
}

#pragma mark - Setup Methods
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
    self.mediaManager = [[POPMediaManager alloc]initWithMediaData:notification.userInfo];
    NSLog(@"mediamanager data: %@", self.mediaManager);
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

#pragma mark - Dealloc
- (void)dealloc
{
    //Remove class from notification center
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
     


@end
