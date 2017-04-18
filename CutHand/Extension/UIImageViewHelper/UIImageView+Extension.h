//
//  UIImageView+Extension.h
//  OKSheng
//
//  Created by hztuen on 17/3/20.
//  Copyright © 2017年 hztuen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)

// 图片，圆角
+ (UIImageView *)imageViewWithImage:(NSString *)imageName AndCornerRadius:(CGFloat)cornerRadius;

@end
