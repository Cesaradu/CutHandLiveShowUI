//
//  HomeTableViewCell.h
//  CutHand
//
//  Created by hztuen on 2017/4/13.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *bgImageView;//背景图
@property (nonatomic, strong) UIImageView *statusImage;//直播状态图
@property (nonatomic, strong) UILabel *nameLabel;//名字
@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic, strong) UIButton *audienceNum;//观看人数
@property (nonatomic, strong) UIButton *location;//位置


@end
