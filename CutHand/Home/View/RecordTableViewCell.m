//
//  RecordTableViewCell.m
//  CutHand
//
//  Created by hztuen on 2017/4/18.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "RecordTableViewCell.h"

@implementation RecordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
        
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor whiteColor];
        self.bgView.layer.cornerRadius = [self Suit:5];
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        self.headImage = [[UIImageView alloc] init];
        [self.bgView addSubview:self.headImage];
        self.headImage.layer.cornerRadius = [self Suit:65/2]/2;
        self.headImage.backgroundColor = [UIColor colorWithHexString:MainColor alpha:1.0];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset([self Suit:10]);
            make.left.equalTo(self.mas_left).offset([self Suit:10]);
            make.width.height.mas_equalTo([self Suit:65/2]);
        }];
        
        self.vipImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vip"]];
        [self.bgView addSubview:self.vipImage];
        [self.vipImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.headImage.mas_bottom);
            make.right.equalTo(self.headImage.mas_right).offset([self Suit:5]);
            make.width.height.mas_equalTo([self Suit:16]);
        }];
        
        self.nameLabel = [UILabel labelWithTitle:@"Cesar" AndColor:@"7E7B7B" AndFont:[self SuitFont:13] AndAlignment:NSTextAlignmentCenter];
        [self.bgView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImage.mas_top);
            make.left.equalTo(self.vipImage.mas_right).offset([self Suit:5]);
        }];
        
        self.statusLabel = [UILabel labelWithTitle:@"直播中" AndColor:@"B0B0B1" AndFont:[self SuitFont:11] AndAlignment:NSTextAlignmentCenter];
        [self.bgView addSubview:self.statusLabel];
        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.headImage.mas_bottom);
            make.left.equalTo(self.vipImage.mas_right).offset([self Suit:5]);
        }];
        
        self.location = [UILabel labelWithTitle:@"浙江 杭州" AndColor:@"79BFFA" AndFont:[self SuitFont:11] AndAlignment:NSTextAlignmentCenter];
        [self.bgView addSubview:self.location];
        [self.location mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImage.mas_top);
            make.right.equalTo(self.mas_right).offset([self Suit:-10]);
        }];
        
        self.countLabel = [UILabel labelWithTitle:@"7860 在看" AndColor:@"B0B0B1" AndFont:[self SuitFont:11] AndAlignment:NSTextAlignmentCenter];
        [self.bgView addSubview:self.countLabel];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.headImage.mas_bottom);
            make.right.equalTo(self.mas_right).offset([self Suit:-10]);
        }];
        
        self.bigImage = [[UIImageView alloc] init];
        self.bigImage.layer.cornerRadius = [self Suit:5];
        self.bigImage.backgroundColor = [UIColor colorWithHexString:MainColor alpha:1.0];
        [self.bgView addSubview:self.bigImage];
        [self.bigImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImage.mas_bottom).offset([self Suit:10]);
            make.centerX.equalTo(self.mas_centerX);
            make.width.height.mas_equalTo([self Suit:330]);
        }];
        
        self.tagImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tag"]];
        [self.bgView addSubview:self.tagImage];
        [self.tagImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bigImage.mas_bottom).offset([self Suit:10]);
            make.left.equalTo(self.headImage.mas_left);
        }];
        
        self.image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tagImage1"]];
        [self.bgView addSubview:self.image1];
        [self.image1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.tagImage.mas_centerY);
            make.left.equalTo(self.tagImage.mas_right).offset([self Suit:5]);
        }];
        
        self.image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tagImage2"]];
        [self.bgView addSubview:self.image2];
        [self.image2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.tagImage.mas_centerY);
            make.left.equalTo(self.image1.mas_right).offset([self Suit:5]);
        }];
        
        
    }
    return self;
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
