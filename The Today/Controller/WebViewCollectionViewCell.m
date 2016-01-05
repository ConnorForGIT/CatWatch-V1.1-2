//
//  WebViewCollectionViewCell.m
//  IDailyWatch
//
//  Created by 18班 班长 on 14-10-25.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "WebViewCollectionViewCell.h"

@implementation WebViewCollectionViewCell

-(void)dealloc
{
    [_labelAuthor release];
    [_labelDate release];
    [_labelSource release];
    [_labelTitle release];
    [_scroll release];
    [_headScrollView release];
    
    
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        _headScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, self.scroll.frame.size.width,self.scroll.bounds.size.height/5)];
        
        [self.scroll addSubview:_headScrollView];
        self.labelSource = [[UILabel alloc]initWithFrame:CGRectMake(10, self.headScrollView.frame.size.height + self.headScrollView.frame.origin.y, 300, 30)];
        self.labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.labelSource.frame.origin.x, self.labelSource.frame.size.height + self.labelSource.frame.origin.y + 5, self.labelSource.frame.size.width, self.labelSource.frame.size.height + 20)];
        self.labelTitle.numberOfLines = 0;
        self.labelTitle.font = [UIFont boldSystemFontOfSize:18];
        
        self.labelAuthor = [[UILabel alloc]initWithFrame:CGRectMake(self.labelTitle.frame.origin.x, self.labelTitle.frame.size.height + self.labelTitle.frame.origin.y + 5, self.labelTitle.frame.size.width / 2 + 20, self.labelTitle.frame.size.height)];
        self.labelAuthor.font = [UIFont boldSystemFontOfSize:14];
        self.labelDate = [[UILabel alloc]initWithFrame:CGRectMake(self.labelAuthor.frame.origin.x + self.labelAuthor.frame.size.width + 15, self.labelAuthor.frame.origin.y, self.labelAuthor.frame.size.width - 5, self.labelAuthor.frame.size.height)];
        self.labelDate.font = [UIFont boldSystemFontOfSize:14];
        
        self.webView = [[UIWebView alloc]init];
        _webView.scrollView.scrollEnabled = NO;
        [_scroll addSubview:_webView];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(_labelAuthor.frame.origin.x, _labelAuthor.frame.origin.y + _labelAuthor.frame.size.height + 10, 300, 1);
        btn.backgroundColor = [UIColor lightGrayColor];
        [self.scroll addSubview:btn];
        
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
        [self.contentView addSubview:_scroll];
        [_scroll release];
        [_labelAuthor release];
        [_labelDate release];
        [_labelSource release];
        [_labelTitle release];
        [self.contentView addSubview:label];
        [self.contentView addSubview:_button1];
        
        
        [self.contentView addSubview:_button2];
        
        
        [self.contentView addSubview:_button3];
        
        
        [self.contentView addSubview:_button4];
        
        
        [self.contentView addSubview:_button5];
        
        
        [self.contentView addSubview:_button6];
        
        
        [self.scroll addSubview:self.labelSource];
        [self.scroll addSubview:self.labelTitle];
        [self.scroll addSubview:self.labelAuthor];
        [self.scroll addSubview:self.labelDate];
        
        
        
    }
    return self;
}


@end
