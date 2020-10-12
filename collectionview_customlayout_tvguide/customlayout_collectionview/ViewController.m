//
//  ViewController.m
//  collectionview
//
//  Created by Rajeeva Ranjan on 10/02/17.
//  Copyright © 2017 Rajeeva Ranjan. All rights reserved.
//

#import "ViewController.h"
#import "constants.h"
#import "CustomCollectionViewCell.h"
#import "headerfooterview.h"
#import "CustomFlowLayout.h"
#import "CustomCollectionViewLayout.h"

@implementation myCollectionViewController



@end

@implementation ViewController
@synthesize collectionView, numberItemsInsec1, numberItemsInsec2;


- (void)mymessage
{
    //NSLog(@"kjk");
}

- (void)gcAction:(UILongPressGestureRecognizer *)gc
{
    switch (gc.state) {
        case UIGestureRecognizerStateBegan:
        {
            NSLog(@"started with point %@", NSStringFromCGPoint([gc locationInView:collectionView]));
            CGPoint point = [gc locationInView:collectionView];
            NSIndexPath *selectedIndex = [collectionView indexPathForItemAtPoint:point];
            if (!selectedIndex) {
                break;
            }
            [collectionView beginInteractiveMovementForItemAtIndexPath:selectedIndex];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            NSLog(@"chnaged with point %@", NSStringFromCGPoint([gc locationInView:collectionView]));
            CGPoint point = [gc locationInView:collectionView];
            
            [collectionView updateInteractiveMovementTargetPosition:point];
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"ended with point %@", NSStringFromCGPoint([gc locationInView:collectionView]));

            [collectionView endInteractiveMovement];
            break;
        }
        default:
            
            
        [collectionView cancelInteractiveMovement];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    numberItemsInsec1 = NUMBER_OF_ITEMS_IN_SEC1;
    numberItemsInsec2 = NUMBER_OF_ITEMS_IN_SEC2;
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    
    collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, CV_WIDTH, CV_HEIGHT) collectionViewLayout:flowLayout];
    //collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    //collectionView.bounces = NO;
    
    UILongPressGestureRecognizer *gc = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(gcAction:)];
    //gc.allowableMovement = 500;
    
    [collectionView addGestureRecognizer:gc];
    
    
    //UICollectionViewController *myCVC = [[UICollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    //myCVC.collectionView = collectionView;

    //collectionView.allowsMultipleSelection = YES;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CV_WIDTH, CV_HEIGHT)];
    bgView.backgroundColor = [UIColor cyanColor];
    collectionView.backgroundView = bgView;
    collectionView.directionalLockEnabled = YES;
    //collectionView.multipleTouchEnabled = YES;
    
 //   [self setVerticalLayoutAttribtes];

    [self setCustomLayoutAttibutes];
    
    [collectionView setDataSource:self];
    [collectionView setDelegate:self];
    [collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [collectionView registerClass:[headerfooterview class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [collectionView registerClass:[headerfooterview class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:collectionView];
    
    
    UIButton *b1 = [UIButton buttonWithType:UIButtonTypeSystem];
    b1.frame = CGRectMake(0, DEVICE_HEIGHT -50, 130, 50);
    [b1 setTitle:@"Vertical Layout" forState:0];
    [b1 setTitle:@"Vertical Layout" forState:1];
    [b1 addTarget:self action:@selector(actionV) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:b1];
    
    UIButton *b2 = [UIButton buttonWithType:UIButtonTypeSystem];
    b2.frame = CGRectMake(130, DEVICE_HEIGHT -50, 150, 50);
    [b2 setTitle:@"Horizontal Layout" forState:0];
    [b2 setTitle:@"Horizontal Layout" forState:1];
    [b2 addTarget:self action:@selector(actionH) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:b2];
    
    UIButton *b3 = [UIButton buttonWithType:UIButtonTypeSystem];
    b3.frame = CGRectMake(280, DEVICE_HEIGHT -50, 130, 50);
    [b3 setTitle:@"Custom Layout" forState:0];
    [b3 setTitle:@"Custom Layout" forState:1];
    [b3 addTarget:self action:@selector(actionC) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:b3];
    
    
    UIButton *b4 = [UIButton buttonWithType:UIButtonTypeSystem];
    b4.frame = CGRectMake(0, DEVICE_HEIGHT -100, 130, 50);
    [b4 setTitle:@"Add at one" forState:0];
    [b4 setTitle:@"Add at one" forState:1];
    [b4 addTarget:self action:@selector(addAtOne) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:b4];
    
    
    UIButton *b5 = [UIButton buttonWithType:UIButtonTypeSystem];
    b5.frame = CGRectMake(150, DEVICE_HEIGHT -100, 130, 50);
    [b5 setTitle:@"Remove at one" forState:0];
    [b5 setTitle:@"Remove at one" forState:1];
    [b5 addTarget:self action:@selector(removeFromOne) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:b5];

    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark ADD/REMOVE apis

- (void)addAtOne
{
    numberItemsInsec1++;
    [collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:1 inSection:0]]];
}


- (void)removeFromOne
{
    numberItemsInsec1--;
    [collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:1 inSection:0]]];

}

#pragma mark LAYOUT TYPE SETUP

- (void)setVerticalLayoutAttribtes
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 1;
    
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
    //flowLayout.estimatedItemSize = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
    
    flowLayout.headerReferenceSize = CGSizeMake(50, 50);
    flowLayout.footerReferenceSize = CGSizeMake(100, 100);
    [collectionView setCollectionViewLayout:flowLayout animated:YES];
}

- (void)setHorizontalLayoutAttribtes
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    //flowLayout.estimatedItemSize = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
    
    flowLayout.headerReferenceSize = CGSizeMake(50, 50);
    flowLayout.footerReferenceSize = CGSizeMake(100, 0100);
    
    [collectionView setCollectionViewLayout:flowLayout animated:YES];
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (void)setCustomLayoutAttibutes
{
    CustomCollectionViewLayout *layout = [[CustomCollectionViewLayout alloc] init];
    [collectionView setCollectionViewLayout:layout animated:YES];
    numberItemsInsec1 = NUMBER_OF_TIME_SLOTS;
    numberItemsInsec2 = NUMBER_OF_TIME_SLOTS;
    [collectionView reloadData];
    
}

- (void)actionV
{
    [self setVerticalLayoutAttribtes];
}

- (void)actionH
{
//    [collectionView reloadData];
//    CGSize size = [collectionView sizeThatFits:CGSizeMake(300, 5000)];
//    collectionView.frame = CGRectMake(0, 20, size.width, size.height);
    
    [self setHorizontalLayoutAttribtes];
}

- (void)actionC
{
    [self setCustomLayoutAttibutes];
}


#pragma mark COLLECTION VIEW SETUP

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return numberItemsInsec1;
    } else {
        return numberItemsInsec2;
    }
    return numberItemsInsec1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return NUMBER_OF_SECTIONS;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
/*    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    //[UIView setAnimationDelegate:cell];
    cell.layer.opacity = 0.6;
    [UIView commitAnimations];
*/
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView1 viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index path %@", indexPath);
    UICollectionReusableView *view = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        view = [collectionView1 dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        view.backgroundColor = [UIColor redColor];
    } else {
        view = [collectionView1 dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        view.backgroundColor = [UIColor greenColor];
    }
    return view;
}


//First item, width and height = 20%
//2nd item, width & height = 30 %
//3rd item, width & height = 40 %
//
//4th item, width & height = 20%
//5th item, width & height = 20%
//6th item, width & height = 20%
//7th item, width & height = 20%
//
//8th item, width & height = 50%


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    if (indexPath.item == 0) {
        size = CGSizeMake(CV_WIDTH*.2, CV_WIDTH*.2);//CGSizeMake(200, 50);
    } else if (indexPath.item == 1) {
        size = CGSizeMake(CV_WIDTH*.3, CV_WIDTH*.3);//CGSizeMake(100, 100);
    } else if (indexPath.item == 2) {
        size = CGSizeMake(CV_WIDTH*.4, CV_WIDTH*.4);//CGSizeMake(50, 200);
    } else if (indexPath.item == 3){
        size = CGSizeMake(CV_WIDTH*.2, CV_WIDTH*.2);//CGSizeMake(270, 100);
    } else if (indexPath.item == 4) {
        size = CGSizeMake(CV_WIDTH*.2, CV_WIDTH*.2);//CGSizeMake(100, 100);
    } else if (indexPath.item == 5) {
        size = CGSizeMake(CV_WIDTH*.2, CV_WIDTH*.2);//CGSizeMake(50, 200);
    } else if (indexPath.item == 6) {
        size = CGSizeMake(CV_WIDTH*.2, CV_WIDTH*.2);//CGSizeMake(270, 100);
    } else if (indexPath.item == 7) {
        size = CGSizeMake(CV_WIDTH*.5, CV_WIDTH*.5);//CGSizeMake(270, 100);
        
    } else {
        size = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
    }
    return size;
}

//- (void)collectionView:(UICollectionView *)collectionView1 didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"cell selected");
//}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (CustomCollectionViewCell *)collectionView:(UICollectionView *)collectionView1 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *cell = [collectionView1 dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.clipsToBounds = YES;
    cell.backgroundColor = [UIColor clearColor];
    cell.layer.borderWidth = 1;
    
    UIView *bv = [[UIView alloc] initWithFrame:cell.frame];
    bv.backgroundColor = [UIColor lightGrayColor];
    UIView *sbv = [[UIView alloc] initWithFrame:cell.frame];
    sbv.backgroundColor = [UIColor purpleColor];
    cell.backgroundView = bv;
    cell.selectedBackgroundView = sbv;
    
    
    if (!cell.myLabel) {
        //cell.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        cell.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        cell.myLabel.opaque = YES;
        //cell.myLabel.lineBreakMode = NSLineBreakByTruncatingTail;

        [cell.myLabel setTextColor:[UIColor blackColor]];
        cell.myLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:cell.myLabel];
    
    }
    
    if (indexPath.section == 4) {
        if (indexPath.item == 0) {
            cell.myLabel.frame = CGRectMake(0, 0, CV_WIDTH, 40);
            cell.myLabel.text = @"ADVERTISEMENT";
        } else {
            cell.myLabel.frame = CGRectMake(0, 0, 40, 40);
            cell.myLabel.text = nil;
            
        }
    } else if (indexPath.section) {
        cell.myLabel.text = [[@"p" stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)indexPath.section]] stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)indexPath.item+1]];
    } else {
        cell.myLabel.text = [@"" stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)indexPath.item+1]];
    }
    
    return cell;
}

#pragma mark COPY PASTE


//- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//static int itemcopied = 0;
//
//- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
//{
//    return YES;
//}
//- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
//{
//    if ([NSStringFromSelector(action) isEqualToString:@"cut:"]) {
//        [self removeFromOne];
//    }
//    
//    if ([NSStringFromSelector(action) isEqualToString:@"paste:"]) {
//        [self addAtOne];
//    }
//}

#pragma mark ITEM MOVE CODE

//- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    
    
}



@end
