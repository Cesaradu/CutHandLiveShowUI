//
//  UIImageView+Extension.m
//  OKSheng
//
//  Created by hztuen on 17/3/20.
//  Copyright © 2017年 hztuen. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

+ (UIImageView *)imageViewWithImage:(NSString *)imageName AndCornerRadius:(CGFloat)cornerRadius
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:imageName];
    if (cornerRadius)
    {
        imageView.layer.cornerRadius = cornerRadius;
        imageView.layer.masksToBounds = YES;
    }
    
    return imageView;
}

@end
