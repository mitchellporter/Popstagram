//
//  POPMediaManager.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPMediaManager.h"

@interface POPMediaManager ()

@property (nonatomic) NSDictionary *mediaData;
@property (nonatomic) NSMutableArray *mediaItems;

@end

@implementation POPMediaManager

- (instancetype)initWithMediaData:(NSDictionary *)mediaData
{
    self = [super init];
    
    if (self) {
        
        //Set mediaData property
        _mediaData = [mediaData copy];
    }
    return self;
}

@end
