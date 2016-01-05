//
//  FAVContentViewController.h
//  IDailyWatch
//
//  Created by 18班 班长 on 14-10-28.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewCollectionViewCell.h"

@interface FAVContentViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UIWebViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UIScrollView * scroll;

@property (nonatomic, retain) UICollectionView * collectionView;

@property (nonatomic, retain) UIWebView * webView;

@property (nonatomic, retain) WebViewCollectionViewCell * webViewCell;

@property (nonatomic, retain) NSMutableArray * modelArr;

@property (nonatomic, assign) NSInteger page;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model:(NSMutableArray *)model page:(NSInteger)page;
@end
