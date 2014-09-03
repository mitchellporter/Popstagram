//
//  POPMediaItem.h
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import <Mantle.h>

@interface POPMediaItem : MTLModel <MTLJSONSerializing>

- (instancetype)initWithThumbnailImage:(UIImage *)thumbnailImage lowResolutionImage:(UIImage *)lowResolutionImage standardResolutionImage:(UIImage *)standardResolutionImage username:(NSString *)username;

@property (nonatomic, readonly) NSString *thumbnailImageUrl;
@property (nonatomic, readonly) NSString *lowResolutionImageUrl;
@property (nonatomic, readonly) NSString *standardResolutionImageUrl;
@property (nonatomic) UIImage *thumbnailImage;
@property (nonatomic) UIImage *lowResolutionImage;
@property (nonatomic) UIImage *standardResolutionImage;
@property (nonatomic, readonly) NSString *username;


@end
