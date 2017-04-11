//
//  XLNavViewController.m
//  04-XLTableView
//
//  Created by  Metatronxl on 2017/4/11.
//  Copyright © 2017年 Metatronxl. All rights reserved.
//

#import "XLNavViewController.h"

@interface XLNavViewController ()

@end

@implementation XLNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    self.navigationController.toolbar.hidden = YES;
    
    //设置导航栏的字体和背景颜色33 145 248
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:33/255.f green:145/255.f blue:248/255.f alpha:1]];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance ] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],}];
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
