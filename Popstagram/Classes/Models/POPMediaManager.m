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

@property (nonatomic) NSDictionary *mediaData;
@property (nonatomic) NSMutableArray *mediaItems;

@end

@implementation POPMediaManager

- (instancetype)initWithMediaData:(NSDictionary *)mediaData
{
    self = [super init];
    
    if (self) {
        
        //Set mediaData property and initialize mediaItems array
        _mediaData = [mediaData copy];
        _mediaItems = [[NSMutableArray alloc]init];
    }
    return self;
}

- (NSArray *)createAndFetchMediaItemsWithTypeImage
{
    for (id mediaDataItem in [self.mediaData objectForKey:@"data"]) {
        
        //NSLog(@"mediaDataItem type: %@", [mediaDataItem class]);
        //NSLog(@"thumbnail url: %@", [[[mediaDataItem objectForKey:@"images"]objectForKey:@"thumbnail"]objectForKey:@"url"]);
        
        //If the media item's type is video, then continue on to the next iteration
        //We only want to display images in this app
        if ([[mediaDataItem objectForKey:@"type"]isEqualToString:@"video"]) {
            continue;
        }
        
        //Generate image URL's and images from URL data
        NSURL *thumbnailURL = [NSURL URLWithString:[[[mediaDataItem objectForKey:@"images"]objectForKey:@"thumbnail"]objectForKey:@"url"]];
        UIImage *thumbnailImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:thumbnailURL]];
        
        NSURL *lowResolutionURL = [NSURL URLWithString:[[[mediaDataItem objectForKey:@"images"]objectForKey:@"low_resolution"]objectForKey:@"url"]];
        UIImage *lowResolutionImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:lowResolutionURL]];
        
        NSURL *standardResolutionURL = [NSURL URLWithString:[[[mediaDataItem objectForKey:@"images"]objectForKey:@"standard_resolution"]objectForKey:@"url"]];
        UIImage *standardResolutionImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:standardResolutionURL]];
        
        //Generate username
        NSString *username = [NSString stringWithString:[[mediaDataItem objectForKey:@"user"]objectForKey:@"username"]];
        
        //Create media item with generated images and username
        POPMediaItem *mediaItem = [[POPMediaItem alloc]initWithThumbnailImage:thumbnailImage lowResolutionImage:lowResolutionImage standardResolutionImage:standardResolutionImage username:username];
        
        //Add media item to media manager's media items collection
        [self.mediaItems addObject:mediaItem];
        NSLog(@"count: %d", self.mediaItems.count);
        
    }
    
    return self.mediaItems;
}

@end
