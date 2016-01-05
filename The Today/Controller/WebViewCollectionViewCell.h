//
//  WebViewCollectionViewCell.h
//  IDailyWatch
//
//  Created by 18班 班长 on 14-10-25.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) UILabel * labelSource;
@property (nonatomic, retain) UILabel * labelTitle;
@property (nonatomic, retain) UILabel * labelAuthor;
@property (nonatomic, retain) UILabel * labelDate;
@property (nonatomic, retain) UIWebView * webView;

@property (nonatomic, retain) UIScrollView * scroll;
@property (nonatomic, retain) UIButton *button1;
@property (nonatomic, retain) UIButton *button2;
@property (nonatomic, retain) UIButton *button3;
@property (nonatomic, retain) UIButton *button4;
@property (nonatomic, retain) UIButton *button5;
@property (nonatomic, retain) UIButton *button6;

@property (nonatomic, retain) UIScrollView * headScrollView;

@end
