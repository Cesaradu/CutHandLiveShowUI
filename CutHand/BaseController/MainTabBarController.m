//
//  MainTabBarController.m
//  CutHand
//
//  Created by hztuen on 2017/4/13.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
#import "LiveViewController.h"
#import "ADTabBar.h"

#define NSIntegerMax    LONG_MAX
#define NSIntegerMin    LONG_MIN

@interface MainTabBarController () <ADTabBarDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTabBar];
    [self setBarAppearance];
}

- (void)createTabBar {
    
    //更换系统自带的tabbar
    ADTabBar *tabBar = [[ADTabBar alloc]init];
    tabBar.backgroundColor = [UIColor colorWithHexString:@"333333" alpha:1.0];
    tabBar.adDelegate = self;
    //使用kvc，将自定义的tabbar替换掉系统的tabbar
    [self setValue:tabBar forKey:@"tabBar"];
    
    //tabbar加阴影
    [self dropShadowWithOffset:CGSizeMake(0, -1) radius:1 color:[UIColor grayColor] opacity:0.8];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    MineViewController *mineVC = [[MineViewController alloc] init];
    
    NSMutableArray *controllerArray = [NSMutableArray arrayWithObjects:homeVC, mineVC, nil];
    
    NSArray *normalImageArray = @[@"home_normal", @"mine_normal"];
    NSArray *selectedImageArray = @[@"home_select", @"mine_select"];
    
    for (int  i = 0; i < controllerArray.count; i++)
    {
        // 分别找到每个视图控制器
        UIViewController *vc        = controllerArray[i];
        // 转化成导航控制器
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
        // 将数组array中的视图控制器替换成导航控制器
        [controllerArray replaceObjectAtIndex:i withObject:navi];
        
        // 渲染模式
        UIImage *normalImage = [UIImage imageNamed:normalImageArray[i]];
        UIImage *selectImage = [UIImage imageNamed:selectedImageArray[i]];
        
        navi.tabBarItem.image         = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        navi.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //tabbar文字字体颜色
        [navi.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
        [navi.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"C2C2C2" alpha:1.0]} forState:UIControlStateNormal];
        
        //图片水平居中
        navi.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
    }
    self.viewControllers = controllerArray;

}

//tabbar加阴影
- (void)dropShadowWithOffset:(CGSize)offset radius:(CGFloat)radius color:(UIColor *)color opacity:(CGFloat)opacity
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.tabBar.layer.shadowColor = color.CGColor;
    self.tabBar.layer.shadowOffset = offset;
    self.tabBar.layer.shadowRadius = radius;
    self.tabBar.layer.shadowOpacity = opacity;
    
    self.tabBar.clipsToBounds = NO;
}

-(void)setBarAppearance {
    
    //tabbar背景色
    [self.tabBar setBarTintColor:[UIColor colorWithHexString:@"333333" alpha:1.0]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 设置导航条内容颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:MainColor alpha:1.0]];

    //导航栏返回文字不显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    // UINavigationBar 设置字体
    [[UINavigationBar appearance] setTitleTextAttributes:
     @{ NSForegroundColorAttributeName: [UIColor colorWithHexString:@"ffffff" alpha:1.0], NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UITabBar appearance] setTranslucent:NO];
    
}

#pragma mark - ADTabBarDelegate
- (void)tabBarDidClickCenterButton:(ADTabBar *)tabBar
{
    NSLog(@"点击直播");
//    LiveViewController *liveVC = [[LiveViewController alloc] init];
//    [self presentViewController:liveVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
