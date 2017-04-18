//
//  WToast.m
//  MediaQRCode
//
//  Created by xiayp on 12-8-30.
//
//

#import "WToast.h"
#import <QuartzCore/QuartzCore.h>

#define TABBAR_OFFSET 44.0f

@interface WToast()

@property (nonatomic) NSInteger length;

@end


@implementation WToast

@synthesize length = _length;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame]) != nil) {
        _length = kWTShort;
    }
    return self;
}

- (void)__show {
    [UIView animateWithDuration:0.2f
                     animations:^{
                         self.alpha = 1.0f;
                     }
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(__hide) withObject:nil afterDelay:_length];
                     }];
}

- (void)__hide {
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
#if !__has_feature(objc_arc)
                         [self release];
#endif
                         
                     }];
}

+ (WToast *)__createWithText:(NSString *)text
{
    float screenWidth;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    switch (orientation) {
            case UIInterfaceOrientationPortraitUpsideDown: {
                screenWidth = MIN(screenSize.width, screenSize.height);
                break;
            }
            case UIInterfaceOrientationLandscapeLeft: {
                screenWidth = MAX(screenSize.width, screenSize.height);
                break;
            }
            case UIInterfaceOrientationLandscapeRight: {
                screenWidth = MAX(screenSize.width, screenSize.height);
                break;
            }
        default: {
            screenWidth = MIN(screenSize.width, screenSize.height);
            break;
        }
    }
    
    float x = 10.0f;
    float width = screenWidth - x * 2.0f;
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:13];
    textLabel.textColor = [UIColor colorWithHexString:@"ffffff" alpha:1];
    textLabel.numberOfLines = 0;
    
    NSString *text2 = text.length?text:@"";
    
    textLabel.text=text2;
    textLabel.adjustsFontSizeToFitWidth = YES;
    //textLabel.lineBreakMode = UILineBreakModeWordWrap;
    textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSAttributedString *attribueStr = [[NSAttributedString alloc]initWithString:text2 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    
     CGSize sz = [attribueStr boundingRectWithSize:(CGSize){screenWidth, 20}options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    textLabel.attributedText = attribueStr;

     CGRect tmpRect = CGRectZero;
    tmpRect.size.width = MIN(sz.width, width) + ((IS_IPHONE4INCH||IS_IPHONE35INCH)?(30.0/Suit4Inch):((IS_IPHONE55INCH)?(30.0*Suit55Inch):30.0));
    tmpRect.size.height = MAX(sz.height + ((IS_IPHONE4INCH||IS_IPHONE35INCH)?(38.0/Suit4Inch):((IS_IPHONE55INCH)?(38.0*Suit55Inch):38.0)), ((IS_IPHONE4INCH||IS_IPHONE35INCH)?(51.5/Suit4Inch):((IS_IPHONE55INCH)?(51.5*Suit55Inch):51.5)));
    WToast *toast = [[WToast alloc] initWithFrame:tmpRect];
    
    toast.backgroundColor = [UIColor clearColor];
    //修改提示信息的地方-------------------
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    imageV.layer.borderColor = [UIColor clearColor].CGColor;
    imageV.layer.cornerRadius = (IS_IPHONE4INCH||IS_IPHONE35INCH)?(4/Suit4Inch):((IS_IPHONE55INCH)?(4*Suit55Inch):4);
    imageV.backgroundColor = RGBA(0, 0, 0, 0.4);
    imageV.frame =toast.bounds;
    
    [toast addSubview:imageV];
    
 //   textLabel.text = text;
    
    tmpRect.origin.x = floor((toast.frame.size.width - sz.width) / 2.0f);
    tmpRect.origin.y = floor((toast.frame.size.height - sz.height) / 2.0f);
    tmpRect.size = sz;
    textLabel.frame = tmpRect;

    [imageV addSubview:textLabel];
#if !__has_feature(objc_arc)
    [textLabel release];
#endif
    
    toast.alpha = 0.0f;
    
    return toast;
}

/**
 适配 给定4.7寸屏尺寸，适配4和5.5寸屏尺寸
 */
- (float)Suit:(float)MySuit
{
    (IS_IPHONE4INCH||IS_IPHONE35INCH)?(MySuit=MySuit/Suit4Inch):((IS_IPHONE55INCH)?(MySuit=MySuit*Suit55Inch):MySuit);
    return MySuit;
}


- (void)__flipViewAccordingToStatusBarOrientation {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat angle = 0.0;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    float x, y;
    float screenWidth, screenHeight;
    
    switch (orientation) {
            case UIInterfaceOrientationPortraitUpsideDown: {
                angle = M_PI;
                screenWidth = MIN(screenSize.width, screenSize.height);
                x = floor((screenWidth - self.bounds.size.width) / 2.0f);
                y = 10.0f + TABBAR_OFFSET;
                break;
            }
            case UIInterfaceOrientationLandscapeLeft: {
                angle = - M_PI / 2.0f;
                screenWidth = MAX(screenSize.width, screenSize.height);
                screenHeight = MIN(screenSize.width, screenSize.height);
                x = screenHeight - self.bounds.size.height - 10.0f - TABBAR_OFFSET;
                y = floor((screenWidth - self.bounds.size.width) / 2.0f);
                break;
            }
            case UIInterfaceOrientationLandscapeRight: {
                angle = M_PI / 2.0f;
                screenWidth = MAX(screenSize.width, screenSize.height);
                //			screenHeight = MIN(screenSize.width, screenSize.height);
                //			x = 15.0f + TABBAR_OFFSET;
                x = 10.0f + TABBAR_OFFSET;
                y = floor((screenWidth - self.bounds.size.width) / 2.0f);
                break;
            }
        default: {
            angle = 0.0;
            screenWidth = MIN(screenSize.width, screenSize.height);
            screenHeight = MAX(screenSize.width, screenSize.height);
            x = floor((screenWidth - self.bounds.size.width) / 2.0f);
            y = floor((screenHeight - self.bounds.size.height) / 2.0f);
            //			y = screenHeight - self.bounds.size.height - 15.0f - TABBAR_OFFSET;
//            y = screenHeight - self.bounds.size.height - 10.0f - TABBAR_OFFSET;
            break;
        }
    }
    
    self.transform = CGAffineTransformMakeRotation(angle);
    
    CGRect f = self.frame;
    f.origin = CGPointMake(x, y);
    self.frame = f;
}

/**
 * Show toast with text in application window
 * @param text Text to print in toast window
 */
+ (void)showWithText:(NSString *)text
{
    [WToast showWithText:text length:kWTShort];
}

/**
 * Show toast with image in application window
 * @param image Image to show in toast window
 */

/**
 * Show toast with text in application window
 * @param text Text to print in toast window
 * @param length Toast visibility duration
 */
+ (void)showWithText:(NSString *)text length:(WToastLength)length
{
    WToast *toast = [WToast __createWithText:text];
    
    toast.length = length;
    
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    [mainWindow addSubview:toast];
    
    [toast __flipViewAccordingToStatusBarOrientation];
    [toast __show];
}

/**
 * Show toast with image in application window
 * @param image Image to show in toast window
 * @param length Toast visibility duration
 */

@end
