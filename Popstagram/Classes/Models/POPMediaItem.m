//
//  POPMediaItem.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPMediaItem.h"

@interface POPMediaItem ()

@property (nonatomic, readwrite) UIImage *thumbnailImage;
@property (nonatomic, readwrite) UIImage *lowResolutionImage;
@property (nonatomic, readwrite) UIImage *standardResolutionImage;
@property (nonatomic, readwrite) NSString *username;

@end

@implementation POPMediaItem

- (instancetype)initWithThumbnailImage:(UIImage *)thumbnailImage lowResolutionImage:(UIImage *)lowResolutionImage standardResolutionImage:(UIImage *)standardResolutionImage username:(NSString *)username
{
    self = [super init];
    
    if (self) {
        
        //Set the instance's properties
        _thumbnailImage = [thumbnailImage copy];
        _lowResolutionImage = [lowResolutionImage copy];
        _standardResolutionImage = [standardResolutionImage copy];
        _username = [username copy];
    }
    return self;
}

@end
