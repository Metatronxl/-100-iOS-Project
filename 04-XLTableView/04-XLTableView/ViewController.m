//
//  ViewController.m
//  04-XLTableView
//
//  Created by  Metatronxl on 2017/4/10.
//  Copyright © 2017年 Metatronxl. All rights reserved.
//

#import "ViewController.h"
#import "XLTableViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *enterTableBtn;
- (IBAction)EnterTableBtn:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)EnterTableBtn:(UIButton *)sender {
    
    XLTableViewController *vc = [[XLTableViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
@end
