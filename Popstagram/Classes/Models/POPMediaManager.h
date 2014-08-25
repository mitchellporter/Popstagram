//
//  POPMediaManager.h
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//


@interface POPMediaManager : NSObject

@property (nonatomic, readonly) NSDictionary *mediaData;
@property (nonatomic, readonly) NSMutableArray *mediaItems;

- (instancetype)initWithMediaData:(NSDictionary *)mediaData;
- (NSArray *)createAndFetchMediaItemsWithTypeImage;



@end
