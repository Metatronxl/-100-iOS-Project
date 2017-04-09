//
//  JGTimeView.m
//  倒计时View
//
//  Created by aaa on 16/2/29.
//  Copyright © 2016年 xulei. All rights reserved.
//

#import "JGTimeView.h"

@interface  JGTimeView()
//时间显示的label eg: 0 0一个数字一个label
@property (nonatomic,strong)UILabel * label1;
@property (nonatomic,strong)UILabel * label2;

@end

@implementation JGTimeView
//绘图方法
- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor lightGrayColor]set];
    CGContextSetLineWidth(ctx, 1);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextAddRect(ctx, CGRectMake(1, 0, 12,20));
    CGContextAddRect(ctx, CGRectMake(13, 0, 12,20));
    CGContextStrokePath(ctx);
}
//初始化方法
- (instancetype)initWithFrame:(CGRect)frame AndTimeString:(NSString *)timeString{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        NSArray * timeArray = [self getArrayFormStr:timeString];
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(1, 0, 12,20)];
        UIColor * color = [[UIColor alloc]initWithRed:200/255.0 green:0 blue:0 alpha:1.0];
        label1.textColor = color;
         label1.font = [UIFont systemFontOfSize:15];
        [self addSubview:label1];
        label1.text = timeArray[0];
        label1.textAlignment = 1;
        self.label1 = label1;
        UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(13, 0, 12,20)];
        label2.textColor = color;
        label2.font = [UIFont systemFontOfSize:15];
//        label2.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:20.f];
        [self addSubview:label2];
        label2.text = timeArray[1];
        label2.textAlignment = 1;
        self.label2 = label2;
    }
    return self;
}
//两个字符range方法转成数组
- (NSArray *)getArrayFormStr:(NSString *)str{
    NSRange range1 = NSMakeRange(0, 1);
    NSRange range2 = NSMakeRange(1, 1);
    NSString * str1 = [str substringWithRange:range1];
    NSString * str2 = [str substringWithRange:range2];
    NSArray * arr = @[str1,str2];
    return arr;
}
//set方法重置时间
- (void)setTimeString:(NSString *)timeString{
     NSArray * timeArray = [self getArrayFormStr:timeString];
    self.label1.text = timeArray[0];
    self.label2.text = timeArray[1];
}

- (void)setChangeColor:(UIColor *)changeColor{
    
    self.label1.textColor = changeColor;
    self.label2.textColor = changeColor;
    
}

@end
