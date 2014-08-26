//
//  POPMediaManager.h
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//


@interface POPMediaManager : NSObject

@property (nonatomic, readonly) NSDictionary *popularMediaData;
@property (nonatomic, readonly) NSMutableArray *popularMediaItems;
@property (nonatomic, readonly) NSDictionary *taggedMediaData;
@property (nonatomic, readonly) NSMutableArray *taggedMediaItems;

- (instancetype)initWithPopularMediaData:(NSDictionary *)popularMediaData;
- (instancetype)initWithTaggedMediaData:(NSDictionary *)taggedMediaData;

- (NSArray *)createAndFetchPopularMediaItemsWithTypeImage;
- (NSArray *)createAndFetchTaggedMediaItemsWithTypeImage;

@end
