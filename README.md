# -100-iOS-Project
每天上传一个DEMO，发现打脸了请``大力戳我``：）

### [01-GoogleMap API](https://github.com/Metatronxl/-100-iOS-Project/tree/master/01-GoogleMapsDemo)
>1.使用了googleMap API
----
### [02-UITableView](https://github.com/Metatronxl/-100-iOS-Project/tree/master/02-UITableView)
>1.执行跳转的页面必须在storyboard上加上导航页，然后才能使用pushViewController:animated：跳转
----
### [03-MusicPlaye](https://github.com/Metatronxl/-100-iOS-Project/tree/master/03-MusicPlaye)
```objc
  1.使用豆瓣音乐框架实现简单的音乐播放器
  2.简单的定时器功能，使用到了NSTimer
  3.使用了第三方图表框架，方便集成
```
----
### [04-XLTableView](https://github.com/Metatronxl/-100-iOS-Project/tree/master/04-XLTableView)
```objc
  1.使用plist来实现数据的读取和保存
  
  2.使用宏：（e.g）来实现页面跳转的时间值的传入
  #define STORYBOARD(identifier) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:identifier]
       -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YKTransactionDetailsVC *detailes =STORYBOARD(@"TransactionDetailsVC");
    self.hidesBottomBarWhenPushed =YES;
    detailes.data =_dataArray[indexPath.row];
    [self.navigationController pushViewController:detailes animated:YES];
    self.hidesBottomBarWhenPushed =NO;
    
   3. 自定义UINavigationController来定制样式，并使其为基模板。
 
}


```
