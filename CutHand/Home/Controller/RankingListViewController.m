//
//  RankingListViewController.m
//  CutHand
//
//  Created by hztuen on 2017/4/14.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "RankingListViewController.h"
#import "RankTableViewCell.h"
#import "AnimationButton.h"
#import "PersonalPageViewController.h"

@interface RankingListViewController () <UITableViewDelegate, UITableViewDataSource, AnimationButtonDelegate>
@property (nonatomic, strong) UIView *naviView;
@property (nonatomic, strong) UIImageView *lineView;//导航栏黑线
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *dayBtn;//每日按钮
@property (nonatomic, strong) UIButton *weekBtn;//每周按钮
@property (nonatomic, strong) UIView *bottomLine;//每日每周底部线
@property (nonatomic, strong) UIImageView *headImage;//头像
@property (nonatomic, strong) UILabel *nameLabel;//名字
@property (nonatomic, strong) UILabel *receiveNum;//收到数量
@property (nonatomic, strong) UIButton *focusBtn;//关注按钮
@property (nonatomic, strong) NSMutableArray *topBtnArray;

@end

@implementation RankingListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.lineView.hidden = YES;
    [self buildNaviBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.lineView.hidden = NO;
    [self.naviView removeFromSuperview];
}

- (void)buildNaviBar {
    self.naviView = [[UIView alloc] initWithFrame:CGRectMake([self Suit:40], 0, ScreenWidth-[self Suit:80], 44)];
    [self.navigationController.navigationBar addSubview:self.naviView];
    
    NSArray *array = @[@"收礼榜", @"送礼榜", @"热门趋势"];
    float btnWidth = self.naviView.frame.size.width/3;
    for (int i = 0; i < 3; i ++) {
        UIButton *button = [UIButton buttonWithTitle:array[i] AndTitleColor:nil AndTitleFont:18 AndBackgroundColor:nil addTarget:self action:@selector(clickTopBtn:)];
        button.tag = 1000+i;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        button.frame = CGRectMake(btnWidth*i, 0, btnWidth, 44);
        if (i == 0) {
            button.selected = YES;
        }
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor colorWithHexString:@"c2c2c2" alpha:1.0] forState:UIControlStateNormal];
        [self.naviView addSubview:button];
        [self.topBtnArray addObject:button];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInit];
    [self buildUI];
}

- (void)setupInit {
    [self buildNaviBarLelfBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    self.topBtnArray = [NSMutableArray array];
}

- (void)buildUI {
    
    //获取导航栏下面黑线
    self.lineView = [self getLineViewInNavigationBar:self.navigationController.navigationBar];
    
    UIView *tabView = [self buildTabView];
    [self.view addSubview:tabView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [self Suit:40], ScreenWidth, ScreenHeight-64-[self Suit:40])];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [self buildTableHeadView];
    [self.view addSubview:self.tableView];
    
}

- (UIView *)buildTableHeadView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [self Suit:310])];
    headView.backgroundColor = [UIColor colorWithHexString:MainColor alpha:1.0];
    
    UIImageView *bgImg1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fireworks_bg"]];
    [headView addSubview:bgImg1];
    [bgImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.top.equalTo(headView.mas_top).offset([self Suit:5]);
    }];
    
    UIImageView *bgImg2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fireworks"]];
    [headView addSubview:bgImg2];
    [bgImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.top.equalTo(headView.mas_top).offset([self Suit:5]);
    }];
    
    self.headImage = [[UIImageView alloc] init];
    self.headImage.backgroundColor = [UIColor whiteColor];
    self.headImage.layer.cornerRadius = [self Suit:60];
    self.headImage.layer.borderColor = [UIColor colorWithHexString:@"FCC03C" alpha:1.0].CGColor;
    self.headImage.layer.borderWidth = [self Suit:2];
    self.headImage.userInteractionEnabled = YES;
    [headView addSubview:self.headImage];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.top.equalTo(headView.mas_top).offset([self Suit:75]);
        make.width.height.mas_equalTo([self Suit:120]);
    }];
    
    UIImageView *crownImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"crown"]];
    [headView addSubview:crownImage];
    [crownImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.bottom.equalTo(self.headImage.mas_top).offset([self Suit:5]);
    }];
    
    UIImageView *numberOneImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"numberOne"]];
    [headView addSubview:numberOneImg];
    [numberOneImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImage.mas_centerY);
        make.left.equalTo(headView.mas_left).offset([self Suit:15]);
    }];
    
    UIImageView *vipImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vip"]];
    [headView addSubview:vipImg];
    [vipImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headImage.mas_bottom);
        make.right.equalTo(self.headImage.mas_right).offset([self Suit:-10]);
    }];
    
    self.nameLabel = [UILabel labelWithTitle:@"Cesar Du" AndColor:@"ffffff" AndFont:0 AndAlignment:NSTextAlignmentCenter];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:[self SuitFont:18]];
    [headView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.top.equalTo(self.headImage.mas_bottom).offset([self Suit:10]);
    }];
    
    self.receiveNum = [UILabel labelWithTitle:@"收到xxxxxx" AndColor:@"c2c2c2" AndFont:[self SuitFont:13] AndAlignment:NSTextAlignmentCenter];
    [headView addSubview:self.receiveNum];
    [self.receiveNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.top.equalTo(self.nameLabel.mas_bottom).offset([self Suit:5]);
    }];
    
//    self.focusBtn = [AnimationButton buttonWithFrame:CGRectMake(ScreenWidth/2-[self Suit:35], [self Suit:260], [self Suit:70], [self Suit:30])];
//    self.focusBtn.delegate = self;
//    [self.focusBtn setborderColor:[UIColor whiteColor]];
//    [self.focusBtn setborderWidth:1.0];
//    [self.focusBtn setTitle:@"+" forState:UIControlStateNormal];
//    [self.focusBtn setTitleColor:[UIColor colorWithHexString:@"ffffff" alpha:1.0] forState:UIControlStateNormal];
//    self.focusBtn.backgroundColor = [UIColor clearColor];
    self.focusBtn = [[UIButton alloc] init];
    self.focusBtn.selected = YES;
    [self.focusBtn setImage:[UIImage imageNamed:@"unfollow"] forState:UIControlStateNormal];
    [self.focusBtn addTarget:self action:@selector(clickFocusBtn) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.focusBtn];
    [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.top.equalTo(self.receiveNum.mas_bottom).offset([self Suit:10]);
    }];
    
    return headView;
}

- (UIView *)buildTabView {
    UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [self Suit:40])];
    tabView.backgroundColor = [UIColor colorWithHexString:MainColor alpha:1.0];
    
    self.dayBtn = [UIButton buttonWithTitle:@"每日" AndTitleColor:nil AndTitleFont:0 AndBackgroundColor:nil addTarget:self action:@selector(clickTabBtn:)];
    self.dayBtn.titleLabel.font = [UIFont boldSystemFontOfSize:[self SuitFont:15]];
    self.dayBtn.selected = YES;
    [self.dayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.dayBtn setTitleColor:[UIColor colorWithHexString:@"c2c2c2" alpha:1.0] forState:UIControlStateNormal];
    self.dayBtn.tag = 100001;
    [tabView addSubview:self.dayBtn];
    [self.dayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tabView.mas_centerY);
        make.left.equalTo(tabView.mas_left);
        make.right.equalTo(tabView.mas_centerX);
        make.height.mas_equalTo([self Suit:40]);
    }];
    
    self.weekBtn = [UIButton buttonWithTitle:@"每周" AndTitleColor:nil AndTitleFont:0 AndBackgroundColor:nil addTarget:self action:@selector(clickTabBtn:)];
    self.weekBtn.titleLabel.font = [UIFont boldSystemFontOfSize:[self SuitFont:15]];
    self.weekBtn.selected = NO;
    [self.weekBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.weekBtn setTitleColor:[UIColor colorWithHexString:@"c2c2c2" alpha:1.0] forState:UIControlStateNormal];
    self.weekBtn.tag = 100002;
    [tabView addSubview:self.weekBtn];
    [self.weekBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tabView.mas_centerY);
        make.left.equalTo(tabView.mas_centerX);
        make.right.equalTo(tabView.mas_right);
        make.height.mas_equalTo([self Suit:40]);
    }];
    
    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/4-[self Suit:15], [self Suit:32], [self Suit:30], [self Suit:2])];
    self.bottomLine.backgroundColor = [UIColor whiteColor];
    [tabView addSubview:self.bottomLine];
    
    return tabView;
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rankCell"];
    if (!cell) {
        cell = [[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rankCell"];
    }
    
    if (indexPath.row == 0) {
        cell.numImage.hidden = NO;
        cell.numImage.image = [UIImage imageNamed:@"numberTwo"];
        cell.numLabel.hidden = YES;
    } else if (indexPath.row == 1) {
        cell.numImage.hidden = NO;
        cell.numImage.image = [UIImage imageNamed:@"numberThree"];
        cell.numLabel.hidden = YES;
    } else {
        cell.numImage.hidden = YES;
        cell.numLabel.hidden = NO;
        cell.numLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row+2];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PersonalPageViewController *personalVC = [[PersonalPageViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personalVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self Suit:75];
}

#pragma mark - Actions

- (void)clickTabBtn:(UIButton *)button {
    switch (button.tag - 100000) {
        case 1:
        {
            [UIView animateWithDuration:0.2 animations:^{
                self.bottomLine.frame = CGRectMake(ScreenWidth/4-[self Suit:15], [self Suit:32], [self Suit:30], [self Suit:2]);
            } completion:^(BOOL finished) {
                self.dayBtn.selected = YES;
                self.weekBtn.selected = NO;
            }];
        }
            break;
            
        case 2:
        {
            [UIView animateWithDuration:0.2 animations:^{
                self.bottomLine.frame = CGRectMake(ScreenWidth*3/4-[self Suit:15], [self Suit:32], [self Suit:30], [self Suit:2]);
            } completion:^(BOOL finished) {
                self.dayBtn.selected = NO;
                self.weekBtn.selected = YES;
            }];
        }
            break;
    }
}

- (void)clickTopBtn:(UIButton *)button {
    
    for (int i = 0; i < 3; i++) {
        if (i == button.tag-1000) {
            UIButton *selectBtn = self.topBtnArray[i];
            selectBtn.selected = YES;
        } else {
            UIButton *selectBtn = self.topBtnArray[i];
            selectBtn.selected = NO;
        }
    }
    
    switch (button.tag-1000) {
        case 0:
        {
            NSLog(@"收礼榜");
        }
            break;
            
        case 1:
        {
            NSLog(@"送礼榜");
        }
            break;
            
        case 2:
        {
            NSLog(@"热门趋势");
        }
            break;
    }
}

- (void)clickFocusBtn {
    //[self.focusBtn startAnimation];
    self.focusBtn.selected = !self.focusBtn.selected;
    [self.focusBtn setImage:[UIImage imageNamed:self.focusBtn.selected ? @"unfollow" : @"followed"] forState:UIControlStateNormal];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float offsetY = scrollView.contentOffset.y;
    if (scrollView == self.tableView) {
        if (offsetY <= 0) {
            self.tableView.alwaysBounceVertical = NO;
        }
    }
}

//#pragma mark - AnimationBtnDelegate
//
//-(void)AnimationButtonDidStartAnimation:(AnimationButton *)AnimationButton{
//    NSLog(@"start");
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [AnimationButton stopAnimation];
//    });
//}
//
//-(void)AnimationButtonDidFinishAnimation:(AnimationButton *)AnimationButton{
//    NSLog(@"stop");
//}
//
//-(void)AnimationButtonWillFinishAnimation:(AnimationButton *)AnimationButton {
//    [self.focusBtn setTitle:@"√" forState:UIControlStateNormal];
//}

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
