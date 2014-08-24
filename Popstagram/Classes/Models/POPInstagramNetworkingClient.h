//
//  POPInstagramNetworkingClient.h
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface POPInstagramNetworkingClient : AFHTTPSessionManager

+ (id)sharedPOPInstagramNetworkingClient;

- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)requestPopularMedia;

@end
