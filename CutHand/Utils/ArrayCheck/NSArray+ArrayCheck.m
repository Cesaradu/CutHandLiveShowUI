//
//  NSArray+ArrayCheck.m
//  DogFood
//
//  Created by cesar on 17/1/10.
//  Copyright © 2017年 hztuen. All rights reserved.
//

#import "NSArray+ArrayCheck.h"

@implementation NSArray (ArrayCheck)

- (id)objectAtIndexCheck:(NSUInteger)index
{
    //越界
    if (index >= [self count])
    {
        return nil;
    }
    
    //null
    id value = [self objectAtIndex:index];
    if (value == [NSNull null])
    {
        return nil;
    }
    
    return value;
}


@end
