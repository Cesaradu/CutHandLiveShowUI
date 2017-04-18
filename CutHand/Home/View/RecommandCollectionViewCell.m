//
//  RecommandCollectionViewCell.m
//  CutHand
//
//  Created by hztuen on 2017/4/14.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "RecommandCollectionViewCell.h"

@implementation RecommandCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.bgImageView = [[UIImageView alloc] init];
        self.bgImageView.layer.cornerRadius = [self Suit:5];
        self.bgImageView.layer.masksToBounds = YES;
        self.bgImageView.backgroundColor = [UIColor colorWithHexString:@"ffbcd2" alpha:1.0];
        [self addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        self.statusImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"on_live"]];
        [self addSubview:self.statusImage];
        [self.statusImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset([self Suit:5]);
            make.right.equalTo(self.mas_right).offset([self Suit:-5]);
            make.width.mas_equalTo([self Suit:40]);
            make.height.mas_equalTo([self Suit:16]);
        }];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, [self Suit:115-30], self.frame.size.width, [self Suit:30])];
        bgView.backgroundColor = [UIColor clearColor];
        CAGradientLayer *grayBgLayer = [CAGradientLayer layer];
        grayBgLayer.frame = bgView.bounds;
        grayBgLayer.colors = @[(id)[UIColor colorWithHexString:@"000000" alpha:0.29f].CGColor, (id)[UIColor colorWithHexString:@"000000" alpha:0.0f].CGColor];
        grayBgLayer.startPoint = CGPointMake(1, 1);
        grayBgLayer.endPoint = CGPointMake(1, 0);
        [bgView.layer insertSublayer:grayBgLayer atIndex:0];
        [self.bgImageView addSubview:bgView];
        
        self.audienceNum = [UIButton buttonWithTitle:@"3467" AndTitleColor:@"ffffff" AndTitleFont:[self SuitFont:10] AndBackgroundColor:nil addTarget:self action:nil];
        [self.audienceNum setImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
        self.audienceNum.titleEdgeInsets = UIEdgeInsetsMake(0, [self Suit:2.5], 0, [self Suit:-2.5]);
        self.audienceNum.imageEdgeInsets = UIEdgeInsetsMake(0, [self Suit:-2.5], 0, [self Suit:2.5]);
        [bgView addSubview:self.audienceNum];
        [self.audienceNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(bgView.mas_bottom).offset([self Suit:-5]);
            make.right.equalTo(bgView.mas_right).offset([self Suit:-5]);
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

@end
