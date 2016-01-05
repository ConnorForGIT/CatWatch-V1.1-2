//
//  BrandsCollectionCell.m
//  IDailyWatch
//
//  Created by   赵东东 on 14-10-16.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BrandsCollectionCell.h"

@implementation BrandsCollectionCell
- (void)dealloc
{
    [_scrolView release];
    [_images release];
    [_lable1 release];
    [_lable2 release];
    [_web release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myWidth = [UIScreen mainScreen].bounds.size.width;
        self.myHeight = [UIScreen mainScreen].bounds.size.height;
        
        
        self.scrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,_myWidth * 320 / 320,_myHeight * (568 - 44 - 49 + 25) / 568)];
//          _scrolView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_scrolView];
        
        
        
        
        
        self.images = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 120, 120)];

        [self.scrolView addSubview:_images];
        
        self.lable1 = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 200, 30)];
        _lable1.font = [UIFont boldSystemFontOfSize:12];
                
        [self.scrolView addSubview:_lable1];
        
        
        self.lable2 = [[UILabel alloc] initWithFrame:CGRectMake(140, 45, 150, 110)];
        _lable2.font = [UIFont boldSystemFontOfSize:11];
     
        _lable2.numberOfLines = 0;
        _lable2.textColor = [UIColor grayColor];
        [self.scrolView addSubview:_lable2];
        
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5, 160, 320, 0.5)];
        line.backgroundColor = [UIColor blackColor];
        [self.scrolView addSubview:line];
        [line release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 480 * 396, [UIScreen mainScreen].bounds.size.width / 320 *320, [UIScreen mainScreen].bounds.size.height / 480 *30)];
        label.backgroundColor = [UIColor whiteColor];
        label.alpha = 0.8f;
        [self.contentView addSubview:label];
        
        
        //-----------------------------------------------------//
        
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"返回副本.png"]] forState:UIControlStateNormal];
        
        _button1.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *15 , [UIScreen mainScreen].bounds.size.height / 480 *396, [UIScreen mainScreen].bounds.size.width / 320 *30 , [UIScreen mainScreen].bounds.size.height / 480 *30);
        
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"分享.png"]] forState:UIControlStateNormal];
        
        
        _button2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *65 , [UIScreen mainScreen].bounds.size.height / 480 *396, [UIScreen mainScreen].bounds.size.width / 320 *30 , [UIScreen mainScreen].bounds.size.height / 480 *30);
        
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button3 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"收藏2.png"]] forState:UIControlStateNormal];
        
        _button3.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *115 , [UIScreen mainScreen].bounds.size.height / 480 *396, [UIScreen mainScreen].bounds.size.width / 320 *30 , [UIScreen mainScreen].bounds.size.height / 480 *30);
        
        _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button4 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"字体.png"]] forState:UIControlStateNormal];
        
        
        _button4.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *165 , [UIScreen mainScreen].bounds.size.height / 480 *396, [UIScreen mainScreen].bounds.size.width / 320 *30 , [UIScreen mainScreen].bounds.size.height / 480 *30);
        
        
        _button5 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button5 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"左.png"]] forState:UIControlStateNormal];
        
        _button5.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *215 , [UIScreen mainScreen].bounds.size.height / 480 *396, [UIScreen mainScreen].bounds.size.width / 320 *30 , [UIScreen mainScreen].bounds.size.height / 480 *30);
        
        
        _button6 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button6 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"右.png"]] forState:UIControlStateNormal];
        
        _button6.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *265, [UIScreen mainScreen].bounds.size.height / 480 *396, [UIScreen mainScreen].bounds.size.width / 320 *30 , [UIScreen mainScreen].bounds.size.height / 480 *30);
        
        
        
        
        [self.contentView addSubview:_button1];
        [self.contentView addSubview:_button2];
        [self.contentView addSubview:_button3];
        [self.contentView addSubview:_button4];
        [self.contentView addSubview:_button5];
        [self.contentView addSubview:_button6];
        
            

    }
    
    return self;
}

- (void)createWeb
{
    [_web removeFromSuperview];
    self.web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 180, 320, 200)];
    self.web.scrollView.scrollEnabled = NO;
    self.web.delegate = self;
    
    for (id subview in _web.subviews){
        if ([[subview class] isSubclassOfClass:[UIScrollView class]]) {
            ((UIScrollView *)subview).bounces = NO;
        }
    }
    
    [_scrolView addSubview:_web];
}



@end
