//
//  SearchViewController.m
//  CutHand
//
//  Created by hztuen on 2017/4/14.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "SearchViewController.h"
#import "RecommandCollectionViewCell.h"
#import "CategoryTableViewCell.h"

@interface SearchViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UITextField *searchBar;//搜索栏
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;//为您推荐collectionView
@property (nonatomic,strong) UIPageControl *pageControl;//
@property (nonatomic, strong) NSArray *cateArray;//分类标题数组
@property (nonatomic, strong) NSArray *colorArray;//左侧颜色数组

@end

@implementation SearchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES];
    
    //搜索栏
    [self buildSearchView];
    //开始搜索栏动画
    [self startSearchBarAnimation];
    
}

- (void)startSearchBarAnimation {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.searchBar.frame = CGRectMake([self Suit:15], 8, ScreenWidth-[self Suit:80], 28);
    } completion:^(BOOL finished) {
        self.searchBar.placeholder = @"输入用户名或剁手号";
    }];
}

//搜索栏
- (void)buildSearchView {
    self.searchBar = [[UITextField alloc] initWithFrame:CGRectMake([self Suit:15], 8, 28, 28)];
    self.searchBar.delegate = self;
    self.searchBar.layer.cornerRadius = 14;
    self.searchBar.layer.masksToBounds = YES;
    self.searchBar.tintColor = [UIColor colorWithHexString:@"999999" alpha:1.0];
    self.searchBar.backgroundColor = [UIColor whiteColor];
    self.searchBar.font = [UIFont systemFontOfSize:[self SuitFont:14]];
    UIImageView *searchImage=[[UIImageView alloc]initWithFrame:CGRectMake(-20, 3, 28, 18)];
    searchImage.contentMode = UIViewContentModeScaleAspectFit;
    searchImage.image = [UIImage imageNamed:@"search_gray"];
    self.searchBar.leftView = searchImage;
    self.searchBar.leftViewMode = UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    self.searchBar.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.navigationController.navigationBar addSubview:self.searchBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.searchBar removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInit];
    [self buildUI];
}

- (void)setupInit {
    self.view.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    self.cateArray = @[@"母婴", @"潮流配", @"全球购", @"美妆", @"美食", @"娱乐"];
    self.colorArray = @[@"775FFA", @"27b899", @"fdbb2c", @"94aaf1", @"93cdfa", @"008080"];
}

- (void)buildUI {
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithTitle:@"取消" AndTitleColor:@"ffffff" AndTitleFont:[self SuitFont:16] AndBackgroundColor:nil addTarget:self action:@selector(clickCancelBtn)];
    cancelBtn.frame = CGRectMake(0, 0, 40, 44);
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    self.navigationItem.rightBarButtonItem = cancelItem;
    
    //tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = [self buildTableHeadView];
    [self.view addSubview:self.tableView];
    
    
    
    
}

- (UIView *)buildTableHeadView {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [self Suit:188])];
    bgView.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(-0.5, [self Suit:5], ScreenWidth+1, [self Suit:178])];
    headView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:headView];
    headView.layer.borderWidth = 0.5;
    headView.layer.borderColor = [UIColor colorWithHexString:@"999999" alpha:0.3].CGColor;
    
    UILabel *recommand = [UILabel labelWithTitle:@"为您推荐" AndColor:@"999999" AndFont:[self SuitFont:14] AndAlignment:NSTextAlignmentCenter];
    [headView addSubview:recommand];
    [recommand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.top.equalTo(headView.mas_top);
        make.left.equalTo(headView.mas_left);
        make.height.mas_equalTo([self Suit:35]);
    }];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake([self Suit:115], [self Suit:115])];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, (ScreenWidth-[self Suit:115]*3)/4, 0, (ScreenWidth-[self Suit:115]*3)/4);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.minimumLineSpacing = (ScreenWidth-[self Suit:115]*3)/4;
    flowLayout.minimumInteritemSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, [self Suit:35], ScreenWidth, [self Suit:115]) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[RecommandCollectionViewCell class] forCellWithReuseIdentifier:@"recommandCell"];
    [headView addSubview:self.collectionView];
    
    [headView addSubview:[self setUpPageControl]];
    
    return bgView;
}

- (UIPageControl *)setUpPageControl {
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, [self Suit:150], ScreenWidth, [self Suit:28])];
    self.pageControl.numberOfPages = 3;
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"c0c0c0" alpha:0.6];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:MainColor alpha:1.0];
    self.pageControl.userInteractionEnabled = NO;
    return self.pageControl;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = self.collectionView.contentOffset;
    //计算偏移量是滚动视图宽度的整数倍
    //为了在超过一半时，就自动是下一个圆点
    self.pageControl.currentPage = round(point.x/scrollView.frame.size.width);
    
    if (scrollView == self.tableView) {
        [self.searchBar resignFirstResponder];
    }
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCategoryCell"];
    if (!cell) {
        cell = [[CategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchCategoryCell"];
    }
    
    //[cell loadData:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self Suit:115];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.cateArray.count-1) {
        return 20;
    }
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [self Suit:40+35];
    }
    return [self Suit:40];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == self.cateArray.count-1) {
        UIView *footView = [[UIView alloc] init];
        footView.backgroundColor = [UIColor whiteColor];
        return footView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor whiteColor];
    
    if (section == 0) {
        UILabel *category = [UILabel labelWithTitle:@"分类" AndColor:@"999999" AndFont:[self SuitFont:14] AndAlignment:NSTextAlignmentCenter];
        [headView addSubview:category];
        [category mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headView.mas_centerX);
            make.top.equalTo(headView.mas_top);
            make.left.equalTo(headView.mas_left);
            make.height.mas_equalTo([self Suit:35]);
        }];
    }
    
    UIButton *bgBtn = [[UIButton alloc] init];
    bgBtn.tag = 1000+section;
    [bgBtn addTarget:self action:@selector(clickCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
    bgBtn.backgroundColor = [UIColor whiteColor];
    [headView addSubview:bgBtn];
    [bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.bottom.equalTo(headView.mas_bottom);
        make.left.equalTo(headView.mas_left);
        make.height.mas_equalTo([self Suit:40]);
    }];
    
    UIView *colorView = [[UIView alloc] init];
    colorView.layer.cornerRadius = [self Suit:1.5];
    colorView.layer.masksToBounds = YES;
    colorView.backgroundColor = [UIColor colorWithHexString:self.colorArray[section] alpha:1.0];
    [bgBtn addSubview:colorView];
    [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgBtn.mas_centerY);
        make.left.equalTo(bgBtn.mas_left).offset([self Suit:10]);
        make.width.mas_equalTo([self Suit:3]);
        make.height.mas_equalTo([self Suit:20]);
    }];
    
    UILabel *cateLabel = [UILabel labelWithTitle:self.cateArray[section] AndColor:@"7e7b7b" AndFont:0 AndAlignment:NSTextAlignmentCenter];
    cateLabel.font = [UIFont boldSystemFontOfSize:[self SuitFont:15]];
    [bgBtn addSubview:cateLabel];
    [cateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgBtn.mas_centerY);
        make.left.equalTo(colorView.mas_right).offset([self Suit:10]);
    }];
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow"]];
    arrow.contentMode = UIViewContentModeScaleAspectFit;
    [bgBtn addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgBtn.mas_centerY);
        make.right.equalTo(bgBtn.mas_right).offset([self Suit:-10]);
        make.width.height.mas_equalTo([self Suit:13]);
    }];
    
    
    return headView;
}

#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RecommandCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"recommandCell" forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Actions

- (void)clickCategoryBtn:(UIButton *)button {
    
    NSLog(@"点击了%@", self.cateArray[button.tag-1000]);
}

//点击取消按钮
- (void)clickCancelBtn {
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
    //[self searchBarOverAnimation];
}

- (void)searchBarOverAnimation {
    [UIView animateWithDuration:0.4 animations:^{
        self.searchBar.frame = CGRectMake([self Suit:15], 8, 28, 28);
    } completion:^(BOOL finished) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.searchBar resignFirstResponder];
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
