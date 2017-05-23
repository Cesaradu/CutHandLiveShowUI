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
#import "AnimationFactory.h"

#define NSIntegerMax    LONG_MAX
#define NSIntegerMin    LONG_MIN

@interface MainTabBarController () <ADTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *chiledViewControllers;
@property (nonatomic, strong) NSMutableArray *barImageArr;
@property (nonatomic, strong) NSMutableArray *barTitleArr;
@property (nonatomic, strong) ADTabBar *adTabBar;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self createTabBar];
    [self setBarAppearance];
}

- (void)initData {
    self.adTabBar = [[ADTabBar alloc] init];
    self.chiledViewControllers = [NSMutableArray new];
    self.barImageArr = [NSMutableArray new];
    self.barTitleArr = [NSMutableArray new];
}

- (void)createTabBar {
    
    //更换系统自带的tabbar
    self.adTabBar.backgroundColor = [UIColor colorWithHexString:@"333333" alpha:1.0];
    self.adTabBar.adDelegate = self;
    //使用kvc，将自定义的tabbar替换掉系统的tabbar
    [self setValue:self.adTabBar forKey:@"tabBar"];
    
    //tabbar加阴影
    [self dropShadowWithOffset:CGSizeMake(0, -1) radius:1 color:[UIColor grayColor] opacity:0.8];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    MineViewController *mineVC = [[MineViewController alloc] init];
    
    NSMutableArray *controllerArray = [NSMutableArray arrayWithObjects:homeVC, mineVC, nil];
    
    NSMutableArray *normalImageArray = [NSMutableArray arrayWithArray:@[@"home_normal", @"mine_normal"]];
    NSMutableArray *selectedImageArray = [NSMutableArray arrayWithArray:@[@"home_select", @"mine_select"]];
    //NSMutableArray *titleArray = [NSMutableArray arrayWithArray:@[@"首页", @"我的"]];
    
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
//        navi.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
    }
    self.viewControllers = controllerArray;
    
    ADTabBarSource *dataSource = [[ADTabBarSource alloc]init];
    //dataSource.titleArr = titleArray;
    dataSource.viewControllers = controllerArray;
    dataSource.normalImageArr = normalImageArray;
    dataSource.selectImageArr = selectedImageArray;
    [self tabBarSetDataSource:dataSource];

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

/**
 给Tabbar赋值：image、title、viewController
 
 @param dataSoucre 数据源
 */
- (void)tabBarSetDataSource:(ADTabBarSource *)dataSoucre {
    for (int  i = 0; i < dataSoucre.viewControllers.count; i++) {
        NSString *title = dataSoucre.titleArr[i];
        UIImage *normalImage = [UIImage imageNamed:dataSoucre.normalImageArr[i]];
        UIImage *selectImage = [UIImage imageNamed:dataSoucre.selectImageArr[i]];
        UIViewController *viewController = dataSoucre.viewControllers[i];
        viewController.title = dataSoucre.titleArr[i];
        [self setupOnChildViewController:viewController title:title normalImage:normalImage selectImage:selectImage tag:i];
    }
    self.viewControllers = self.chiledViewControllers;
    self.adTabBar.dataSource = self.viewControllers;
    [self.adTabBar setNeedsLayout];
    for (UIControl *tabbarButton in self.adTabBar.subviews) {
        if ([tabbarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            for (UIView *barSubView in tabbarButton.subviews) {
                if ([barSubView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                    [self.barImageArr addObject:barSubView];
                }
                if ([barSubView isKindOfClass:[UILabel class]]) {
                    //不显示tabbar文字
                    //[self.barTitleArr addObject:barSubView];
                }
            }
        }
    }
}

/**
 修改TabBarItem 属性 以及给TabBarItem赋数据 添加tabbar动画效果
 
 @param chiledVC 子视图
 @param title title
 @param normalImage 默认图
 @param selectImage 选中图
 */
- (void)setupOnChildViewController:(UIViewController *)chiledVC title:(NSString *)title normalImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage tag:(NSInteger)tag {
    ADTabBarItem *barItem = [[ADTabBarItem alloc]init];
    //不显示tabbar文字
    //barItem.title = title;
    barItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    barItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    barItem.tag = tag;
    barItem.tabBarAnimation = [AnimationFactory animationWithType:JelloAnima];
    //[barItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    //[barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateSelected];
    barItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    chiledVC.tabBarItem = barItem;
    [self.chiledViewControllers addObject:chiledVC];
}

/**
 点击TabBarItem代理
 
 @param tabBar tabBar
 @param item 当前点击Item
 */
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    ADTabBarItem *nowItem = (ADTabBarItem *)item;
    if (nowItem.tag != self.adTabBar.seleItem.tag) {
        [nowItem playAnimation:[self.barImageArr objectAtIndex:nowItem.tag] textLabel:nil];
        [self.adTabBar.seleItem deselectAnimation:[self.barImageArr objectAtIndex:self.adTabBar.seleItem.tag] textLabel:nil];
        self.adTabBar.seleItem = nowItem;
    }else{
        [nowItem selectedState:[self.barImageArr objectAtIndex:nowItem.tag] textLabel:nil];
    }
}

/**
 通过self.selectIndex改变tabbar当前controller时调用
 
 @param index 想要选择某个controller
 */
- (void)changeSelectIndex:(NSInteger)index{
    self.selectedIndex = index;
    ADTabBarItem *barItem = (ADTabBarItem *)[self.adTabBar.items objectAtIndex:index];
    [self tabBar:self.adTabBar didSelectItem:barItem];
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
