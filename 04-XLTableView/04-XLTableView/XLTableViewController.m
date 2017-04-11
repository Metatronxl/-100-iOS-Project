//
//  XLTableViewController.m
//  04-XLTableView
//
//  Created by  Metatronxl on 2017/4/10.
//  Copyright © 2017年 Metatronxl. All rights reserved.
//

#import "XLTableViewController.h"
#import "XLDetailedTableViewController.h"
#import "People.h"
#import "Macro.h"


@interface XLTableViewController ()

@property (nonatomic,strong) NSArray *peopleArray;
@property (nonatomic,strong) NSDictionary *peopleDic;

@end

@implementation XLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"好友列表";
    [self getPeopleData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)getPeopleData{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *filePath = [bundle pathForResource:@"work" ofType:@"plist"];
    self.peopleArray = [NSArray arrayWithContentsOfFile:filePath];
//    self.peopleDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
//    People *peoples = [People peopleWithDict:peopleDic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _peopleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    self.peopleDic = self.peopleArray[indexPath.row];
    People *people = [People peopleWithDict:self.peopleDic];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"peopleCell"];
    }
//        tableView.rowHeight = 60;
    //设置圆形头像
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = (tableView.rowHeight -10)/2.0;
    cell.imageView.image = [UIImage imageNamed:@"1.png"];
    cell.textLabel.text = people.name;
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XLDetailedTableViewController  *vc = STORYBOARD(@"XLDetailedVC");
    vc.people = [People peopleWithDict:self.peopleArray[indexPath.row]];
    
    [self.navigationController pushViewController:vc animated:YES];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
