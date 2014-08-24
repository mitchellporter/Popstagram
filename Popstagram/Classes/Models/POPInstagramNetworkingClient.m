//
//  POPInstagramNetworkingClient.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPInstagramNetworkingClient.h"

@implementation POPInstagramNetworkingClient

+ (id)sharedPOPInstagramNetworkingClient
{
    static POPInstagramNetworkingClient *sharedPOPInstagramNetworkingClient = nil;
    
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPOPInstagramNetworkingClient = [[POPInstagramNetworkingClient alloc]init];
    });
    
    return sharedPOPInstagramNetworkingClient;
}

@end

