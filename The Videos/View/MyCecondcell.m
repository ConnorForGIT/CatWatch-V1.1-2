//
//  MyCecondcell.m
//  IDailyWatch
//
//  Created by   赵东东 on 14-10-15.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MyCecondcell.h"
#import "UIImageView+WebCache.h"
#import "ASIHTTPRequest.h"
#import <MediaPlayer/MediaPlayer.h>
@implementation MyCecondcell

- (void)dealloc
{
    [_MyscrollView release];
    [_InLable1 release];
    [_InLable2 release];
    [_InLable3 release];
    [_InLable4 release];
    [_InimageView release];
    [_InWebView release];
    [_play release];
    [super dealloc];
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.myWidth = [UIScreen mainScreen].bounds.size.width;
        self.myHeight = [UIScreen mainScreen].bounds.size.height;

        
        
        
        self.MyscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0 ,_myWidth * 320 / 320,_myHeight * (568 - 44 - 49 + 25) / 568)];
        _MyscrollView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_MyscrollView];
        
       
        self.InimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
        [_InimageView setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"jiazai.jpg"]];

        
        self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_InimageView addGestureRecognizer:_tap];
        [_MyscrollView addSubview:_InimageView];
        [_InimageView setUserInteractionEnabled:YES];
        
        self.play = [[UIImageView alloc] initWithFrame:CGRectMake(138, 85, 45, 45)];
        _play.alpha = 0.7;
        _play.image = [UIImage imageNamed:@"play.png"];
        [_InimageView addSubview:_play];
        
        
        
        self.InLable1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 205, 140, 20)];
       
        _InLable1.font = [UIFont boldSystemFontOfSize:13];
        _InLable1.textColor = [UIColor grayColor];
        [_MyscrollView addSubview:_InLable1];
        
        
        self.InLable2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 225, 320, 30)];
                _InLable2.font = [UIFont boldSystemFontOfSize:15];
        [_MyscrollView addSubview:_InLable2];
        
        self.InLable3 = [[UILabel alloc] initWithFrame:CGRectMake(5, 250, 180, 20)];
                _InLable3.font = [UIFont boldSystemFontOfSize:13];
        _InLable3.textColor = [UIColor grayColor];
        [_MyscrollView addSubview:_InLable3];
        
        
        self.InLable4 = [[UILabel alloc] initWithFrame:CGRectMake(180, 250, 130, 20)];
        _InLable4.font = [UIFont boldSystemFontOfSize:13];
        _InLable4.textColor = [UIColor grayColor];
        [_MyscrollView addSubview:_InLable4];

        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5, 270, 320, 0.5)];
        line.backgroundColor = [UIColor blackColor];
        [self.MyscrollView addSubview:line];
        [line release];
        
        self.InWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 280, 320, 200)];
        self.InWebView.scrollView.scrollEnabled = NO;
        for (id subview in _InWebView.subviews){
            if ([[subview class] isSubclassOfClass:[UIScrollView class]]) {
                ((UIScrollView *)subview).bounces = NO;
            }
        }
        
        
        [_MyscrollView addSubview:_InWebView];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 480 * 396, [UIScreen mainScreen].bounds.size.width / 320 *320, [UIScreen mainScreen].bounds.size.height / 480 *30)];
        label.backgroundColor = [UIColor whiteColor];
        label.alpha = 0.8f;
        [self.contentView addSubview:label];
        
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"返回副本.png"]] forState:UIControlStateNormal];
        //    button.backgroundColor = [UIColor redColor];
        
        _button1.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *15 , [UIScreen mainScreen].bounds.size.height / 480 *396, [UIScreen mainScreen].bounds.size.width / 320 *30 , [UIScreen mainScreen].bounds.size.height / 480 *30);
        //    [button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
        
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"分享.png"]] forState:UIControlStateNormal];
        
        
        _button2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *65 , [UIScreen mainScreen].bounds.size.height / 480 *396, [UIScreen mainScreen].bounds.size.width / 320 *30 , [UIScreen mainScreen].bounds.size.height / 480 *30);
        
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button3 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"收藏2.png"]] forState:UIControlStateNormal];
        //    button.backgroundColor = [UIColor redColor];
        
        _button3.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *115 , [UIScreen mainScreen].bounds.size.height / 480 *396, [UIScreen mainScreen].bounds.size.width / 320 *30 , [UIScreen mainScreen].bounds.size.height / 480 *30);
        
        
        
        
        _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button4 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"字体.png"]] forState:UIControlStateNormal];
        
        
        _button4.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *165 , [UIScreen mainScreen].bounds.size.height / 480 *396, [UIScreen mainScreen].bounds.size.width / 320 *30 , [UIScreen mainScreen].bounds.size.height / 480 *30);
        
        
        _button5 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button5 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"左.png"]] forState:UIControlStateNormal];
        //    button.backgroundColor = [UIColor redColor];
        
        _button5.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *215 , [UIScreen mainScreen].bounds.size.height / 480 *396, [UIScreen mainScreen].bounds.size.width / 320 *30 , [UIScreen mainScreen].bounds.size.height / 480 *30);
        
        
        _button6 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button6 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"右.png"]] forState:UIControlStateNormal];
        //    button.backgroundColor = [UIColor redColor];
        
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

 - (void)tapAction:(UITapGestureRecognizer *)tap
{

    self.blockTo();
}


@end
