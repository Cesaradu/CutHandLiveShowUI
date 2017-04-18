//
//  HomeViewController.m
//  CutHand
//
//  Created by hztuen on 2017/4/13.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "HomeViewController.h"
#import "ADScrollContentView.h"
#import "ADScrollTitleView.h"
#import "HomeTableViewController.h"
#import "SearchViewController.h"
#import "RankingListViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) ADScrollTitleView *titleView;
@property (nonatomic, strong) ADScrollContentView *contentView;
@property (nonatomic, strong) UIImageView *lineView;//导航栏黑线

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.lineView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.lineView.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInit];
    [self buildUI];
    [self loadData];
}

- (void)setupInit {
    self.navigationItem.title = @"剁手直播";
}

- (void)buildUI {
    
    //获取导航栏下面黑线
    self.lineView = [self getLineViewInNavigationBar:self.navigationController.navigationBar];
    
    //搜索
    UIButton *searchBtn = [UIButton buttonWithImageName:@"search" WithFrame:CGRectMake(0, 0, 63/2, 65/2) WithTarget:self action:@selector(clickSearchBtn)];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.leftBarButtonItem = searchItem;
    
    //排名
    UIButton *topBtn = [UIButton buttonWithImageName:@"top" WithFrame:CGRectMake(0, 0, 62/2, 60/2) WithTarget:self action:@selector(clickTopBtn)];
    UIBarButtonItem *topItem = [[UIBarButtonItem alloc] initWithCustomView:topBtn];
    self.navigationItem.rightBarButtonItem = topItem;
    
    //标题视图
    self.titleView = [[ADScrollTitleView alloc] initWithFrame:CGRectZero];
    self.titleView.backgroundColor = [UIColor colorWithHexString:@"ffffff" alpha:1.0];
    self.titleView.titleWidth = ScreenWidth/5;
    self.titleView.titleFont = [UIFont systemFontOfSize:[self SuitFont:14]];
    __weak typeof(self) weakSelf = self;
    self.titleView.selectedBlock = ^(NSInteger index){
        weakSelf.contentView.currentIndex = index;
    };
    [self.view addSubview:self.titleView];
    
    //内容视图
    self.contentView = [[ADScrollContentView alloc] initWithFrame:CGRectZero];
    self.contentView.scrollBlock = ^(NSInteger index){
        weakSelf.titleView.selectedIndex = index;
    };
    [self.view addSubview:self.contentView];
}

//找到导航栏最下面黑线视图
- (UIImageView *)getLineViewInNavigationBar:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self getLineViewInNavigationBar:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.titleView.frame = CGRectMake(0, 0, ScreenWidth, [self Suit:44]);
    self.contentView.frame = CGRectMake(0, [self Suit:44], ScreenWidth, ScreenHeight - [self Suit:44]);
}

- (void)loadData {
    //标题数据
    NSArray *titles = @[@"精选",@"母婴",@"潮流配",@"全球购",@"美妆",@"美食",@"娱乐",@"时尚",@"房地产",@"经济"];
    [self.titleView reloadViewWithTitles:titles];
    
    //内容数据
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    for (NSString *title in titles) {
        HomeTableViewController *vc = [[HomeTableViewController alloc] init];
        vc.category = title;
        [vcs addObject:vc];
    }
    [self.contentView reloadViewWithChildVcs:vcs parentVC:self];
}

#pragma mark - Actions

- (void)clickSearchBtn {
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)clickTopBtn {
    RankingListViewController *rankVC = [[RankingListViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rankVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
