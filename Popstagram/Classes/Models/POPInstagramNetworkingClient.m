//
//  POPInstagramNetworkingClient.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPInstagramNetworkingClient.h"
#import <AFNetworking.h>

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
    NSLog(@"requesting popular media");
    static NSString * const kRequestForPopularMediaSuccessful = @"RequestForPopularMediaSuccessful";
    static NSString * const kRequestForPopularMediaUnsuccessful = @"RequestForPopularMediaUnsuccessful";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@media/popular?client_id=76566d0e6d5a41069ea5e8c86fbbd509", self.baseURL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Success!");
        NSLog(@"Response object: %@", responseObject);
        [[NSNotificationCenter defaultCenter]postNotificationName:kRequestForPopularMediaSuccessful object:nil userInfo:@{@"requestPopularMediaResults": responseObject}];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [[NSNotificationCenter defaultCenter]postNotificationName:kRequestForPopularMediaUnsuccessful object:nil userInfo:@{@"requestPopularMediaResults": error}];
        
    }];
}

- (void)requestMediaWithTag:(NSString *)tag
{
    NSLog(@"requesting media with tag");
    static NSString * const kRequestForMediaWithTagSuccessful = @"RequestForMediaWithTagSuccessful";
    static NSString * const kRequestForMediaWithTagUnsuccessful = @"RequestForMediaWithTagUnsuccessful";

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@tags/search?q=%@&client_id=76566d0e6d5a41069ea5e8c86fbbd509", self.baseURL, tag] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Success!");
        NSLog(@"Response Object: %@", responseObject);
        [[NSNotificationCenter defaultCenter]postNotificationName:kRequestForMediaWithTagSuccessful object:nil userInfo:@{@"requestMediaWithTagResults": responseObject}];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [[NSNotificationCenter defaultCenter]postNotificationName:kRequestForMediaWithTagUnsuccessful object:nil userInfo:@{@"requestMediaWithTagResults": error}];
    }];
}

@end

