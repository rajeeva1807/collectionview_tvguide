//
//  CustomCollectionViewLayout.m
//  customlayout_collectionview
//
//  Created by Rajeeva Ranjan on 02/04/17.
//  Copyright © 2017 Rajeeva Ranjan. All rights reserved.
//

#import "CustomCollectionViewLayout.h"
#import "constants.h"
#import "decorationview.h"


CGFloat ITEM_WIDTH_0;
CGFloat ITEM_WIDTH_1; 
CGFloat ITEM_WIDTH_2; 
CGFloat ITEM_WIDTH_3; 
CGFloat ITEM_WIDTH_4; 
CGFloat ITEM_WIDTH_5; 
CGFloat ITEM_WIDTH_6; 
CGFloat ITEM_WIDTH_7;

@implementation CustomCollectionViewLayout

- (id)init
{
    self = [super init];
    if (self) {
        [self registerClass:[decorationview class] forDecorationViewOfKind:@"decview"];
    }
    return self;
}


//- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:@"decview" withIndexPath:indexPath];
//    //attributes.frame =
//
//    return attributes;
//}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(HEADER_WIDTH*NUMBER_OF_TIME_SLOTS, NUMBER_OF_SECTIONS*CHANNEL_HEIGHT);
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat yValue = 0;
    CGFloat xValue = 0;
    if (indexPath.item == 1) {
        xValue = CV_WIDTH/2;
    } else if (indexPath.item == 2) {
        yValue = CV_HEIGHT/2;
    } else if (indexPath.item == 3) {
        xValue = CV_WIDTH/2;
        yValue = CV_HEIGHT/4;
    }
    return attr;

}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (void)prepareLayout
{
    NSLog(@"PREPARES layout called");
}

- (void)fillDataForSection:(NSInteger)sectionIndex
{
    if (sectionIndex % 4 == 1) {
    
        ITEM_WIDTH_0 = 50;
        ITEM_WIDTH_1 = 200;
        ITEM_WIDTH_2 = 100;
        ITEM_WIDTH_3 = 250;
        ITEM_WIDTH_4 = 150;
        ITEM_WIDTH_5 = 50;
        ITEM_WIDTH_6 = 50;
        ITEM_WIDTH_7 = 350;
    } else if (sectionIndex % 4 == 2) {
        
        ITEM_WIDTH_0 = 100;
        ITEM_WIDTH_1 = 200;
        ITEM_WIDTH_2 = 200;
        ITEM_WIDTH_3 = 100;
        ITEM_WIDTH_4 = 200;
        ITEM_WIDTH_5 = 200;
        ITEM_WIDTH_6 = 100;
        ITEM_WIDTH_7 = 100;
    } else if (sectionIndex % 4 == 3) {
        
        ITEM_WIDTH_0 = 150;
        ITEM_WIDTH_1 = 200;
        ITEM_WIDTH_2 = 100;
        ITEM_WIDTH_3 = 150;
        ITEM_WIDTH_4 = 150;
        ITEM_WIDTH_5 = 150;
        ITEM_WIDTH_6 = 150;
        ITEM_WIDTH_7 = 150;
    } else if (sectionIndex % 4 == 0) {
        
        ITEM_WIDTH_0 = 200;
        ITEM_WIDTH_1 = 100;
        ITEM_WIDTH_2 = 100;
        ITEM_WIDTH_3 = 200;
        ITEM_WIDTH_4 = 200;
        ITEM_WIDTH_5 = 200;
        ITEM_WIDTH_6 = 100;
        ITEM_WIDTH_7 = 100;

    }
}

- (UICollectionViewLayoutAttributes *)layoutattributesforItem:(NSInteger)itemIndex sectionIndex:(NSInteger)sectionIndex
{
    UICollectionViewLayoutAttributes *myAttr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:itemIndex inSection:sectionIndex]];
    

    myAttr.frame = CGRectMake(itemIndex*HEADER_WIDTH, sectionIndex*CHANNEL_HEIGHT, HEADER_WIDTH, CHANNEL_HEIGHT);

    CGFloat collectionViewOffsetX = self.collectionView.contentOffset.x;
    
    CGRect rect = myAttr.frame;

    if (sectionIndex == 4) {
        
        if (!itemIndex) {
            rect.origin.x = collectionViewOffsetX;
            rect.size.width = CV_WIDTH;
        } else {
            rect.origin.x = 0;
            rect.size.width = 0;
        }
        
        if (collectionViewOffsetX < 0) {
            rect.origin.x = 0;
            rect.size.width = CV_WIDTH;
        } else if (collectionViewOffsetX > 1200-CV_WIDTH) {
            rect.origin.x = collectionViewOffsetX;
            rect.size.width = CV_WIDTH - (collectionViewOffsetX - 1200 + CV_WIDTH);
        }
        
        myAttr.frame = rect;
        
    } else if (sectionIndex) {
    
        [self fillDataForSection:sectionIndex];
//item1
            
        if (collectionViewOffsetX >= 0 && collectionViewOffsetX < ITEM_WIDTH_0) {
            if (itemIndex == 0) {
                rect.origin.x = collectionViewOffsetX;
                rect.size.width = ITEM_WIDTH_0-collectionViewOffsetX;
            } else if (itemIndex == 1) {
                rect.origin.x = ITEM_WIDTH_0;
                rect.size.width = ITEM_WIDTH_1;
            } else if (itemIndex == 2) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1;
                rect.size.width = ITEM_WIDTH_2;
            } else if (itemIndex == 3) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2;
                rect.size.width = ITEM_WIDTH_3;
            } else if (itemIndex == 4) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3;
                rect.size.width = ITEM_WIDTH_4;
            } else if (itemIndex == 5) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4;
                rect.size.width = ITEM_WIDTH_5;
            } else if (itemIndex == 6) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5;
                rect.size.width = ITEM_WIDTH_6;
            } else if (itemIndex == 7) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5+ITEM_WIDTH_6;
                rect.size.width = ITEM_WIDTH_7;

            }
        }
//ietm2
        else if (collectionViewOffsetX >= ITEM_WIDTH_0 && collectionViewOffsetX < ITEM_WIDTH_0+ITEM_WIDTH_1) {
            
            CGFloat myNewOffet = collectionViewOffsetX - ITEM_WIDTH_0;
            
            if (itemIndex == 0) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 1) {
                rect.origin.x = collectionViewOffsetX;
                rect.size.width = ITEM_WIDTH_1-myNewOffet;
            } else if (itemIndex == 2) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1;
                rect.size.width = ITEM_WIDTH_2;
            } else if (itemIndex == 3) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2;
                rect.size.width = ITEM_WIDTH_3;
            } else if (itemIndex == 4) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3;
                rect.size.width = ITEM_WIDTH_4;
            } else if (itemIndex == 5) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4;
                rect.size.width = ITEM_WIDTH_5;
            } else if (itemIndex == 6) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5;
                rect.size.width = ITEM_WIDTH_6;
            } else if (itemIndex == 7) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5+ITEM_WIDTH_6;
                rect.size.width = ITEM_WIDTH_7;
                
            }
        }
//item3
        else if (collectionViewOffsetX >= ITEM_WIDTH_0+ITEM_WIDTH_1 && collectionViewOffsetX < ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2) {
            
            CGFloat myNewOffet = collectionViewOffsetX - ITEM_WIDTH_0 - ITEM_WIDTH_1;

            
            if (itemIndex == 0) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 1) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 2) {
                rect.origin.x = collectionViewOffsetX;
                rect.size.width = ITEM_WIDTH_2-myNewOffet;
            } else if (itemIndex == 3) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2;
                rect.size.width = ITEM_WIDTH_3;
            } else if (itemIndex == 4) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3;
                rect.size.width = ITEM_WIDTH_4;
            } else if (itemIndex == 5) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4;
                rect.size.width = ITEM_WIDTH_5;
            } else if (itemIndex == 6) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5;
                rect.size.width = ITEM_WIDTH_6;
            } else if (itemIndex == 7) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5+ITEM_WIDTH_6;
                rect.size.width = ITEM_WIDTH_7;
                
            }
        }
//item4
        else if (collectionViewOffsetX >= ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2 && collectionViewOffsetX < ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3) {
            
            CGFloat myNewOffet = collectionViewOffsetX - ITEM_WIDTH_0 - ITEM_WIDTH_1 - ITEM_WIDTH_2;

            if (itemIndex == 0) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 1) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 2) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 3) {
                rect.origin.x = collectionViewOffsetX;
                rect.size.width = ITEM_WIDTH_3-myNewOffet;
            } else if (itemIndex == 4) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3;
                rect.size.width = ITEM_WIDTH_4;
            } else if (itemIndex == 5) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4;
                rect.size.width = ITEM_WIDTH_5;
            } else if (itemIndex == 6) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5;
                rect.size.width = ITEM_WIDTH_6;
            } else if (itemIndex == 7) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5+ITEM_WIDTH_6;
                rect.size.width = ITEM_WIDTH_7;
                
            }
        }
//item5
        
        else if (collectionViewOffsetX >= ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3 && collectionViewOffsetX < ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4) {
            
            CGFloat myNewOffet = collectionViewOffsetX - ITEM_WIDTH_0 - ITEM_WIDTH_1 - ITEM_WIDTH_2 - ITEM_WIDTH_3;

            if (itemIndex == 0) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 1) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 2) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 3) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 4) {
                rect.origin.x = collectionViewOffsetX;
                rect.size.width = ITEM_WIDTH_4-myNewOffet;
            } else if (itemIndex == 5) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4;
                rect.size.width = ITEM_WIDTH_5;
            } else if (itemIndex == 6) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5;
                rect.size.width = ITEM_WIDTH_6;
            } else if (itemIndex == 7) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5+ITEM_WIDTH_6;
                rect.size.width = ITEM_WIDTH_7;
                
            }
        }
//item6
        
        else if (collectionViewOffsetX >= ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4 && collectionViewOffsetX < ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5) {
            
            CGFloat myNewOffet = collectionViewOffsetX - ITEM_WIDTH_0 - ITEM_WIDTH_1 - ITEM_WIDTH_2 - ITEM_WIDTH_3 - ITEM_WIDTH_4;

            if (itemIndex == 0) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 1) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 2) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 3) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 4) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 5) {
                rect.origin.x = collectionViewOffsetX;
                rect.size.width = ITEM_WIDTH_5-myNewOffet;
            } else if (itemIndex == 6) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5;
                rect.size.width = ITEM_WIDTH_6;
            } else if (itemIndex == 7) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5+ITEM_WIDTH_6;
                rect.size.width = ITEM_WIDTH_7;
                
            }
        }
        
//item7
        
        else if (collectionViewOffsetX >= ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5 && collectionViewOffsetX < ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5+ITEM_WIDTH_6) {
            
            CGFloat myNewOffet = collectionViewOffsetX - ITEM_WIDTH_0 - ITEM_WIDTH_1 - ITEM_WIDTH_2- ITEM_WIDTH_3-ITEM_WIDTH_4-ITEM_WIDTH_5;

            if (itemIndex == 0) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 1) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 2) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 3) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 4) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 5) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 6) {
                rect.origin.x = collectionViewOffsetX;
                rect.size.width = ITEM_WIDTH_6-myNewOffet;
            } else if (itemIndex == 7) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5+ITEM_WIDTH_6;
                rect.size.width = ITEM_WIDTH_7;
                
            }
        }
        
//item8
       
        else if (collectionViewOffsetX >= ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5+ITEM_WIDTH_6 && collectionViewOffsetX < ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5+ITEM_WIDTH_6+ITEM_WIDTH_7) {
            
            
            CGFloat myNewOffet = collectionViewOffsetX - ITEM_WIDTH_0 - ITEM_WIDTH_1 - ITEM_WIDTH_2-ITEM_WIDTH_3-ITEM_WIDTH_4-ITEM_WIDTH_5-ITEM_WIDTH_6;

            if (itemIndex == 0) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 1) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 2) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 3) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 4) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 5) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 6) {
                rect.origin.x = 0;
                rect.size.width = 0;
            } else if (itemIndex == 7) {
                rect.origin.x = collectionViewOffsetX;
                rect.size.width = ITEM_WIDTH_7-myNewOffet;
            }
            
//default
            
        } else {
            if (itemIndex == 0) {
                rect.origin.x = 0;
                rect.size.width = ITEM_WIDTH_0;
            } else if (itemIndex == 1) {
                rect.origin.x = ITEM_WIDTH_0;
                rect.size.width = ITEM_WIDTH_1;
            } else if (itemIndex == 2) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1;
                rect.size.width = ITEM_WIDTH_2;
            } else if (itemIndex == 3) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2;
                rect.size.width = ITEM_WIDTH_3;
            } else if (itemIndex == 4) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3;
                rect.size.width = ITEM_WIDTH_4;
            } else if (itemIndex == 5) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4;
                rect.size.width = ITEM_WIDTH_5;
            } else if (itemIndex == 6) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5;
                rect.size.width = ITEM_WIDTH_6;
            } else if (itemIndex == 7) {
                rect.origin.x = ITEM_WIDTH_0+ITEM_WIDTH_1+ITEM_WIDTH_2+ITEM_WIDTH_3+ITEM_WIDTH_4+ITEM_WIDTH_5+ITEM_WIDTH_6;
                rect.size.width = ITEM_WIDTH_7;
            }
        }
        
    
        myAttr.frame = rect;
    
    }

    return myAttr;

}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    UICollectionViewLayoutAttributes *myAttr = nil;
    for (int i = 0; i < NUMBER_OF_SECTIONS; i ++) {
        
        
        myAttr = [self layoutattributesforItem:0 sectionIndex:i];
        [layoutAttributes addObject:myAttr];

        myAttr = [self layoutattributesforItem:1 sectionIndex:i];
        [layoutAttributes addObject:myAttr];

        myAttr = [self layoutattributesforItem:2 sectionIndex:i];
        [layoutAttributes addObject:myAttr];

        myAttr = [self layoutattributesforItem:3 sectionIndex:i];
        [layoutAttributes addObject:myAttr];

        myAttr = [self layoutattributesforItem:4 sectionIndex:i];
        [layoutAttributes addObject:myAttr];
        
        myAttr = [self layoutattributesforItem:5 sectionIndex:i];
        [layoutAttributes addObject:myAttr];
        
        myAttr = [self layoutattributesforItem:6 sectionIndex:i];
        [layoutAttributes addObject:myAttr];
        
        myAttr = [self layoutattributesforItem:7 sectionIndex:i];
        [layoutAttributes addObject:myAttr];

        
    
    }
    

    return layoutAttributes;
}

@end
