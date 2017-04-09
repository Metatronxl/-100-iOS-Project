//
//  XLCountDownViewController.m
//  Enesco
//
//  Created by  Metatronxl on 2017/4/6.
//  Copyright © 2017年 aufree. All rights reserved.
//

#import "XLCountDownViewController.h"
#import "DJSView.h"

@interface XLCountDownViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)datePickerBtn:(UIDatePicker *)sender;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
- (IBAction)dateBtn:(UIButton *)sender;
@property (nonatomic,strong) DJSView *djsView;
//@property (nonatomic,assign) bool *judgeTime;
@property (nonatomic,strong) UIAlertController *timeAlert;
@property (nonatomic,assign) double intervalTime;


@end

@implementation XLCountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_dateBtn setBackgroundColor:[UIColor orangeColor]];
    [_dateBtn setClipsToBounds:YES];
    _dateBtn.layer.cornerRadius =5;
    [_dateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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



- (IBAction)datePickerBtn:(UIDatePicker *)sender {
}
- (IBAction)dateBtn:(UIButton *)sender {
    //选取器时间
    NSDate *date = self.datePicker.date;
    //现在时间
    NSDate *nowDate = [NSDate date];
    //时间差
//    NSLog(@"time1:%@--time2:%@",nowDate,date);
    _intervalTime = [date timeIntervalSince1970]*1-[nowDate timeIntervalSince1970]*1;
    
    if(_intervalTime <0){
        UIAlertController *tip = [UIAlertController alertControllerWithTitle:@"时间选定错误" message:@"请选择将来的某一个时间" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *conf = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [tip addAction:conf];
        [self presentViewController:tip animated:YES completion:nil];
    }
//    NSLog(@"%lf",_intervalTime);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dataStr = [dateFormatter stringFromDate:date];
    
    _djsView = [[DJSView alloc]initWithFrame:CGRectMake(100, 100, 150, 22) AndEndTime:dataStr AndEndBlock:^{
    
        //当时间到的时候的提示
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"时间到"message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *fixed = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:fixed];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];
    //给出选取时间的提示
        dataStr = [NSString stringWithFormat:@"解锁时间为:%@",dataStr ];
    
        _timeAlert = [UIAlertController alertControllerWithTitle:@"限制使用时间\n" message:dataStr preferredStyle:UIAlertControllerStyleAlert];
    

    
    
    [self presentViewController:_timeAlert animated:YES completion:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:_intervalTime target:self selector:@selector(performDismiss:) userInfo:nil repeats:NO];
}


-(void) performDismiss:(NSTimer *)timer
{
//    [_timeAlert dismissWithClickedButtonIndex:0 animated:NO];
    [_timeAlert dismissViewControllerAnimated:YES completion:nil];
}

@end
