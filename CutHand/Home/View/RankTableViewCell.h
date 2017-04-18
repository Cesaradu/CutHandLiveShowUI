//
//  RankTableViewCell.h
//  CutHand
//
//  Created by hztuen on 2017/4/17.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *numImage;//排名
@property (nonatomic, strong) UILabel *numLabel;//排名
@property (nonatomic, strong) UIImageView *headImage;//头像
@property (nonatomic, strong) UIImageView *vipImage;//vip
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *sexImage;//性别
@property (nonatomic, strong) UIImageView *levelImage;//等级
@property (nonatomic, strong) UILabel *receiveNumLabel;//收到
@property (nonatomic, strong) UIButton *focusBtn;//关注按钮

@property (nonatomic,copy) void (^clickFocusBlock)();//点击关注

@end
