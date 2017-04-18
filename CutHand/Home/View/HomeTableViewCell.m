//
//  HomeTableViewCell.m
//  CutHand
//
//  Created by hztuen on 2017/4/13.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.bgImageView = [[UIImageView alloc] init];
        self.bgImageView.backgroundColor = [UIColor colorWithHexString:@"ffbcd2" alpha:1.0];
        [self addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(ScreenWidth);
        }];
        
        self.statusImage = [[UIImageView alloc] init];
        self.statusImage.image = [UIImage imageNamed:@"on_live"];
        [self addSubview:self.statusImage];
        [self.statusImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset([self Suit:10]);
            make.right.equalTo(self.mas_right).offset([self Suit:-10]);
        }];
        
        //蒙板
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenWidth-[self Suit:100], ScreenWidth, [self Suit:100])];
        bgView.backgroundColor = [UIColor clearColor];
        CAGradientLayer *grayBgLayer = [CAGradientLayer layer];
        grayBgLayer.frame = bgView.bounds;
        grayBgLayer.colors = @[(id)[UIColor colorWithHexString:@"000000" alpha:0.29f].CGColor, (id)[UIColor colorWithHexString:@"000000" alpha:0.0f].CGColor];
        grayBgLayer.startPoint = CGPointMake(1, 1);
        grayBgLayer.endPoint = CGPointMake(1, 0);
        [bgView.layer insertSublayer:grayBgLayer atIndex:0];
        [self.bgImageView addSubview:bgView];
        
        self.nameLabel = [UILabel labelWithTitle:@"Cesar Du" AndColor:@"ffffff" AndFont:0 AndAlignment:NSTextAlignmentCenter];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:[self SuitFont:18]];
        [bgView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgView.mas_centerX);
            make.top.equalTo(bgView.mas_top).offset([self Suit:15]);
            make.width.mas_equalTo(ScreenWidth-[self Suit:30]);
        }];
        
        self.titleLabel = [UILabel labelWithTitle:@"今天晚上公司有拍摄哦，宝宝们晚上见～" AndColor:@"ffffff" AndFont:[self SuitFont:12] AndAlignment:NSTextAlignmentCenter];
        [bgView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgView.mas_centerX);
            make.top.equalTo(self.nameLabel.mas_bottom).offset([self Suit:10]);
            make.width.mas_equalTo(ScreenWidth-[self Suit:30]);
        }];
        
        self.audienceNum = [UIButton buttonWithTitle:@"3467" AndTitleColor:@"ffffff" AndTitleFont:[self SuitFont:12] AndBackgroundColor:nil addTarget:self action:nil];
        [self.audienceNum setImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
        self.audienceNum.titleEdgeInsets = UIEdgeInsetsMake(0, [self Suit:2.5], 0, [self Suit:-2.5]);
        self.audienceNum.imageEdgeInsets = UIEdgeInsetsMake(0, [self Suit:-2.5], 0, [self Suit:2.5]);
        [bgView addSubview:self.audienceNum];
        [self.audienceNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset([self Suit:10]);
            make.left.equalTo(bgView.mas_left).offset([self Suit:30]);
            make.right.equalTo(bgView.mas_centerX).offset([self Suit:-30]);
        }];
        
        self.location = [UIButton buttonWithTitle:@"杭州" AndTitleColor:@"ffffff" AndTitleFont:[self SuitFont:12] AndBackgroundColor:nil addTarget:self action:nil];
        [self.location setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
        self.location.titleEdgeInsets = UIEdgeInsetsMake(0, [self Suit:2.5], 0, [self Suit:-2.5]);
        self.location.imageEdgeInsets = UIEdgeInsetsMake(0, [self Suit:-2.5], 0, [self Suit:2.5]);
        [bgView addSubview:self.location];
        [self.location mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset([self Suit:10]);
            make.right.equalTo(bgView.mas_right).offset([self Suit:-30]);
            make.left.equalTo(bgView.mas_centerX).offset([self Suit:30]);
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
