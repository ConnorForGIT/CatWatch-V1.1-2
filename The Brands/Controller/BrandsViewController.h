//
//  BrandsViewController.h
//  IDailyWatch
//
//  Created by 老师先给我发 on 14-10-13.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BrandsViewController : UIViewController 
@property (nonatomic, assign)float myWidth;
@property (nonatomic, assign)float myHeight;

@property (nonatomic, retain) UIPickerView * pickView;
@property (nonatomic, retain) UIButton * selBtn;
@property (nonatomic, retain) UILabel * nameLabel;

@end
