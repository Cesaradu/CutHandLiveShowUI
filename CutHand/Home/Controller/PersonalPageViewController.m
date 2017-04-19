//
//  PersonalPageViewController.m
//  CutHand
//
//  Created by hztuen on 2017/4/17.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "PersonalPageViewController.h"
#import "MineTableViewCell.h"
#import "RecordTableViewCell.h"

@interface PersonalPageViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;//主scrollview
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UIButton *focusBtn;//关注按钮
@property (nonatomic, strong) UIButton *msgBtn;//私信按钮
@property (nonatomic, strong) UIButton *recordBtn;//回放按钮
@property (nonatomic, strong) UIButton *infoBtn;//个人资料按钮
@property (nonatomic, strong) UIView *tabLine;//
@property (nonatomic, strong) UIScrollView *scrollView2;//横向scrollview
@property (nonatomic, strong) UITableView *recordTableView;//回放tableview
@property (nonatomic, strong) UITableView *infoTableView;//个人资料tableview
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *naviView;//导航栏视图
@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic, strong) UIImageView *naviHeadImage;//导航栏头像


@end

@implementation PersonalPageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self buildNaviView];
}

- (void)buildNaviView {
    
    UIButton *moreBtn = [UIButton buttonWithImageName:@"more" WithFrame:CGRectMake(0, 0, 44, 44) WithTarget:self action:@selector(clickMoreBtn)];
    moreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    self.navigationItem.rightBarButtonItem = moreItem;
    
    NSString *name = @"Cesar Du";
    CGSize titleSize = [name sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(MAXFLOAT, 44)];
    
    self.naviView = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth-titleSize.width-35)/2, 0, titleSize.width+35, 44)];
    [self.navigationController.navigationBar addSubview:self.naviView];
    
    self.titleLabel = [UILabel labelWithTitle:name AndColor:@"ffffff" AndFont:18 AndAlignment:NSTextAlignmentCenter];
    [self.naviView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.naviView.mas_right);
        make.top.equalTo(self.naviView.mas_top);
        make.height.mas_equalTo(44);
    }];
    
    self.naviHeadImage = [[UIImageView alloc] init];
    self.naviHeadImage.backgroundColor = [UIColor colorWithHexString:@"fdbb2c" alpha:1.0];
    self.naviHeadImage.layer.cornerRadius = 15;
    [self.naviView addSubview:self.naviHeadImage];
    [self.naviHeadImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.naviView.mas_centerY);
        make.left.equalTo(self.naviView.mas_left);
        make.width.height.mas_equalTo(30);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.naviView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupInit];
    [self buildUI];
}

- (void)setupInit {
    self.view.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self buildNaviBarLelfBtn];
}

- (void)buildUI {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
    [self.view addSubview:self.scrollView];
    
    //topView
    UIView *topView = [self buildTopView];
    [self.scrollView addSubview:topView];
    
    //headView
    self.headView = [self buildHeadView];
    [self.scrollView addSubview:self.headView];
    
    //tabView
    UIView *tabView = [self buildTabView];
    [self.scrollView addSubview:tabView];
    
    //横向scrollview
    UIScrollView *scrollView = [self buildScrollView2];
    [self.scrollView addSubview:scrollView];
}

- (UIView *)buildTopView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [self Suit:446/4])];
    topView.backgroundColor = [UIColor colorWithHexString:MainColor alpha:1.0];
    [self.scrollView addSubview:topView];
    
    UIButton *backBtn = [UIButton buttonWithImageName:@"left_arrow" WithFrame:CGRectMake(0, 20, 64, 44) WithTarget:self action:@selector(clickBackBtn)];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [topView addSubview:backBtn];
    
    UIButton *moreBtn = [UIButton buttonWithImageName:@"more" WithFrame:CGRectMake(ScreenWidth-64, 20, 64, 44) WithTarget:self action:@selector(clickMoreBtn)];
    [moreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    [topView addSubview:moreBtn];
    
    return topView;
}

- (UIScrollView *)buildScrollView2 {
    self.scrollView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [self Suit:(140+306+20+120+20)/2], ScreenWidth, ScreenHeight-[self Suit:(20+120+20)/2]-64)];
    self.scrollView2.delegate = self;
    self.scrollView2.pagingEnabled = YES;
    self.scrollView2.showsHorizontalScrollIndicator = NO;
    self.scrollView2.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    self.scrollView2.contentSize = CGSizeMake(ScreenWidth*2, ScreenHeight-[self Suit:(140+306+20+120+20)/2]);
    
    self.recordTableView = [[UITableView alloc] initWithFrame:CGRectMake([self Suit:15], 0, ScreenWidth-[self Suit:30], ScreenHeight-[self Suit:(20+120+20)/2]-64) style:UITableViewStyleGrouped];
    self.recordTableView.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    self.recordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.recordTableView.delegate = self;
    self.recordTableView.dataSource = self;
    self.recordTableView.showsVerticalScrollIndicator = NO;
    [self.scrollView2 addSubview:self.recordTableView];
    
    self.infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth+[self Suit:15], 0, ScreenWidth-[self Suit:30], [self Suit:616/2])];
    self.infoTableView.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    self.infoTableView.showsVerticalScrollIndicator = NO;
    self.infoTableView.layer.cornerRadius = [self Suit:5];
    self.infoTableView.layer.masksToBounds = YES;
//    self.infoTableView.layer.shadowColor = [UIColor colorWithHexString:@"c2c2c2" alpha:1.0].CGColor;
//    self.infoTableView.layer.shadowOffset = CGSizeMake(2, 2);
//    self.infoTableView.layer.shadowOpacity = 0.6;
//    self.infoTableView.layer.shadowRadius = 2;
//    self.infoTableView.clipsToBounds = NO;
    self.infoTableView.scrollEnabled = NO;
    [self.scrollView2 addSubview:self.infoTableView];
    
    return self.scrollView2;
}

- (UIView *)buildHeadView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake([self Suit:15], [self Suit:70], ScreenWidth-[self Suit:30], [self Suit:306/2])];
    headView.backgroundColor = [UIColor whiteColor];
    headView.layer.cornerRadius = [self Suit:5];
    headView.layer.shadowColor = [UIColor colorWithHexString:@"c2c2c2" alpha:1.0].CGColor;
    headView.layer.shadowOffset = CGSizeMake(2, 2);
    headView.layer.shadowOpacity = 0.6;
    headView.layer.shadowRadius = 2;
    
    //头像
    self.headImage = [[UIImageView alloc] init];
    self.headImage.backgroundColor = [UIColor colorWithHexString:@"fdbb2c" alpha:1.0];
    self.headImage.layer.cornerRadius = [self Suit:75]/2;
    self.headImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.headImage.layer.borderWidth = 2;
    [headView addSubview:self.headImage];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView.mas_top);
        make.centerX.equalTo(headView.mas_centerX);
        make.width.height.mas_equalTo([self Suit:75]);
    }];
    
    UIImageView *vipImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vip"]];
    [headView addSubview:vipImage];
    [vipImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headImage.mas_bottom);
        make.right.equalTo(self.headImage.mas_right);
    }];
    
    self.focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.focusBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.focusBtn setImage:[UIImage imageNamed:@"add_success"] forState:UIControlStateSelected];
    [self.focusBtn addTarget:self action:@selector(clickFocusBtn) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.focusBtn];
    [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImage.mas_centerY);
        make.right.equalTo(self.headImage.mas_left).offset([self Suit:-40]);
    }];
    
    self.msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.msgBtn setImage:[UIImage imageNamed:@"send_message"] forState:UIControlStateNormal];
    [self.msgBtn addTarget:self action:@selector(clickSendMsgBtn) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.msgBtn];
    [self.msgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImage.mas_centerY);
        make.left.equalTo(self.headImage.mas_right).offset([self Suit:40]);
    }];
    
    self.nameLabel = [UILabel labelWithTitle:@"Cesar Du" AndColor:@"7E7B7B" AndFont:0 AndAlignment:NSTextAlignmentCenter];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:[self SuitFont:14]];
    [headView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.top.equalTo(self.headImage.mas_bottom).offset([self Suit:10]);
    }];
    
    UILabel *noteLabel = [UILabel labelWithTitle:@"此人太懒，还没有个性签名~" AndColor:@"B0B0B1" AndFont:[self SuitFont:11] AndAlignment:NSTextAlignmentCenter];
    [headView addSubview:noteLabel];
    [noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.top.equalTo(self.nameLabel.mas_bottom).offset([self Suit:10]);
    }];
    
    UILabel *focusLabel = [UILabel labelWithTitle:@"关注的人" AndColor:@"B0B0B1" AndFont:[self SuitFont:12] AndAlignment:NSTextAlignmentCenter];
    [headView addSubview:focusLabel];
    [focusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView.mas_left);
        make.right.equalTo(headView.mas_centerX);
        make.bottom.equalTo(headView.mas_bottom).offset([self Suit:-10]);
    }];
    
    UILabel *focusNum = [UILabel labelWithTitle:@"2000" AndColor:@"FFC05D" AndFont:[self SuitFont:17] AndAlignment:NSTextAlignmentCenter];
    [headView addSubview:focusNum];
    [focusNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(focusLabel.mas_centerX);
        make.bottom.equalTo(focusLabel.mas_top).offset([self Suit:-5]);
    }];
    
    UILabel *fansLabel = [UILabel labelWithTitle:@"ta的粉丝" AndColor:@"B0B0B1" AndFont:[self SuitFont:12] AndAlignment:NSTextAlignmentCenter];
    [headView addSubview:fansLabel];
    [fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView.mas_centerX);
        make.right.equalTo(headView.mas_right);
        make.bottom.equalTo(headView.mas_bottom).offset([self Suit:-10]);
    }];
    
    UILabel *fansNum = [UILabel labelWithTitle:@"2000" AndColor:@"FFC05D" AndFont:[self SuitFont:17] AndAlignment:NSTextAlignmentCenter];
    [headView addSubview:fansNum];
    [fansNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(fansLabel.mas_centerX);
        make.bottom.equalTo(fansLabel.mas_top).offset([self Suit:-5]);
    }];
    
    return headView;
}

- (UIView *)buildTabView {
    UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake([self Suit:15], [self Suit:(140+306+20)/2], ScreenWidth-[self Suit:30], [self Suit:60])];
    tabView.backgroundColor = [UIColor whiteColor];
    tabView.layer.cornerRadius = [self Suit:5];
    tabView.layer.shadowColor = [UIColor colorWithHexString:@"c2c2c2" alpha:1.0].CGColor;
    tabView.layer.shadowOffset = CGSizeMake(2, 2);
    tabView.layer.shadowOpacity = 0.6;
    tabView.layer.shadowRadius = 2;
    
    self.recordBtn = [UIButton buttonWithTitle:@"精彩回放" AndTitleColor:nil AndTitleFont:[self SuitFont:14] AndBackgroundColor:nil addTarget:self action:@selector(clickTabBtn:)];
    self.recordBtn.selected = YES;
    [self.recordBtn setTitleColor:[UIColor colorWithHexString:@"333333" alpha:1.0] forState:UIControlStateSelected];
    [self.recordBtn setTitleColor:[UIColor colorWithHexString:@"999999" alpha:1.0] forState:UIControlStateNormal];
    self.recordBtn.frame = CGRectMake(0, 0, tabView.frame.size.width/2, [self Suit:60]);
    self.recordBtn.tag = 100001;
    [tabView addSubview:self.recordBtn];
    
    self.infoBtn = [UIButton buttonWithTitle:@"个人资料" AndTitleColor:nil AndTitleFont:[self SuitFont:14] AndBackgroundColor:nil addTarget:self action:@selector(clickTabBtn:)];
    self.infoBtn.selected = NO;
    [self.infoBtn setTitleColor:[UIColor colorWithHexString:@"333333" alpha:1.0] forState:UIControlStateSelected];
    [self.infoBtn setTitleColor:[UIColor colorWithHexString:@"999999" alpha:1.0] forState:UIControlStateNormal];
    self.infoBtn.frame = CGRectMake(tabView.frame.size.width/2, 0, tabView.frame.size.width/2, [self Suit:60]);
    self.infoBtn.tag = 100002;
    [tabView addSubview:self.infoBtn];
    
    self.tabLine = [[UIView alloc] initWithFrame:CGRectMake(tabView.frame.size.width/4-[self Suit:15], [self Suit:58], [self Suit:30], [self Suit:2])];
    self.tabLine.backgroundColor = [UIColor colorWithHexString:@"FFC05D" alpha:1.0];
    [tabView addSubview:self.tabLine];
    
    return tabView;
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.recordTableView) {
        return 0;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.recordTableView) {
        return 1;
    }
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.recordTableView) {
        return [self Suit:858/2];
    }
    return [self Suit:616/2/7];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.infoTableView) {
        MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell"];
        if (!cell) {
            cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"infoCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSArray *imageArray = @[@"user_account", @"follows", @"fans", @"productCount", @"gift", @"age", @"area", @"setting"];
        NSArray *titleArray = @[@"剁手号", @"关注的人", @"ta的粉丝", @"商品销量", @"收礼", @"年龄", @"地区"];
        cell.leftImage.image = [UIImage imageNamed:imageArray[indexPath.row]];
        cell.leftLabel.text = titleArray[indexPath.row];
        
        
        return cell;
    }
    
    RecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recordCell"];
    if (!cell) {
        cell = [[RecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"recordCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView == self.recordTableView) {
        return [self Suit:10];
    }
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000001;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.recordTableView) {
        CGFloat scrollViewOffsetY = scrollView.contentOffset.y;
        if (scrollViewOffsetY > 0)
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.headView.alpha = 0.0f;
                [self.scrollView setContentOffset:CGPointMake(0, [self Suit:306/2+70])];
            } completion:^(BOOL finished) {
                [self.navigationController setNavigationBarHidden:NO animated:YES];
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.headView.alpha = 1.0f;
                [self.scrollView setContentOffset:CGPointMake(0, 0)];
            } completion:^(BOOL finished) {
                [self.navigationController setNavigationBarHidden:YES animated:YES];
            }];
        }
    }
    
    if (scrollView == self.scrollView2) {
        CGFloat xOffset = scrollView.contentOffset.x;
        if (xOffset < ScreenWidth/2 && xOffset >= 0) {
            [UIView animateWithDuration:0.3 animations:^{
                self.tabLine.frame = CGRectMake(ScreenWidth/4-[self Suit:22.5], [self Suit:58], [self Suit:30], [self Suit:2]);
                self.recordBtn.selected = YES;
                self.infoBtn.selected = NO;
            }];
        }
        if (xOffset > ScreenWidth/2 && xOffset <= ScreenWidth) {
            
            [UIView animateWithDuration:0.3 animations:^{
                self.tabLine.frame = CGRectMake(ScreenWidth*3/4-[self Suit:37.5], [self Suit:58], [self Suit:30], [self Suit:2]);
                self.recordBtn.selected = NO;
                self.infoBtn.selected = YES;
            }];
        }
    }
}

#pragma mark - Actions

- (void)clickTabBtn:(UIButton *)button {
    switch (button.tag-100000) {
        case 1:
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self.scrollView2 setContentOffset:CGPointMake(0, 0)];
            }];
        }
            break;
            
        case 2:
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self.scrollView2 setContentOffset:CGPointMake(ScreenWidth, 0)];
            }];
        }
            break;
        
    }
}

- (void)clickFocusBtn {
    self.focusBtn.selected = !self.focusBtn.selected;
}

- (void)clickSendMsgBtn {
    
}

- (void)clickBackBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickMoreBtn {
    
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
