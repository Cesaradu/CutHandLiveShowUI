//
//  CategoryTableViewCell.m
//  CutHand
//
//  Created by hztuen on 2017/4/14.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "CategoryTableViewCell.h"
#import "RecommandCollectionViewCell.h"

@interface CategoryTableViewCell() <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation CategoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setItemSize:CGSizeMake([self Suit:115], [self Suit:115])];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, (ScreenWidth-[self Suit:115]*3)/4, 0, (ScreenWidth-[self Suit:115]*3)/4);
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.minimumLineSpacing = (ScreenWidth-[self Suit:115]*3)/4;
        flowLayout.minimumInteritemSpacing = 0;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [self Suit:115]) collectionViewLayout:flowLayout];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.collectionView registerClass:[RecommandCollectionViewCell class] forCellWithReuseIdentifier:@"recommandCell"];
        [self addSubview:self.collectionView];
        
    }
    return self;
}

#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RecommandCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"recommandCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)loadData:(NSIndexPath *)indexPath {
    NSArray *colorArray = @[@"775FFA", @"27b899", @"fdbb2c", @"94aaf1", @"93cdfa", @"008080"];
    RecommandCollectionViewCell *cell = (RecommandCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.bgImageView.backgroundColor = [UIColor colorWithHexString:colorArray[indexPath.section] alpha:1.0];
}

/**
 适配 给定4.7寸屏尺寸，适配4和5.5寸屏尺寸
 */
- (float)Suit:(float)MySuit
{
    (IS_IPHONE4INCH||IS_IPHONE35INCH)?(MySuit=MySuit/Suit4Inch):((IS_IPHONE55INCH)?(MySuit=MySuit*Suit55Inch):MySuit);
    return MySuit;
}

/**
 适配 给定4.7寸屏字号，适配4(-1)和5.5(+1)寸屏字号
 */
- (float)SuitFont:(float)font
{
    (IS_IPHONE4INCH||IS_IPHONE35INCH)?(font=font-1):((IS_IPHONE55INCH)?(font=font+1):font);
    return font;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
