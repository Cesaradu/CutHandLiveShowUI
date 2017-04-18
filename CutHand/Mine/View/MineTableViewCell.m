//
//  MineTableViewCell.m
//  CutHand
//
//  Created by hztuen on 2017/4/13.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "MineTableViewCell.h"

@implementation MineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.leftImage = [[UIImageView alloc] init];
        self.leftImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.leftImage];
        [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset([self Suit:15]);
            make.width.height.mas_equalTo([self Suit:18]);
        }];
        
        self.leftLabel = [UILabel labelWithColor:@"666666" AndFont:[self SuitFont:14] AndAlignment:NSTextAlignmentLeft];
        self.leftLabel.text = @"剁手号";
        [self addSubview:self.leftLabel];
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.leftImage.mas_right).offset([self Suit:10]);
        }];
        
        self.arrowImage = [[UIImageView alloc] init];
        self.arrowImage.image = [UIImage imageNamed:@"right_arrow"];
        self.arrowImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.arrowImage];
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset([self Suit:-10]);
            make.width.height.mas_equalTo([self Suit:13]);
        }];
        
        self.rightLabel = [UILabel labelWithColor:@"999999" AndFont:[self SuitFont:12] AndAlignment:NSTextAlignmentRight];
        self.rightLabel.text = @"12345678";
        [self addSubview:self.rightLabel];
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.arrowImage.mas_left).offset([self Suit:-10]);
            make.centerY.equalTo(self.mas_centerY);
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
