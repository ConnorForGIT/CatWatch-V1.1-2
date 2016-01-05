//
//  InBrandsController.h
//  IDailyWatch
//
//  Created by   赵东东 on 14-10-16.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"



@interface InBrandsController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIWebViewDelegate>



@property (nonatomic, retain)Product *productModel;
@property(nonatomic , assign)NSInteger  number;
@property (nonatomic, retain)NSMutableArray * modelArr;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign)float myWidth;
@property (nonatomic, assign)float myHeight;
@property (nonatomic, retain) UISlider *slider;

@property (nonatomic, assign) BOOL flag1;
@end
