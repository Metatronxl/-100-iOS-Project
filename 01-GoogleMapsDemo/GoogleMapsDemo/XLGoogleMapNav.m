//
//  XLGoogleMapNav.m
//  GoogleMapsDemo
//
//  Created by  Metatronxl on 2017/4/7.
//  Copyright © 2017年 Karl. All rights reserved.
//

#import "XLGoogleMapNav.h"

@interface XLGoogleMapNav ()

@end

@implementation XLGoogleMapNav

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    self.navigationController.toolbar.hidden = NO;
    
    
    //设置导航栏的字体和背景颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:242/255.f green:80/255.f blue:55/255.f alpha:1]];
        [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance ] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],}];
    //去除导航栏与View之间的阴影
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
