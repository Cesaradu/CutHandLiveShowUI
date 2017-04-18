//
//  NSArray+ArrayCheck.h
//  DogFood
//
//  Created by cesar on 17/1/10.
//  Copyright © 2017年 hztuen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ArrayCheck)

//检查数组是否越界或是NSNull，如果是，返回nil
- (id)objectAtIndexCheck:(NSUInteger)index;

@end
