//
//  POPMediaCollectionViewCell.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/25/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPMediaCollectionViewCell.h"

@interface POPMediaCollectionViewCell ()

@property (nonatomic, readwrite) UIImageView *thumbnailImageView;

@end

@implementation POPMediaCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //Customize cell's appearance
        self.layer.borderColor = [UIColor blueColor].CGColor;
        self.layer.shadowColor = [UIColor blueColor].CGColor;
        self.layer.borderWidth = 5.0f;
        self.layer.shadowRadius = 5.0f;
        self.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
        self.layer.shadowOpacity = 0.5f;
        
        //Setup cell's image view property
        self.thumbnailImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.thumbnailImageView.clipsToBounds = YES;
        
        //Add image view as subview
        [self.contentView addSubview:self.thumbnailImageView];
    }
    return self;
}

- (void)prepareForReuse
{
    //Call to super and kill current image view's image
    [super prepareForReuse];
    self.thumbnailImageView.image = nil;
}

@end
