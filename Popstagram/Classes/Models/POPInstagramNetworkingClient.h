//
//  POPInstagramNetworkingClient.h
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface POPInstagramNetworkingClient : AFHTTPSessionManager

@property (readonly) NSString * const myString;

+ (id)sharedPOPInstagramNetworkingClient;

- (instancetype)initWithBaseURL:(NSURL *)url;
- (NSURLSessionDataTask *)fetchPopularMediaOnSuccess:(void (^)(NSURLSessionDataTask *task, NSArray *popularMedia))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)requestMediaWithTag:(NSString *)tag success:(void (^)(NSURLSessionDataTask *task, NSArray *taggedMedia))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
