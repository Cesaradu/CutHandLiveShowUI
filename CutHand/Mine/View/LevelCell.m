//
//  LevelCell.m
//  CutHand
//
//  Created by hztuen on 2017/4/28.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "LevelCell.h"

@implementation LevelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.leftImage = [[UIImageView alloc] init];
        [self addSubview:self.leftImage];
        [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset([self Suit:15]);
        }];
        
        self.label1 = [UILabel labelWithColor:@"7F7F7F" AndFont:[self SuitFont:17] AndAlignment:NSTextAlignmentCenter];
        [self addSubview:self.label1];
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftImage.mas_top);
            make.left.equalTo(self.leftImage.mas_right).offset([self Suit:15]);
        }];
        
        self.label2 = [UILabel labelWithColor:@"C0C0C0" AndFont:[self SuitFont:14] AndAlignment:NSTextAlignmentCenter];
        [self addSubview:self.label2];
        [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.leftImage.mas_bottom);
            make.left.equalTo(self.leftImage.mas_right).offset([self Suit:15]);
        }];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
