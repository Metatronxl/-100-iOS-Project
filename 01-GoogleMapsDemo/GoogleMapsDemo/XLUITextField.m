//
//  XLUITextField.m
//  GoogleMapsDemo
//
//  Created by  Metatronxl on 2017/4/7.
//  Copyright © 2017年 Karl. All rights reserved.
//

#import "XLUITextField.h"

@implementation XLUITextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // Initialization code
        
    }
    
    return self;
    
}




- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x -= 3; //像右边偏15
    return iconRect;
}

//UITextField 文字与输入框的距离
- (CGRect)textRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, 45, 0);
    
}

//控制文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, 45, 0);
}

//制造下划线效果
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame)-40, 0.5));
}

@end
