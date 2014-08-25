//
//  POPPopularMediaCollectionViewController.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPPopularMediaCollectionViewController.h"
#import "POPInstagramNetworkingClient.h"

@interface POPPopularMediaCollectionViewController ()

@property (nonatomic) POPInstagramNetworkingClient *sharedPOPInstagramNetworkingClient;

@end

@implementation POPPopularMediaCollectionViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Setup shared networking client and request popular media from Instagram
    [self setupSharedPOPInstagramNetworkingClient];
    [self requestPopularMediaFromInstagram];
    
}

- (void)setupSharedPOPInstagramNetworkingClient
{
    //Setup shared networking client for Instagram
    self.sharedPOPInstagramNetworkingClient = [POPInstagramNetworkingClient sharedPOPInstagramNetworkingClient];
}

- (void)requestPopularMediaFromInstagram
{
    //Request popular media from Instagram
    [self.sharedPOPInstagramNetworkingClient requestPopularMedia];
}


@end
