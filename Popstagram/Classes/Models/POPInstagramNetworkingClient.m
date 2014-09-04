//
//  POPInstagramNetworkingClient.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPInstagramNetworkingClient.h"
#import "POPMediaItemsSerializer.h"
#import <AFNetworking.h>

#pragma mark - Constants
NSString * const kRequestForPopularMediaSuccessful = @"RequestForPopularMediaSuccessful";
NSString * const kRequestForPopularMediaUnsuccessful = @"RequestForPopularMediaUnsuccessful";
NSString * const kRequestForMediaWithTagSuccessful = @"RequestForMediaWithTagSuccessful";
NSString * const kRequestForMediaWithTagUnsuccessful = @"RequestForMediaWithTagUnsuccessful";
NSString * const kRequestForPopularMediaResultsKey = @"requestForPopularMediaResults";
NSString * const kRequestForMediaWithTagResultsKey = @"requestForTaggedMediaResults";

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
- (NSURLSessionDataTask *)fetchPopularMediaOnSuccess:(void (^)(NSURLSessionDataTask *task, NSArray *popularMedia))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
{
    //Set the serializer to our subclass
    self.responseSerializer = [POPMediaItemsSerializer serializer];
    
    //Create our data task and execute blocks based on success or failure of GET method
    NSURLSessionDataTask *task = [self GET:[NSString stringWithFormat:@"%@media/popular?client_id=76566d0e6d5a41069ea5e8c86fbbd509", self.baseURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success)
            success(task, responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure)
            failure(task, error);
    }];
    
    return task;
}

-(NSURLSessionDataTask *)requestMediaWithTag:(NSString *)tag success:(void (^)(NSURLSessionDataTask *, NSArray *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    
    //Set the serializer to our subclass
    self.responseSerializer = [POPMediaItemsSerializer serializer];
    
    //Create our data task and execute blocks based on success or failure of GET method
    NSURLSessionDataTask *task = [self GET:[NSString stringWithFormat:@"%@tags/%@/media/recent?client_id=76566d0e6d5a41069ea5e8c86fbbd509", self.baseURL, tag] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (success)
            success(task, responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure)
            failure(task, error);
    }];
    
    return task;
}

@end

