//
//  MineViewController.m
//  CutHand
//
//  Created by hztuen on 2017/4/13.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "UIView+Draggable.h"
#import "EditViewController.h"

@interface MineViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView *lineView;//导航栏黑线
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *imageArray;//图片数组
@property (nonatomic, strong) NSArray *titleArray;//标题数组
@property (nonatomic, strong) UIImageView *headImage;//头像
@property (nonatomic, strong) UILabel *signatureLabel;//个性签名
@property (nonatomic, strong) UILabel *focusNum;//关注人数
@property (nonatomic, strong) UILabel *liveNum;//直播数
@property (nonatomic, strong) UILabel *fansNum;//粉丝数

@end

@implementation MineViewController

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
}

- (void)setupInit {
    self.navigationItem.title = @"Cesar du";
    self.view.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    self.imageArray = @[@"user_account", @"money_account", @"recharge", @"bill", @"authentication", @"my_level", @"level", @"setting"];
    self.titleArray = @[@"剁手号", @"我的金库", @"账户充值", @"剁手账单", @"实名认证", @"我的等级", @"主播等级", @"设置"];
}

- (void)buildUI {
    
    //获取导航栏下面黑线
    self.lineView = [self getLineViewInNavigationBar:self.navigationController.navigationBar];
    
    //搜索
    UIButton *messageBtn = [UIButton buttonWithImageName:@"message" WithFrame:CGRectMake(0, 0, 63/2, 42/2) WithTarget:self action:@selector(clickMessageBtn)];
    UIBarButtonItem *messageItem = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    self.navigationItem.leftBarButtonItem = messageItem;
    
    //排名
    UIButton *editBtn = [UIButton buttonWithImageName:@"edit" WithFrame:CGRectMake(0, 0, 60/2, 60/2) WithTarget:self action:@selector(clickEditBtn)];
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItem = editItem;
    
    //头部试图
    UIView *headView = [self buildHeadView];
    [self.view addSubview:headView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake([self Suit:10], [self Suit:200], ScreenWidth-[self Suit:20], ScreenHeight-64-49-[self Suit:210])];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"ffffff" alpha:1.0];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.layer.cornerRadius = [self Suit:5];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
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

- (UIView *)buildHeadView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake([self Suit:10], [self Suit:10], ScreenWidth-[self Suit:20], [self Suit:180])];
    headView.backgroundColor = [UIColor colorWithHexString:MainColor alpha:1.0];
    headView.layer.shadowColor = [UIColor colorWithHexString:MainColor alpha:1.0].CGColor;
    headView.layer.shadowOffset = CGSizeMake(2, 2);
    headView.layer.shadowOpacity = 0.8;
    headView.layer.shadowRadius = 5;
    
    //头像
    self.headImage = [[UIImageView alloc] init];
    self.headImage.backgroundColor = [UIColor colorWithHexString:@"fdbb2c" alpha:1.0];
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = [self Suit:45];
    self.headImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headImage.layer.borderWidth = [self Suit:5];
    self.headImage.userInteractionEnabled = YES;
    [headView addSubview:self.headImage];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.top.equalTo(headView.mas_top).offset([self Suit:8]);
        make.width.height.mas_equalTo([self Suit:90]);
    }];
    //让头像可以拖动
    [self.headImage makeDraggable];
    
    //个性签名
    self.signatureLabel = [UILabel labelWithTitle:@"个性签名个性签名个性签名" AndColor:@"ffffff" AndFont:[self SuitFont:12] AndAlignment:NSTextAlignmentCenter];
    [headView addSubview:self.signatureLabel];
    [self.signatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.top.equalTo(self.headImage.mas_bottom).offset([self SuitFont:8]);
        make.width.mas_equalTo(ScreenWidth-[self Suit:30]);
    }];
    
    //关注的人
    UILabel *focus = [UILabel labelWithTitle:@"关注的人" AndColor:@"ffffff" AndFont:[self SuitFont:12] AndAlignment:NSTextAlignmentCenter];
    [headView addSubview:focus];
    [focus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.bottom.equalTo(headView.mas_bottom).offset([self Suit:-10]);
        make.width.mas_equalTo(ScreenWidth/3-[self Suit:20]);
    }];
    
    self.focusNum = [UILabel labelWithTitle:@"807" AndColor:@"ffffff" AndFont:0 AndAlignment:NSTextAlignmentCenter];
    self.focusNum.font = [UIFont boldSystemFontOfSize:[self SuitFont:18]];
    [headView addSubview:self.focusNum];
    [self.focusNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.width.equalTo(focus.mas_width);
        make.bottom.equalTo(focus.mas_top).offset([self SuitFont:-3]);
    }];
    
    //直播数
    UILabel *live = [UILabel labelWithTitle:@"直播数" AndColor:@"ffffff" AndFont:[self SuitFont:12] AndAlignment:NSTextAlignmentCenter];
    [headView addSubview:live];
    [live mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(focus.mas_centerY);
        make.left.equalTo(headView.mas_left).offset([self Suit:10]);
        make.right.equalTo(focus.mas_left).offset([self Suit:-20]);
    }];
    
    self.liveNum = [UILabel labelWithTitle:@"807" AndColor:@"ffffff" AndFont:0 AndAlignment:NSTextAlignmentCenter];
    self.liveNum.font = [UIFont boldSystemFontOfSize:[self SuitFont:18]];
    [headView addSubview:self.liveNum];
    [self.liveNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(live.mas_centerX);
        make.width.equalTo(live.mas_width);
        make.bottom.equalTo(live.mas_top).offset([self SuitFont:-3]);
    }];
    
    //粉丝数
    UILabel *fans = [UILabel labelWithTitle:@"粉丝数" AndColor:@"ffffff" AndFont:[self SuitFont:12] AndAlignment:NSTextAlignmentCenter];
    [headView addSubview:fans];
    [fans mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(focus.mas_centerY);
        make.right.equalTo(headView.mas_right).offset([self Suit:-10]);
        make.left.equalTo(focus.mas_right).offset([self Suit:20]);
    }];
    
    self.fansNum = [UILabel labelWithTitle:@"1.3k" AndColor:@"ffffff" AndFont:0 AndAlignment:NSTextAlignmentCenter];
    self.fansNum.font = [UIFont boldSystemFontOfSize:[self SuitFont:18]];
    [headView addSubview:self.fansNum];
    [self.fansNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(fans.mas_centerX);
        make.width.equalTo(fans.mas_width);
        make.bottom.equalTo(fans.mas_top).offset([self SuitFont:-3]);
    }];
    
    return headView;
}


#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineCell"];
    if (!cell) {
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mineCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.leftImage.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.leftLabel.text = self.titleArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (ScreenHeight-64-49-[self Suit:210])/8;
}

#pragma mark - Actions

- (void)clickHeadImage {
    NSLog(@"点击头像");
}

- (void)clickMessageBtn {
    
}

- (void)clickEditBtn {
    EditViewController *editVC = [[EditViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:editVC animated:YES];
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
