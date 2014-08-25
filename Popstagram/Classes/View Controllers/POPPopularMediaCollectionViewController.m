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
    NSLog(@"viewDidLoad");
    NSLog(@"viewDidLoad");

    self.sharedPOPInstagramNetworkingClient = [POPInstagramNetworkingClient sharedPOPInstagramNetworkingClient];
    
    NSLog(@"client: %@", self.sharedPOPInstagramNetworkingClient);

    [self.sharedPOPInstagramNetworkingClient requestPopularMedia];
    
}


@end
