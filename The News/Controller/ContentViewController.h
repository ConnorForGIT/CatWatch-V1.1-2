//
//  ContentViewController.h
//  IDailyWatch
//
//  Created by 申洲 on 14-10-15.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsCollectionViewCell.h"

@interface ContentViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIWebViewDelegate>
@property (nonatomic, retain) UICollectionView *collection;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger i;
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) NewsCollectionViewCell *cell;

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UILabel *viewF;
@property (nonatomic, retain) UIButton *buttonSmall;
@property (nonatomic, retain) UIButton *buttonCentre;
@property (nonatomic, retain) UIButton *buttonBig;
@property (nonatomic, retain) UIButton *buttonPlus;
@property (nonatomic, retain) UILabel *labelPM;
@property (nonatomic, retain) UILabel *labelZT;
@property (nonatomic, retain) UILabel *labelHX;
@property (nonatomic, retain) UISlider *slider;

@property (nonatomic, assign) BOOL flag1;



@end
