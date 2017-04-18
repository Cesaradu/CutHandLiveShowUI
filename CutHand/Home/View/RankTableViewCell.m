//
//  RankTableViewCell.m
//  CutHand
//
//  Created by hztuen on 2017/4/17.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "RankTableViewCell.h"

@implementation RankTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.numImage = [[UIImageView alloc] init];
        [self addSubview:self.numImage];
        [self.numImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset([self Suit:15]);
            make.width.mas_equalTo([self Suit:59/2]);
            make.height.mas_equalTo([self Suit:67/2]);
        }];
        
        self.numLabel = [UILabel labelWithTitle:@"" AndColor:@"000000" AndFont:[self SuitFont:15] AndAlignment:NSTextAlignmentCenter];
        [self addSubview:self.numLabel];
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset([self Suit:15]);
            make.width.mas_equalTo([self Suit:59/2]);
            make.height.mas_equalTo([self Suit:67/2]);
        }];
        
        self.headImage = [[UIImageView alloc] init];
        self.headImage.backgroundColor = [UIColor colorWithHexString:MainColor alpha:1.0];
        self.headImage.layer.cornerRadius = [self Suit:24];
        [self addSubview:self.headImage];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.numImage.mas_right).offset([self Suit:5]);
            make.width.height.mas_equalTo([self Suit:48]);
        }];
        
        self.vipImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vip"]];
        [self addSubview:self.vipImage];
        [self.vipImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.headImage.mas_bottom);
            make.right.equalTo(self.headImage.mas_right).offset([self Suit:5]);
        }];
        
        self.nameLabel = [UILabel labelWithTitle:@"Cesar" AndColor:@"7E7B7B" AndFont:[self SuitFont:14] AndAlignment:NSTextAlignmentLeft];
        [self addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImage.mas_top);
            make.left.equalTo(self.headImage.mas_right).offset([self Suit:8]);
        }];
        
        self.sexImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"female"]];
        [self addSubview:self.sexImage];
        [self.sexImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel.mas_centerY);
            make.left.equalTo(self.nameLabel.mas_right).offset([self Suit:2]);
        }];
        
        self.levelImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"level3"]];
        [self addSubview:self.levelImage];
        [self.levelImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel.mas_centerY);
            make.left.equalTo(self.sexImage.mas_right).offset([self Suit:2]);
        }];
        
        self.receiveNumLabel = [UILabel labelWithTitle:@"收到xxxxxx" AndColor:@"c2c2c2" AndFont:[self SuitFont:13] AndAlignment:NSTextAlignmentLeft];
        [self addSubview:self.receiveNumLabel];
        [self.receiveNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.headImage.mas_bottom).offset([self Suit:-5]);
            make.left.equalTo(self.nameLabel.mas_left);
        }];
        
        self.focusBtn = [[UIButton alloc] init];
        [self.focusBtn setImage:[UIImage imageNamed:@"unfollow2"] forState:UIControlStateNormal];
        [self.focusBtn setImage:[UIImage imageNamed:@"followed2"] forState:UIControlStateSelected];
        [self.focusBtn addTarget:self action:@selector(clickFocusBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.focusBtn];
        [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset([self Suit:-15]);
        }];
        
    }
    return self;
}

- (void)clickFocusBtn {
    
    self.focusBtn.selected = !self.focusBtn.selected;
    
    if (self.clickFocusBlock) {
        self.clickFocusBlock();
    }
}

/**
 适配 给定4.7寸屏尺寸，适配4和5.5寸屏尺寸
 */
- (float)Suit:(float)MySuit
{
    (IS_IPHONE4INCH||IS_IPHONE35INCH)?(MySuit=MySuit/Suit4Inch):((IS_IPHONE55INCH)?(MySuit=MySuit*Suit55Inch):MySuit);
    return MySuit;
}

/**
 适配 给定4.7寸屏字号，适配4(-1)和5.5(+1)寸屏字号
 */
- (float)SuitFont:(float)font
{
    (IS_IPHONE4INCH||IS_IPHONE35INCH)?(font=font-1):((IS_IPHONE55INCH)?(font=font+1):font);
    return font;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
