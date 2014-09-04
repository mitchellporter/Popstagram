//
//  POPMediaItem.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPMediaItem.h"

@interface POPMediaItem ()

@property (nonatomic, readwrite) NSString *thumbnailImageUrl;
@property (nonatomic, readwrite) NSString *lowResolutionImageUrl;
@property (nonatomic, readwrite) NSString *standardResolutionImageUrl;
@property (nonatomic, readwrite) NSString *username;

@end

@implementation POPMediaItem

// This is a Mantle method override. It's a declarative method that maps the NPTopic object's
// property names to their equivalent JSON key name.
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"username" : @"user.username",
             @"thumbnailImageUrl" : @"images.thumbnail.url",
             @"lowResolutionImageUrl" : @"images.low_resolution.url",
             @"standardResolutionImageUrl" : @"images.standard_resolution.url"
             };
}

@end
