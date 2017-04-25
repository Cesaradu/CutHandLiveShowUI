//
//  EditTableViewCell.m
//  CutHand
//
//  Created by hztuen on 2017/4/25.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "EditTableViewCell.h"

@implementation EditTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
        
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = [UIColor whiteColor];
        self.bgView.layer.cornerRadius = [self Suit:5];
        self.bgView.layer.shadowOffset = CGSizeMake([self Suit:2], [self Suit:2]);
        self.bgView.layer.shadowOpacity = 0.3;
        self.bgView.layer.shadowRadius = [self Suit:2];
        self.bgView.layer.shadowColor = [UIColor colorWithHexString:@"000000" alpha:0.5].CGColor;
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset([self Suit:-2]);
            make.left.equalTo(self.mas_left).offset([self Suit:15]);
            make.right.equalTo(self.mas_right).offset([self Suit:-15]);
            make.height.mas_equalTo([self Suit:65]);
        }];
        
        self.leftLabel = [UILabel labelWithColor:@"797676" AndFont:[self SuitFont:14] AndAlignment:NSTextAlignmentLeft];
        [self.bgView addSubview:self.leftLabel];
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bgView.mas_centerY);
            make.left.equalTo(self.bgView.mas_left).offset([self Suit:15]);
        }];
        
        self.arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow"]];
        [self.bgView addSubview:self.arrowImage];
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bgView.mas_centerY);
            make.right.equalTo(self.bgView.mas_right).offset([self Suit:-15]);
        }];
        
        self.headImage = [[UIImageView alloc] init];
        self.headImage.hidden = YES;
        self.headImage.layer.cornerRadius = [self Suit:24];
        self.headImage.backgroundColor = [UIColor colorWithHexString:MainColor alpha:1.0];
        [self.bgView addSubview:self.headImage];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bgView.mas_centerY);
            make.right.equalTo(self.arrowImage.mas_left).offset([self Suit:-10]);
            make.width.height.mas_equalTo([self Suit:48]);
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
