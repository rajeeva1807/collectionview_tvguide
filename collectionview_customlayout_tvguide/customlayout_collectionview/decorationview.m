//
//  decorationview.m
//  customlayout_collectionview
//
//  Created by Rajeeva Ranjan on 02/04/17.
//  Copyright © 2017 Rajeeva Ranjan. All rights reserved.
//

#import "decorationview.h"

@implementation decorationview


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor lightGrayColor]];
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSizeMake(0,5);
        self.layer.zPosition = 0;
    }
    return self;
}

@end
