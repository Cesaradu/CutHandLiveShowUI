//
//  ADTabBar.m
//  CutHand
//
//  Created by hztuen on 2017/4/13.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "ADTabBar.h"

@interface ADTabBar ()

@property (nonatomic, strong) UIButton *centerBtn;

@end

@implementation ADTabBar

//重写方法，调整tabbar中包含的3个按钮的位置
- (void)layoutSubviews
{
    //一定要调用父类原有的布局方法，在这个基础上
    //再来调35个按钮的位置
    [super layoutSubviews];
    
    //1.设置中间按钮的位置
    CGPoint center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
    self.centerBtn.center = center;
    
    //2.设置其他tabBarItem的位置和尺寸
    CGFloat tabBarButtonW = self.frame.size.width / 3;
    
    NSInteger buttonIndex = 0;
    //遍历tabBar中的所有子视图
    //只有当遍历到的子视图的类型是UITabBarButton
    //时，才代表找到的其他按钮，调整位置即可
    for (UIView *child in self.subviews) {
        //获取UITabBarButton的类型描述信息
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            CGRect frame = child.frame;
            if (buttonIndex<1) {
                frame.origin.x = tabBarButtonW*buttonIndex;
            } else {
                frame.origin.x = tabBarButtonW*(buttonIndex+1);
            }
            frame.size.width = tabBarButtonW;
            child.frame = frame;
            buttonIndex++;
        }
    }
    
    [self addSubview:self.centerBtn];
    
}

- (UIButton *)centerBtn {
    
    if (_centerBtn == nil) {
        
        CGFloat width = self.frame.size.width/3;
        _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _centerBtn.adjustsImageWhenHighlighted = NO;
        _centerBtn.frame = CGRectMake(width, 1, width, 47);
        [_centerBtn setImage:[UIImage imageNamed:@"tabbar_center"] forState:UIControlStateNormal];
        [_centerBtn addTarget:self action:@selector(centerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn;
}

//点击中间按钮的响应
-(void)centerButtonClick
{
    [self.adDelegate tabBarDidClickCenterButton:self];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
