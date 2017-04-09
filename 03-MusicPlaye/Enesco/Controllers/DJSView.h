//
//  DJSView.h
//  倒计时View
//
//  Created by aaa on 16/2/29.
//  Copyright © 2016年 xulei. All rights reserved.
//

#import <UIKit/UIKit.h>
//宏定义 时间格式,这边要与后台返回的字符串一致
#define DateFormatType @"yyyy-MM-dd-HH:mm:ss"
typedef void (^endBlock)();

@interface DJSView : UIView

@property (nonatomic,strong)NSString * endString;

- (instancetype)initWithFrame:(CGRect)frame AndEndTime:(NSString *)endTime AndEndBlock:(endBlock)block;

@end
