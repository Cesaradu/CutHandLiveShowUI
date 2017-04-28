//
//  EditViewController.m
//  CutHand
//
//  Created by hztuen on 2017/4/25.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "EditViewController.h"
#import "EditTableViewCell.h"
#import "GenderViewController.h"

@interface EditViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInit];
    [self buildUI];
}

- (void)setupInit {
    self.titleArray = @[@"头像", @"昵称", @"性别", @"年龄", @"所在地", @"个性签名"];
    self.view.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    self.title = @"编辑个人资料";
}

- (void)buildUI {
    UIButton *saveBtn = [UIButton buttonWithTitle:@"储存" AndTitleColor:@"ffffff" AndTitleFont:[self SuitFont:14] AndBackgroundColor:nil addTarget:self action:@selector(clickSaveBtn)];
    saveBtn.frame = CGRectMake(0, 0, 60, 40);
    [saveBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.tableView.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"editCell"];
    if (!cell) {
        cell = [[EditTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"editCell"];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    
    cell.leftLabel.text = self.titleArray[indexPath.row];
    if (indexPath.row == 0) {
        cell.headImage.hidden = NO;
    } else {
        cell.headImage.hidden = YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            
        }
            break;
            
        case 1:
        {
            
        }
            break;
            
        case 2:
        {
            GenderViewController *genderVC = [[GenderViewController alloc] init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:genderVC animated:YES];
        }
            break;
            
        case 3:
        {
            
        }
            break;
            
        case 4:
        {
            
        }
            break;
            
        case 5:
        {
            
        }
            break;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self Suit:75];
}


- (void)clickSaveBtn {
    
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
