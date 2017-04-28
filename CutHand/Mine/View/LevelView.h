//
//  LevelView.h
//  CutHand
//
//  Created by hztuen on 2017/4/28.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelView : UIView

@property (nonatomic, strong) UIImageView *leftImage;
@property (nonatomic, strong) UIImageView *levelImage;
@property (nonatomic, strong) UIImageView *centerImage;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UILabel *label;

- (void)loadData:(NSInteger)index;

@end
