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
        
        static NSString * const BaseURLString = @"https://api.instagram.com/v1/";
        sharedPOPInstagramNetworkingClient = [[POPInstagramNetworkingClient alloc]initWithBaseURL:[NSURL URLWithString:BaseURLString]];
    });
    
    return sharedPOPInstagramNetworkingClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return self;
}

- (void)requestPopularMedia
{
    
}

@end

