//
//  BrandsCollectionCell.h
//  IDailyWatch
//
//  Created by   赵东东 on 14-10-16.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrandsCollectionCell : UICollectionViewCell<UIWebViewDelegate>
@property (nonatomic , retain)UIScrollView *scrolView;
@property (nonatomic , retain)UIImageView *images;
@property (nonatomic , retain)UILabel *lable1;
@property (nonatomic , retain)UILabel *lable2;
@property (nonatomic , retain)UIWebView *web;

@property (nonatomic, assign)float myWidth;
@property (nonatomic, assign)float myHeight;
- (void)createWeb;
@property (nonatomic , retain)UIButton *button1;
@property (nonatomic , retain)UIButton *button2;
@property (nonatomic , retain)UIButton *button3;
@property (nonatomic , retain)UIButton *button4;
@property (nonatomic , retain)UIButton *button5;
@property (nonatomic , retain)UIButton *button6;
@end
