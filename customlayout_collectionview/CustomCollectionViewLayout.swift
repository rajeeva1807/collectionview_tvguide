//
//  CustomCollectionViewLayout.swift
//  customlayout_collectionview
//
//  Created by Rajeeva Ranjan on 20/10/20.
//  Copyright © 2020 Rajeeva Ranjan. All rights reserved.
//

import Foundation
import UIKit

var ITEM_WIDTH_0: CGFloat = 0.0
var ITEM_WIDTH_1: CGFloat = 0.0
var ITEM_WIDTH_2: CGFloat = 0.0
var ITEM_WIDTH_3: CGFloat = 0.0
var ITEM_WIDTH_4: CGFloat = 0.0
var ITEM_WIDTH_5: CGFloat = 0.0
var ITEM_WIDTH_6: CGFloat = 0.0
var ITEM_WIDTH_7: CGFloat = 0.0


let CV_WIDTH = UIScreen.main.bounds.size.width;
let CV_HEIGHT = UIScreen.main.bounds.size.height-175


class CustomCollectionViewLayout: UICollectionViewLayout {
    
    override public init() {
        super.init()
        register(decorationview.self, forDecorationViewOfKind: "decview")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    open override var collectionViewContentSize: CGSize {
        
        return CGSize(width: Int(HEADER_WIDTH*NUMBER_OF_TIME_SLOTS), height: Int(NUMBER_OF_SECTIONS*CHANNEL_HEIGHT))
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        var myAttr: UICollectionViewLayoutAttributes!
        
        for i in 0...NUMBER_OF_SECTIONS-1 {
            
            //8 items per section
            for j in 0...NUMBER_OF_ITEMS_CUSTOM_LAYOUT-1 {
                
                myAttr = customlayoutAttributesForItem(at: IndexPath(item: Int(j), section: Int(i)))
                layoutAttributes.append(myAttr!)
            }
        }

        return layoutAttributes
    }
    
    func fillDataForSection(sectionIndex: NSInteger) {
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
    
    func customlayoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let myAttr = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: indexPath.item, section: indexPath.section))
        myAttr.frame = CGRect(x: indexPath.item*Int(HEADER_WIDTH), y: indexPath.section*Int(CHANNEL_HEIGHT), width: Int(HEADER_WIDTH), height: Int(CHANNEL_HEIGHT))
        
        let collectionViewOffsetX = self.collectionView!.contentOffset.x
        
        var rect = myAttr.frame;
        
        let sectionIndex = indexPath.section
        let itemIndex = indexPath.item
        var myNewOffet: CGFloat
        
        if (sectionIndex == 4) {
            
            if (itemIndex == 0) {
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
            
            
        } else if (sectionIndex != 0) {
            
            fillDataForSection(sectionIndex: sectionIndex)
                
            //Following logic handles sliding effect on the left most cell with the change in content offset
           
            
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
                
                myNewOffet = collectionViewOffsetX - ITEM_WIDTH_0;
                
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
                
                myNewOffet = collectionViewOffsetX - ITEM_WIDTH_0 - ITEM_WIDTH_1;

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
                
                myNewOffet = collectionViewOffsetX - ITEM_WIDTH_0 - ITEM_WIDTH_1 - ITEM_WIDTH_2;

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
                
                myNewOffet = collectionViewOffsetX - ITEM_WIDTH_0 - ITEM_WIDTH_1 - ITEM_WIDTH_2 - ITEM_WIDTH_3;

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
                
                myNewOffet = collectionViewOffsetX - ITEM_WIDTH_0 - ITEM_WIDTH_1 - ITEM_WIDTH_2 - ITEM_WIDTH_3 - ITEM_WIDTH_4;

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
                
                myNewOffet = collectionViewOffsetX - ITEM_WIDTH_0 - ITEM_WIDTH_1 - ITEM_WIDTH_2 - ITEM_WIDTH_3 - ITEM_WIDTH_4 - ITEM_WIDTH_5;

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
                
                myNewOffet = collectionViewOffsetX - ITEM_WIDTH_0 - ITEM_WIDTH_1 - ITEM_WIDTH_2-ITEM_WIDTH_3-ITEM_WIDTH_4-ITEM_WIDTH_5-ITEM_WIDTH_6;

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
            }
            
            //default
            else {
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

}


