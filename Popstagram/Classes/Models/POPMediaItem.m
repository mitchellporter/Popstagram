//
//  POPMediaItem.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPMediaItem.h"

@implementation POPMediaItem

- (instancetype)initWithThumbnailImage:(UIImage *)thumbnailImage lowResolutionImage:(UIImage *)lowResolutionImage standardResolutionImage:(UIImage *)standardResolutionImage caption:(NSString *)caption
{
    self = [super init];
    
    if (self) {
        
        //Set the instance's properties
        _thumbnailImage = [thumbnailImage copy];
        _lowResolutionImage = [lowResolutionImage copy];
        _standardResolutionImage = [standardResolutionImage copy];
        _caption = [caption copy];
    }
    return self;
}

@end
