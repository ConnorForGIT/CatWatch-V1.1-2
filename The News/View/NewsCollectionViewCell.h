//
//  NewsCollectionViewCell.h
//  IDailyWatch
//
//  Created by 申洲 on 14-10-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCollectionViewCell : UICollectionViewCell<UIWebViewDelegate>
@property (nonatomic, retain) UIScrollView *scroll;
@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) UILabel *XianLabel;
@property (nonatomic, retain) UILabel *authorLabel;
@property (nonatomic, retain) UILabel *sourceLabel;
@property (nonatomic, retain) UILabel *pubdateLabel;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIView *viewF;

@property (nonatomic, retain) UIButton *button1;
@property (nonatomic, retain) UIButton *button2;
@property (nonatomic, retain) UIButton *button3;
@property (nonatomic, retain) UIButton *button4;
@property (nonatomic, retain) UIButton *button5;
@property (nonatomic, retain) UIButton *button6;

@end
