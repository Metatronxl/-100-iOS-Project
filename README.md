# -100-iOS-Project
每天上传一个DEMO，发现打脸了请``大力戳我``：）

### [01-GoogleMap API](https://github.com/Metatronxl/-100-iOS-Project/tree/master/01-GoogleMapsDemo)
>1.使用了googleMap API
----
### [02-UITableView](https://github.com/Metatronxl/-100-iOS-Project/tree/master/02-UITableView)
>1.执行跳转的页面必须在storyboard上加上导航页，然后才能使用pushViewController:animated：跳转
----
### [03-MusicPlaye](https://github.com/Metatronxl/-100-iOS-Project/tree/master/03-MusicPlaye)
> 1.使用豆瓣音乐框架实现简单的音乐播放器<hr>
> 2.简单的定时器功能，使用到了NSTimer<hr>
> 3.使用了第三方图表框架，方便集成

----
### [04-XLTableView](https://github.com/Metatronxl/-100-iOS-Project/tree/master/04-XLTableView)

> 1.使用plist来实现数据的读取和保存
  
> 2.使用宏：（e.g）来实现页面跳转的时间值的传入
```objc
#define STORYBOARD(identifier) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:identifier]
       -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YKTransactionDetailsVC *detailes =STORYBOARD(@"TransactionDetailsVC");
    self.hidesBottomBarWhenPushed =YES;
    detailes.data =_dataArray[indexPath.row];
    [self.navigationController pushViewController:detailes animated:YES];
    self.hidesBottomBarWhenPushed =NO;
    }
```    
> 3. 自定义UINavigationController来定制样式，并使其为基模板。
 
### [05-GoogleMap API](https://github.com/Metatronxl/-100-iOS-Project/tree/master/01-GoogleMapsDemo)
> 对01的demo进行了修改，将系统自带的单元格换成了自制的单元格
> 使用自定义cell的注意点
```objc
     1.设置cell的identifier的时候一定要设置为xib的名字
     2. 设置自定义cell一定要注册，不然系统无法识别
     3.网上所说的xib的identifier也要设置成xib的名字是扯淡，亲测写成test也能成功跑通：）
    //自定义单元格样式
    static NSString *identifierString = @"XLMapViewCell";
    XLMapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString];
    if (cell==nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:identifierString owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
```



