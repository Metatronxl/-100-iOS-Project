 //
//  ViewController.m
//  GoogleMapsDemo
//
//  Created by xulei on 17/4/7.
//  Copyright © 2017年 xulei. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "XLUITextField.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#define GoogleMapKey @"AIzaSyC6UdZfvOoEvOL9fFHQPfRawNix38ToRgM"
#define GooglePlaceKey @"AIzaSyBlE90Z0bf5G1cvk2j-ClyXbV-2UpoVqlE"
@interface ViewController ()<GMSAutocompleteViewControllerDelegate,GMSAutocompleteFetcherDelegate,GMSMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    GMSMapView *_googleMapView;
    CLLocationManager *_loacationManager;
    XLUITextField *_addressTextField;//地址搜索框
    XLUITextField *_currentLocationTextField;//本地地址
    GMSAutocompleteFetcher *_autoCompleteFetcher;
    UITableView *_mainTableView;//用以展示自动补全结果的表格式图
    NSMutableArray *_dataArray;
    
}


@property (nonatomic,strong,readonly) CLLocation *myLocation;
//判断是否是第一次获取定位地址，并将其设为自身定位
@property (nonatomic,assign) bool *flag;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [GMSPlacesClient provideAPIKey:GooglePlaceKey];
    //允许获取自己的定位
//    _googleMapView.myLocationEnabled = YES;
   //首次定位时flag设置为1
    _flag = (bool*)1;
    // Do any additional setup after loading the view, typically from a nib.
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:242/255.f green:80/255.f blue:55/255.f alpha:1];
    [self createMapView];
    [self createCenterViw];
    [self createTextField];
    _autoCompleteFetcher = [[GMSAutocompleteFetcher alloc] init];
    _autoCompleteFetcher.delegate = self;
    _dataArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldSelectAll) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"myLocation"] && [object isKindOfClass:[GMSMapView class]])
    {
        [_googleMapView animateToCameraPosition:[GMSCameraPosition cameraWithLatitude:_googleMapView.myLocation.coordinate.latitude
                                                                            longitude:_googleMapView.myLocation.coordinate.longitude
                                                                                 zoom:6]];
  
    }
}



- (void)createTextField{
    
    //自身地址定位
    _currentLocationTextField = [[XLUITextField alloc] initWithFrame:CGRectMake(40, 0, self.view.bounds.size.width-40, 40)];
    _currentLocationTextField.delegate = self;
    _currentLocationTextField.backgroundColor = [UIColor clearColor];
    _currentLocationTextField.textColor = [UIColor whiteColor];
    _currentLocationTextField.returnKeyType = UIReturnKeySearch;
    _currentLocationTextField.textAlignment = NSTextAlignmentLeft;
    _currentLocationTextField.placeholder = @"Current Location(store)";
    _currentLocationTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self setTextFiledLeftImage:_currentLocationTextField image:@"location"];
//    _currentLocationTextField.leftView
    [self.view addSubview:_currentLocationTextField];
    //地址搜寻TextField
    _addressTextField = [[XLUITextField alloc] initWithFrame:CGRectMake(40, 40, self.view.bounds.size.width-40, 40)];
    _addressTextField.delegate = self;
    _addressTextField.backgroundColor = [UIColor clearColor];
    _addressTextField.textColor = [UIColor whiteColor];
    _addressTextField.returnKeyType = UIReturnKeySearch;
    _addressTextField.textAlignment = NSTextAlignmentLeft;
    _addressTextField.placeholder = @"Where to";
    _addressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self setTextFiledLeftImage:_addressTextField image:@"position"];
    [self.view addSubview:_addressTextField];

    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width-40, 200) style:UITableViewStyleGrouped];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
    _mainTableView.hidden = YES;
}

- (void)setTextFiledLeftImage:(UITextField*)textFiled image:(NSString*)image{
    textFiled.leftViewMode=UITextFieldViewModeAlways;
    UIImageView *image1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:image]];
//    image1.frame=CGRectMake(0, 0, 27, 27);
    textFiled.leftView=image1;

}




- (void)createMapView{
    /*
     地图初始化
     **/
    _googleMapView = [[GMSMapView alloc] initWithFrame:CGRectMake(0, 88, self.view.bounds.size.width, self.view.bounds.size.height-88)];
    _googleMapView.delegate = self;
    _googleMapView.indoorEnabled = NO;
    _googleMapView.settings.rotateGestures = NO;
    _googleMapView.settings.tiltGestures = NO;
    _googleMapView.settings.myLocationButton = YES;
    _googleMapView.myLocationEnabled = YES;
    _loacationManager = [[CLLocationManager alloc] init];
    _loacationManager.delegate  = self;
    [_loacationManager requestWhenInUseAuthorization];
    [self.view addSubview:_googleMapView];
    
}

- (void)createCenterViw{
    /**
     中间定位图标
     */
    UIImageView *centerImageView=[[UIImageView alloc]initWithFrame:CGRectMake((_googleMapView.bounds.size.width)/2-7, (_googleMapView.bounds.size.height)/2-40, 15, 40)];
    centerImageView.image=[UIImage imageNamed:@"btn_home_Business2"];
    [self.view addSubview:centerImageView];
    
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    /**
     *    拿到授权发起定位请求
     
     */
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_loacationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    /**
     * 位置更新时调用
     */
    CLLocation *currentLocation = locations.firstObject;
    _googleMapView.camera = [[GMSCameraPosition alloc] initWithTarget:currentLocation.coordinate zoom:15 bearing:0 viewingAngle:0];
    [_loacationManager stopUpdatingLocation];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self geoSearchWithString:textField.text];
    [textField resignFirstResponder];
    return YES;
}

//- (void)textFieldChanged{
//    
//    if([_currentLocationTextField isFirstResponder]){
//            _flag = (bool *)1;
//            GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
//            acController.delegate = self;
//            [self presentViewController:acController animated:YES completion:nil];
//        
//    }else if([_addressTextField isFirstResponder]){
//        _flag = (bool *)0;
//        GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
//        acController.delegate = self;
//        [self presentViewController:acController animated:YES completion:nil];
//    }
//}

- (void)textFieldChanged{
    
    if([_currentLocationTextField isFirstResponder]){
        if ([_currentLocationTextField.text isEqualToString:@""]) {
            _mainTableView.hidden = YES;
            [_dataArray removeAllObjects];
            [_mainTableView reloadData];
        }else{
            _flag = (bool *)0;
            [_autoCompleteFetcher sourceTextHasChanged:_addressTextField.text];
        }
    }else if([_addressTextField isFirstResponder]){
        if ([_addressTextField.text isEqualToString:@""]) {
            _mainTableView.hidden = YES;
            [_dataArray removeAllObjects];
            [_mainTableView reloadData];
        }else{
            _flag = (bool *)0;
            [_autoCompleteFetcher sourceTextHasChanged:_addressTextField.text];
        }
    }
    
}



-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    [_addressTextField selectAll:self];
}
#pragma  mark - Mapview Delegate
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    _mainTableView.hidden =YES;
    [_addressTextField resignFirstResponder];
}

- (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture{
    
//    _addressTextField.text = @"";
}

- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position{
    
    //反向地理编码
    [[GMSGeocoder geocoder]reverseGeocodeCoordinate:position.target completionHandler:^(GMSReverseGeocodeResponse * response, NSError * error) {
        if (response.results) {
            GMSAddress *address = response.results[0];
            NSLog(@"%@",address.thoroughfare);

            if (_flag) {
//
                _currentLocationTextField.text = address.thoroughfare;
////                _addressTextField.text =@"Where to";
//                _flag = (bool*)0;
            }else{
                _addressTextField.text = address.thoroughfare;
            }
            
        }
    }];
}

#pragma mark -- autoCompleteDelegate
- (void)didAutocompleteWithPredictions:(NSArray<GMSAutocompletePrediction *> *)predictions{
    if (predictions.count) {
        _mainTableView.hidden = NO;
        _dataArray = (NSMutableArray *)predictions;
        
        //对每一个遍历到的地点在地图上进行标记
        for(int i=0;i<_dataArray.count;i++){
            GMSAutocompletePrediction *prediction = _dataArray[i];
            [self getCoordinateWithString:prediction.attributedFullText.string];
        }
        [_mainTableView reloadData];
    }
}

- (void)didFailAutocompleteWithError:(NSError *)error{
    
}

- (void)textFieldSelectAll{
//    [_addressTextField selectAll:self];
}

#pragma  mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    GMSAutocompletePrediction *prediction = _dataArray[indexPath.row];
    cell.textLabel.text = prediction.attributedFullText.string;
    
//    [self getCoordinateWithString:cell.textLabel.text];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GMSAutocompletePrediction *prediction = _dataArray[indexPath.row];
    [self geoSearchWithString:prediction.attributedFullText.string];
    _mainTableView.hidden = YES;
    
}

//根据搜索的地址在地图上进行地址标记
- (void)getCoordinateWithString:(NSString *)string{
    /**
     *  发起地理编码请求
     */
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&key=%@",[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],GoogleMapKey];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = responseObject;
        if ([responseDic[@"status"] isEqualToString:@"OK"]) {
            NSArray *returenArray = responseDic[@"results"];
            CLLocationCoordinate2D search ;
            NSDictionary *addressDic = returenArray[0];
            NSDictionary *locationDic = addressDic[@"geometry"][@"location"];
            search.longitude = [locationDic[@"lng"] floatValue];
            search.latitude = [locationDic[@"lat"] floatValue];
            GMSMarker *marker = [GMSMarker markerWithPosition:search];
            marker.map= _googleMapView;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

- (void)geoSearchWithString:(NSString *)string{
    /**
     *  发起地理编码请求
     */
    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&key=%@",[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],GoogleMapKey];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = responseObject;
        if ([responseDic[@"status"] isEqualToString:@"OK"]) {
            NSArray *returenArray = responseDic[@"results"];
            CLLocationCoordinate2D search ;
            NSDictionary *addressDic = returenArray[0];
            NSDictionary *locationDic = addressDic[@"geometry"][@"location"];
            search.longitude = [locationDic[@"lng"] floatValue];
            search.latitude = [locationDic[@"lat"] floatValue];
            [_googleMapView animateToLocation:search];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [_addressTextField resignFirstResponder];
}

#pragma mark - GooglePlace 自动填充
// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    if (_flag) {
        _currentLocationTextField.text = [NSString stringWithFormat:@"%@,%@",place.name,place.formattedAddress];
        [self geoSearchWithString:_currentLocationTextField.text];
        
    }else{
        _addressTextField.text =[NSString stringWithFormat:@"%@,%@",place.name,place.formattedAddress];
        [self geoSearchWithString:_addressTextField.text];
    }
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
