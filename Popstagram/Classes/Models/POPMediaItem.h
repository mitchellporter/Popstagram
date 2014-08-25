//
//  POPMediaItem.h
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//


@interface POPMediaItem : NSObject

- (instancetype)initWithImage:(UIImage *)image caption:(NSString *)caption;

@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *caption;

@end
