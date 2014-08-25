//
//  POPMediaItem.h
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//


@interface POPMediaItem : NSObject

- (instancetype)initWithThumbnailImage:(UIImage *)thumbnailImage lowResolutionImage:(UIImage *)lowResolutionImage standardResolutionImage:(UIImage *)standardResolutionImage username:(NSString *)username;

@property (nonatomic) UIImage *thumbnailImage;
@property (nonatomic) UIImage *lowResolutionImage;
@property (nonatomic) UIImage *standardResolutionImage;
@property (nonatomic) NSString *username;

@end
