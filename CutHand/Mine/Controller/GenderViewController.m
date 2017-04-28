//
//  GenderViewController.m
//  CutHand
//
//  Created by hztuen on 2017/4/25.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "GenderViewController.h"

@interface GenderViewController ()

@property (nonatomic, strong) UIButton *maleBtn;
@property (nonatomic, strong) UIButton *femaleBtn;

@end

@implementation GenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupInit];
    [self buildUI];
}

- (void)setupInit {
    self.view.backgroundColor = [UIColor colorWithHexString:BGColor alpha:1.0];
    self.title = @"性别";
}

- (void)buildUI {
    
    self.maleBtn = [[UIButton alloc] init];
    self.maleBtn.selected = NO;
    self.maleBtn.adjustsImageWhenHighlighted = NO;
    [self.maleBtn setImage:[UIImage imageNamed:@"man"] forState:UIControlStateNormal];
    [self.maleBtn setImage:[UIImage imageNamed:@"selected_man"] forState:UIControlStateSelected];
    [self.maleBtn addTarget:self action:@selector(clickMaleBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.maleBtn];
    [self.maleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_centerY).offset([self Suit:-20]);
    }];
    
    self.femaleBtn = [[UIButton alloc] init];
    self.femaleBtn.selected = NO;
    self.femaleBtn.adjustsImageWhenHighlighted = NO;
    [self.femaleBtn setImage:[UIImage imageNamed:@"woman"] forState:UIControlStateNormal];
    [self.femaleBtn setImage:[UIImage imageNamed:@"selected_woman"] forState:UIControlStateSelected];
    [self.femaleBtn addTarget:self action:@selector(clickFemaleBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.femaleBtn];
    [self.femaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_centerY).offset([self Suit:20]);
    }];
    
    
}

- (void)clickMaleBtn {
    self.maleBtn.selected = YES;
    self.femaleBtn.selected = NO;
}

- (void)clickFemaleBtn {
    self.maleBtn.selected = NO;
    self.femaleBtn.selected = YES;
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
