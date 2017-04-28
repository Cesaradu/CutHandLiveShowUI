//
//  LevelView.m
//  CutHand
//
//  Created by hztuen on 2017/4/28.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "LevelView.h"

@implementation LevelView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.leftImage = [[UIImageView alloc] init];
        self.leftImage.image = [UIImage imageNamed:@"level_bg"];
        [self addSubview:self.leftImage];
        [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.mas_top);
        }];
        
        self.levelImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LV_1"]];
        [self addSubview:self.levelImage];
        [self.levelImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.leftImage.mas_centerX);
            make.centerY.equalTo(self.leftImage.mas_centerY);
        }];
        
        self.centerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"level_image"]];
        [self addSubview:self.centerImage];
        [self.centerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).offset([self Suit:50]);
        }];
        
        self.progressView = [[UIProgressView alloc] init];
        self.progressView.layer.cornerRadius = [self Suit:2.5];
        self.progressView.layer.masksToBounds = YES;
        self.progressView.trackTintColor = [UIColor whiteColor];
        [self addSubview:self.progressView];
        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.centerImage.mas_bottom).offset([self Suit:25]);
            make.width.mas_equalTo(frame.size.width-[self Suit:30]);
            make.height.mas_equalTo([self Suit:5]);
        }];
        
        self.label = [UILabel labelWithTitle:@"1/100 积分成长" AndColor:@"ffffff" AndFont:[self SuitFont:14] AndAlignment:NSTextAlignmentCenter];
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.progressView.mas_bottom).offset([self Suit:20]);
        }];
        
    }
    return self;
}

- (void)loadData:(NSInteger)index {
    if (index == 0) {
        self.backgroundColor = [UIColor colorWithHexString:@"FAB65F" alpha:1.0];
        self.label.text = @"1/100 积分成长";
        self.progressView.progress = 0.5;
        self.progressView.tintColor = [UIColor colorWithHexString:@"FFEAC8" alpha:1.0];
        self.layer.shadowColor = [UIColor colorWithHexString:@"FAB65F" alpha:1.0].CGColor;
    } else if (index == 1) {
        self.backgroundColor = [UIColor colorWithHexString:@"B8E986" alpha:1.0];
        self.label.text = @"100/200 积分成长";
        self.progressView.progress = 0.5;
        self.progressView.tintColor = [UIColor colorWithHexString:@"7ED321" alpha:1.0];
        self.layer.shadowColor = [UIColor colorWithHexString:@"B8E986" alpha:1.0].CGColor;
    } else {
        self.backgroundColor = [UIColor colorWithHexString:@"97C7FF" alpha:1.0];
        self.label.text = @"200/300 积分成长";
        self.progressView.progress = 0.5;
        self.progressView.tintColor = [UIColor colorWithHexString:@"4990E2" alpha:1.0];
        self.layer.shadowColor = [UIColor colorWithHexString:@"97C7FF" alpha:1.0].CGColor;
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
