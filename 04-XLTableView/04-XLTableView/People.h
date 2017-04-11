//
//  People.h
//  04-XLTableView
//
//  Created by  Metatronxl on 2017/4/10.
//  Copyright © 2017年 Metatronxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject

@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *notes;

- (instancetype) initWithDict:(NSDictionary *)dict;
+ (instancetype)peopleWithDict:(NSDictionary *)dict;

@end
