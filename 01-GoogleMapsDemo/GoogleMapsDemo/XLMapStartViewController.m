//
//  XLMapStartViewController.m
//  GoogleMapsDemo
//
//  Created by  Metatronxl on 2017/4/7.
//  Copyright © 2017年 Karl. All rights reserved.
//

#import "XLMapStartViewController.h"
#import "XLGoogleMapNav.h"
#import "ViewController.h"

@interface XLMapStartViewController ()
@property (weak, nonatomic) IBOutlet UIButton *pushIntoMap;
- (IBAction)pushIntoMap:(UIButton *)sender;

@end

@implementation XLMapStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)pushIntoMap:(UIButton *)sender {
    ViewController *vc = [[ViewController alloc]init];
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
