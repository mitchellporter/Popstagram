//
//  POPMediaItem.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPMediaItem.h"

@implementation POPMediaItem

- (instancetype)initWithImage:(UIImage *)image caption:(NSString *)caption
{
    self = [super init];
    
    if (self) {
        
        //Set the image and caption properties
        _image = [image copy];
        _caption = [caption copy];
    }
    return self;
}

@end
