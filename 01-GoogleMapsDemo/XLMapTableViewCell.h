//
//  XLMapTableViewCell.h
//  GoogleMapsDemo
//
//  Created by  Metatronxl on 2017/4/12.
//  Copyright © 2017年 Karl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLMapTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailedAddressLabel;

@end
