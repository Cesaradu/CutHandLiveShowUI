//
//  CategoryTableViewCell.h
//  CutHand
//
//  Created by hztuen on 2017/4/14.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryTableViewCell : UITableViewCell

@property (nonatomic, strong) UICollectionView *collectionView;

- (void)loadData:(NSIndexPath *)indexPath;

@end
