//
//  POPMediaCollectionViewFlowLayout.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/25/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPMediaCollectionViewFlowLayout.h"

@implementation POPMediaCollectionViewFlowLayout

#pragma mark - Initializers
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (!(self = [super initWithCoder:aDecoder])) return nil;
    
    //Customize item/cell spacing and size
    self.minimumInteritemSpacing = 5;
    self.minimumLineSpacing = 10;
    self.itemSize = CGSizeMake(100, 100);
    self.sectionInset = UIEdgeInsetsMake(10, 5, 10, 5);
    
    //Create the dynamic animator
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    //CGSize contentSize = self.collectionView.contentSize;
    //contentSize was being used for height and width in layoutAttributesForElementsInRect:
    //but was causing problems. Now using bounds of the device screen instead.
    NSArray *items = [super layoutAttributesForElementsInRect:
                      CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    //Loop through and add the behavior to the dynamic animator
    if (self.dynamicAnimator.behaviors.count == 0) {
        [items enumerateObjectsUsingBlock:^(id<UIDynamicItem> obj, NSUInteger idx, BOOL *stop) {
            UIAttachmentBehavior *behaviour = [[UIAttachmentBehavior alloc] initWithItem:obj
                                                                        attachedToAnchor:[obj center]];
            //Customize current behavior's properties
            behaviour.length = 0.0f;
            behaviour.damping = 0.8f;
            behaviour.frequency = 1.0f;
            
            //Add current behavior to dynamic animator
            [self.dynamicAnimator addBehavior:behaviour];
        }];
    }
}

#pragma mark - Layout Attributes
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [self.dynamicAnimator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}

#pragma mark - Invalidate Layout
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    UIScrollView *scrollView = self.collectionView;
    CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
    
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    [self.dynamicAnimator.behaviors enumerateObjectsUsingBlock:^(UIAttachmentBehavior *springBehaviour, NSUInteger idx, BOOL *stop) {
        CGFloat yDistanceFromTouch = fabsf(touchLocation.y - springBehaviour.anchorPoint.y);
        CGFloat xDistanceFromTouch = fabsf(touchLocation.x - springBehaviour.anchorPoint.x);
        CGFloat scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 500.0f;
        
        UICollectionViewLayoutAttributes *item = springBehaviour.items.firstObject;
        CGPoint center = item.center;
        if (delta < 0) {
            center.y += MAX(delta, delta*scrollResistance);
        }
        else {
            center.y += MIN(delta, delta*scrollResistance);
        }
        item.center = center;
        
        [self.dynamicAnimator updateItemUsingCurrentState:item];
    }];
    
    return NO;
}

#pragma mark - Reset Layout
- (void)resetLayout
{
    [self.dynamicAnimator removeAllBehaviors];
    [self prepareLayout];
}

@end
