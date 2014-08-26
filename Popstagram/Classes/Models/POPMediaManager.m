//
//  POPMediaManager.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/24/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPMediaManager.h"
#import "POPMediaItem.h"

@interface POPMediaManager ()

@property (nonatomic, readwrite) NSDictionary *popularMediaData;
@property (nonatomic, readwrite) NSMutableArray *popularMediaItems;
@property (nonatomic, readwrite) NSDictionary *taggedMediaData;
@property (nonatomic, readwrite) NSMutableArray *taggedMediaItems;

@end

@implementation POPMediaManager

#pragma mark - Initializer Methods
- (instancetype)initWithPopularMediaData:(NSDictionary *)popularMediaData
{
    self = [super init];
    
    if (self) {
        
        //Set mediaData property and initialize mediaItems array
        _popularMediaData = [popularMediaData copy];
        _popularMediaItems = [[NSMutableArray alloc]init];
    }
    return self;
}

- (instancetype)initWithTaggedMediaData:(NSDictionary *)taggedMediaData
{
    self = [super init];
    
    if (self) {
        
        //Set mediaData property and initialize mediaItems array
        _taggedMediaData = [taggedMediaData copy];
        _taggedMediaItems = [[NSMutableArray alloc]init];
    }
    return self;
}

- (NSArray *)createAndFetchPopularMediaItemsWithTypeImage
{
    for (id popularMediaDataItem in [self.popularMediaData objectForKey:@"data"]) {
        
        //NSLog(@"mediaDataItem type: %@", [mediaDataItem class]);
        //NSLog(@"thumbnail url: %@", [[[mediaDataItem objectForKey:@"images"]objectForKey:@"thumbnail"]objectForKey:@"url"]);
        
        //If the media item's type is video, then continue on to the next iteration
        //We only want to display images in this app
        if ([[popularMediaDataItem objectForKey:@"type"]isEqualToString:@"video"]) {
            continue;
        }
        
        //Generate image URL's and images from URL data
        NSURL *thumbnailURL = [NSURL URLWithString:[[[popularMediaDataItem objectForKey:@"images"]objectForKey:@"thumbnail"]objectForKey:@"url"]];
        UIImage *thumbnailImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:thumbnailURL]];
        
        NSURL *lowResolutionURL = [NSURL URLWithString:[[[popularMediaDataItem objectForKey:@"images"]objectForKey:@"low_resolution"]objectForKey:@"url"]];
        UIImage *lowResolutionImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:lowResolutionURL]];
        
        NSURL *standardResolutionURL = [NSURL URLWithString:[[[popularMediaDataItem objectForKey:@"images"]objectForKey:@"standard_resolution"]objectForKey:@"url"]];
        UIImage *standardResolutionImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:standardResolutionURL]];
        
        //Generate username
        NSString *username = [NSString stringWithString:[[popularMediaDataItem objectForKey:@"user"]objectForKey:@"username"]];
        
        //Create media item with generated images and username
        POPMediaItem *popularMediaItem = [[POPMediaItem alloc]initWithThumbnailImage:thumbnailImage lowResolutionImage:lowResolutionImage standardResolutionImage:standardResolutionImage username:username];
        
        //Add media item to media manager's media items collection
        [self.popularMediaItems addObject:popularMediaItem];
        NSLog(@"count: %d", self.popularMediaItems.count);
        
    }
    
    return self.popularMediaItems;
}

- (NSArray *)createAndFetchTaggedMediaItemsWithTypeImage
{
    for (id taggedMediaDataItem in [self.taggedMediaData objectForKey:@"data"]) {
        
        //NSLog(@"mediaDataItem type: %@", [mediaDataItem class]);
        //NSLog(@"thumbnail url: %@", [[[mediaDataItem objectForKey:@"images"]objectForKey:@"thumbnail"]objectForKey:@"url"]);
        
        //If the media item's type is video, then continue on to the next iteration
        //We only want to display images in this app
        if ([[taggedMediaDataItem objectForKey:@"type"]isEqualToString:@"video"]) {
            continue;
        }
        
        //Generate image URL's and images from URL data
        NSURL *thumbnailURL = [NSURL URLWithString:[[[taggedMediaDataItem objectForKey:@"images"]objectForKey:@"thumbnail"]objectForKey:@"url"]];
        UIImage *thumbnailImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:thumbnailURL]];
        
        NSURL *lowResolutionURL = [NSURL URLWithString:[[[taggedMediaDataItem objectForKey:@"images"]objectForKey:@"low_resolution"]objectForKey:@"url"]];
        UIImage *lowResolutionImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:lowResolutionURL]];
        
        NSURL *standardResolutionURL = [NSURL URLWithString:[[[taggedMediaDataItem objectForKey:@"images"]objectForKey:@"standard_resolution"]objectForKey:@"url"]];
        UIImage *standardResolutionImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:standardResolutionURL]];
        
        //Generate username
        NSString *username = [NSString stringWithString:[[taggedMediaDataItem objectForKey:@"user"]objectForKey:@"username"]];
        
        //Create media item with generated images and username
        POPMediaItem *taggedMediaItem = [[POPMediaItem alloc]initWithThumbnailImage:thumbnailImage lowResolutionImage:lowResolutionImage standardResolutionImage:standardResolutionImage username:username];
        
        //Add media item to media manager's media items collection
        [self.taggedMediaItems addObject:taggedMediaItem];
        NSLog(@"count: %d", self.taggedMediaItems.count);
        
    }
    
    return self.taggedMediaItems;
}


@end
