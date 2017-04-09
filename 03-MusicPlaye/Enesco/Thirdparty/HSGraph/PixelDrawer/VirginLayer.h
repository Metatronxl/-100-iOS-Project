//
//  VirginLayer.h
//  HSCharts
//
//  Created by xulei on 16/10/14.
//  Copyright © 2016年 I really is a farmer. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@class GraphLizard;

@interface VirginLayer : CALayer

- (void)draw_updateFrame:(CGRect)frame lizard:(void (^) (GraphLizard *make))block;

@end
