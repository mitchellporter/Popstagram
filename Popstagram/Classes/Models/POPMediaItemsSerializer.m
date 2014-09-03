//
//  POPMediaItemsSerializer.m
//  Popstagram
//
//  Created by Mitchell Porter on 9/3/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPMediaItemsSerializer.h"
#import "POPMediaItem.h"

@implementation POPMediaItemsSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error
{
    NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
    if (!JSONDictionary) return nil;
    
    // Note: the expected JSON format of this response is { data: [ { <a topic> }, { <another topic>} ], metadata: { ...} }
    NSArray *JSONMediaItems = JSONDictionary[@"data"];
    
    NSMutableArray *mediaItems = [NSMutableArray array];
    
    for (NSDictionary *JSONMediaItem in JSONMediaItems) {
        // For each topic in JSON format, we can deserialize it from JSON to our desired model class using Mantle
        POPMediaItem *mediaItem = [MTLJSONAdapter modelOfClass:[POPMediaItem class] fromJSONDictionary:JSONMediaItem error:error];
        
        if (!mediaItem) return nil;
        
        //Set the media item's image properties
        mediaItem.thumbnailImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:mediaItem.thumbnailImageUrl]]];
        mediaItem.lowResolutionImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:mediaItem.lowResolutionImageUrl]]];
        mediaItem.standardResolutionImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:mediaItem.standardResolutionImageUrl]]];
        
        //Add finished media item to media items collection
        [mediaItems addObject:mediaItem];
    }
    
    *error = nil;
    return [mediaItems copy];
}

@end
