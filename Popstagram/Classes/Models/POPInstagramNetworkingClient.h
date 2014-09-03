//
//  POPInstagramNetworkingClient.h
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "AFHTTPSessionManager.h"

extern NSString * const kRequestForPopularMediaSuccessful;
extern NSString * const kRequestForPopularMediaUnsuccessful;
extern NSString * const kRequestForMediaWithTagSuccessful;
extern NSString * const kRequestForMediaWithTagUnsuccessful;
extern NSString * const kRequestForPopularMediaResultsKey;
extern NSString * const kRequestForMediaWithTagResultsKey;

@interface POPInstagramNetworkingClient : AFHTTPSessionManager

+ (id)sharedPOPInstagramNetworkingClient;

- (instancetype)initWithBaseURL:(NSURL *)url;
- (NSURLSessionDataTask *)fetchPopularMediaOnSuccess:(void (^)(NSURLSessionDataTask *task, NSArray *popularMedia))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)requestMediaWithTag:(NSString *)tag;

@property (readonly) NSString * const myString;

@end
