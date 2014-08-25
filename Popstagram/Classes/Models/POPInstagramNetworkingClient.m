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

#pragma mark - Singleton
+ (instancetype)sharedPOPInstagramNetworkingClient
{
    static POPInstagramNetworkingClient *sharedPOPInstagramNetworkingClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //Define base URL string
        static NSString * const BaseURLString = @"https://api.instagram.com/v1/";
        
        //Create our shared networking client for Instagram with base URL
        sharedPOPInstagramNetworkingClient = [[POPInstagramNetworkingClient alloc]initWithBaseURL:[NSURL URLWithString:BaseURLString]];
    });

    return sharedPOPInstagramNetworkingClient;
}

#pragma mark - Initializer Methods
- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        //Set the serializers
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return self;
}

#pragma mark - Instance Methods
- (void)requestPopularMedia
{
    //Define notification names
    static NSString * const kRequestForPopularMediaSuccessful = @"RequestForPopularMediaSuccessful";
    static NSString * const kRequestForPopularMediaUnsuccessful = @"RequestForPopularMediaUnsuccessful";
    
    //Create manager and execute GET method to retreive popular media
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@media/popular?client_id=76566d0e6d5a41069ea5e8c86fbbd509", self.baseURL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Success!");
        NSLog(@"Response object: %@", responseObject);
        
        //Post success notification
        [[NSNotificationCenter defaultCenter]postNotificationName:kRequestForPopularMediaSuccessful object:nil userInfo:@{@"requestForPopularMediaResults": responseObject}];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        //Post failure notificaton
        [[NSNotificationCenter defaultCenter]postNotificationName:kRequestForPopularMediaUnsuccessful object:nil userInfo:@{@"requestForPopularMediaResults": error}];
        
    }];
}

- (void)requestMediaWithTag:(NSString *)tag
{
    NSLog(@"requesting media with tag");
    
    //Define notification names
    static NSString * const kRequestForMediaWithTagSuccessful = @"RequestForMediaWithTagSuccessful";
    static NSString * const kRequestForMediaWithTagUnsuccessful = @"RequestForMediaWithTagUnsuccessful";

    //Create manager and execute GET method to retreive media with tag
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@tags/search?q=%@&client_id=76566d0e6d5a41069ea5e8c86fbbd509", self.baseURL, tag] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Success!");
        NSLog(@"Response Object: %@", responseObject);
        
        //Post success notification
        [[NSNotificationCenter defaultCenter]postNotificationName:kRequestForMediaWithTagSuccessful object:nil userInfo:@{@"requestMediaWithTagResults": responseObject}];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        //Post failure notification
        [[NSNotificationCenter defaultCenter]postNotificationName:kRequestForMediaWithTagUnsuccessful object:nil userInfo:@{@"requestMediaWithTagResults": error}];
    }];
}

@end

