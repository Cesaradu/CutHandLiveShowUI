//
//  AnchorLevelViewController.m
//  CutHand
//
//  Created by hztuen on 2017/4/26.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "AnchorLevelViewController.h"
#import "iCarousel.h"
#import "LevelView.h"
#import "LevelCell.h"

@interface AnchorLevelViewController () <UITableViewDelegate, UITableViewDataSource, iCarouselDelegate,iCarouselDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong) iCarousel *iCarousel;

@end

@implementation AnchorLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupInit];
    [self buildUI];
}

- (void)setupInit {
    self.view.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    self.title = @"主播等级";
}

- (void)buildUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.tableHeaderView = [self buildHeadView];
    [self.view addSubview:self.tableView];
}

- (UIView *)buildHeadView {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-[self Suit:170/2*3]-64)];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [self Suit:411/2])];
    bgView.backgroundColor = [UIColor colorWithHexString:MainColor alpha:1.0];
    [headView addSubview:bgView];

    self.iCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [self Suit:564/2])];
    self.iCarousel.delegate = self;
    self.iCarousel.dataSource = self;
    self.iCarousel.bounces = NO;
    self.iCarousel.pagingEnabled = YES;
    self.iCarousel.type = iCarouselTypeCustom;
    [headView addSubview:self.iCarousel];
    
    UILabel *label = [UILabel labelWithTitle:@"如何升级" AndColor:@"C0C0C0" AndFont:[self SuitFont:17] AndAlignment:NSTextAlignmentCenter];
    [headView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.top.equalTo(self.iCarousel.mas_bottom).offset([self Suit:30]);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithHexString:@"c0c0c0" alpha:1.0];
    [headView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label.mas_centerY);
        make.left.equalTo(headView.mas_left).offset([self Suit:15]);
        make.right.equalTo(label.mas_left).offset([self Suit:-15]);
        make.height.mas_equalTo([self Suit:2]);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithHexString:@"c0c0c0" alpha:1.0];
    [headView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label.mas_centerY);
        make.left.equalTo(label.mas_right).offset([self Suit:15]);
        make.right.equalTo(headView.mas_right).offset([self Suit:-15]);
        make.height.mas_equalTo([self Suit:2]);
    }];
    
    return headView;
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LevelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"levelCell"];
    if (!cell) {
        cell = [[LevelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"levelCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0, [self Suit:118/2+30], 0, [self Suit:-118/2-30]);
    }
    
    if (indexPath.row == 0) {
        cell.label1.text = @"粉丝增加";
        cell.label2.text = @"分享直播以获得更多的粉丝";
        cell.leftImage.image = [UIImage imageNamed:@"fansNum"];
    } else if (indexPath.row == 1) {
        cell.label1.text = @"获得礼物";
        cell.label2.text = @"想办法获得更多礼物";
        cell.leftImage.image = [UIImage imageNamed:@"getGift"];
    } else {
        cell.label1.text = @"直播时长";
        cell.label2.text = @"直播时间越长越好";
        cell.leftImage.image = [UIImage imageNamed:@"liveTime"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self Suit:170/2];
}

#pragma mark - iCarousel代理

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    LevelView *levelView = [[LevelView alloc] initWithFrame:CGRectMake(0, 0, [self Suit:690/2], [self Suit:564/2])];
    levelView.layer.cornerRadius = [self Suit:5];
    levelView.layer.shadowOffset = CGSizeMake([self Suit:3], [self Suit:3]);
    levelView.layer.shadowOpacity = 0.8;
    levelView.layer.shadowRadius = [self Suit:3];
    
    [levelView loadData:index];
    
    return levelView;
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform {
    static CGFloat max_sacle = 1.0f;
    static CGFloat min_scale = 0.6f;
    if (offset <= 1 && offset >= -1) {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        float slope = (max_sacle - min_scale) / 1;
        
        CGFloat scale = min_scale + slope*tempScale;
        transform = CATransform3DScale(transform, scale, scale, 1);
    }else{
        transform = CATransform3DScale(transform, min_scale, min_scale, 1);
    }
    
    return CATransform3DTranslate(transform, offset * self.iCarousel.itemWidth * 1.4, 0.0, 0.0);
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return 3;
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
