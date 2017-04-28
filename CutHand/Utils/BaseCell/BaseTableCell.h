//
//  BaseTableCell.h
//  CutHand
//
//  Created by hztuen on 2017/4/26.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableCell : UITableViewCell

// 适配界面
-(float)Suit:(float)MySuit;

// 适配字号
-(float)SuitFont:(float)font;

@end
