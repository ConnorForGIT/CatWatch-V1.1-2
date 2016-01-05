//
//  ToDayContentViewController.h
//  IDailyWatch
//
//  Created by 18班 班长 on 14-10-25.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WebViewCollectionViewCell.h"
@interface ToDayContentViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIWebViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UIScrollView * scroll;
@property (nonatomic, retain) UICollectionView * collectionView;

@property (nonatomic, retain) NSMutableArray * modelArr;



@property (nonatomic, retain) WebViewCollectionViewCell * webViewCell;

@property (nonatomic, assign) NSInteger pageTag;

@property (nonatomic, assign) BOOL flag;

@property (nonatomic, assign) NSInteger modelNum;
@property(nonatomic,assign)NSInteger start;
@property (nonatomic, retain) UILabel *viewF;
@property (nonatomic, retain) UIButton *buttonSmall;
@property (nonatomic, retain) UIButton *buttonCentre;
@property (nonatomic, retain) UIButton *buttonBig;
@property (nonatomic, retain) UIButton *buttonPlus;
@property (nonatomic, retain) UILabel *labelPM;
@property (nonatomic, retain) UILabel *labelZT;
@property (nonatomic, retain) UILabel *labelHX;
@property (nonatomic, retain) UISlider *slider;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil page:(NSInteger)page modelArr:(NSMutableArray *)modelArr;

@end
