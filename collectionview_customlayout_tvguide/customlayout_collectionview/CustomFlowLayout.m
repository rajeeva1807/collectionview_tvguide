//
//  CustomFlowLayout.m
//  customlayout_collectionview
//
//  Created by Rajeeva Ranjan on 02/04/17.
//  Copyright © 2017 Rajeeva Ranjan. All rights reserved.
//

#import "CustomFlowLayout.h"
#import "decorationview.h"

@implementation CustomFlowLayout

- (id)init
{
    self = [super init];
    if (self) {
        [self registerClass:[decorationview class] forDecorationViewOfKind:@"decview"];
    }
    return self;
}



- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    //  layoutAttributes = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *layoutAttributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    
    
    UICollectionViewLayoutAttributes *decviewattr = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"decview" withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    
    decviewattr.frame = CGRectMake(0, 0, 300, 300);
    decviewattr.zIndex = -1;
    [layoutAttributes addObject:decviewattr];
    
    
    UICollectionViewLayoutAttributes *decviewattr1 = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"decview" withIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
    
    decviewattr1.frame = CGRectMake(0, 400, 300, 300);
    decviewattr1.zIndex = -1;
    
    [layoutAttributes addObject:decviewattr1];
    
    
    UICollectionViewLayoutAttributes *suppattr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    
    suppattr.frame = CGRectMake(0, 100, 200, 500);
    //[layoutAttributes addObject:suppattr]; // can't modify suppl view attributes
    
    return layoutAttributes;
}

@end
