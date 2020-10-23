//
//  ViewController.h
//  customlayout_collectionview
//
//  Created by Rajeeva Ranjan on 14/02/17.
//  Copyright © 2017 Rajeeva Ranjan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface myCollectionViewController: UICollectionViewController

@end

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property UICollectionView *collectionView;
@property NSInteger numberItemsInsec1;
@property NSInteger numberItemsInsec2;


@end





