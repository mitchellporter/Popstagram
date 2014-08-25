//
//  POPMediaItem.h
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//


@interface POPMediaItem : NSObject

- (instancetype)initWithThumbnailImage:(UIImage *)thumbnailImage lowResolutionImage:(UIImage *)lowResolutionImage standardResolutionImage:(UIImage *)standardResolutionImage caption:(NSString *)caption;

@property (nonatomic) UIImage *thumbnailImage;
@property (nonatomic) UIImage *lowResolutionImage;
@property (nonatomic) UIImage *standardResolutionImage;
@property (nonatomic) NSString *caption;

@end
