//
//  People.m
//  04-XLTableView
//
//  Created by  Metatronxl on 2017/4/10.
//  Copyright © 2017年 Metatronxl. All rights reserved.
//

#import "People.h"

@implementation People

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)peopleWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end
