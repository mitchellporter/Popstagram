//
//  POPMediaCollectionViewFlowLayout.h
//  Popstagram
//
//  Created by Mitchell Porter on 8/25/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface POPMediaCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
- (void)resetLayout;

@end
