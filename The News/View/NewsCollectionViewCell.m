//
//  NewsCollectionViewCell.m
//  IDailyWatch
//
//  Created by 申洲 on 14-10-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "NewsCollectionViewCell.h"


@implementation NewsCollectionViewCell

-(void)dealloc
{
    [_image release];
    [_scroll release];
    [_sourceLabel release];
    [_pubdateLabel release];
    [_authorLabel release];
    [_titleLabel release];
    [super dealloc];
    
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
       
    }
    return self;
}
-(void)createView
{
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height)];

    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.backgroundColor = [UIColor whiteColor];
    
    
    
    
    _image = [[UIImageView alloc] init];
    _image.frame = CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height * 150 / 480);
    
    
    
    
    self.sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *10, [UIScreen mainScreen].bounds.size.height / 480 *190, [UIScreen mainScreen].bounds.size.width / 320 *300, [UIScreen mainScreen].bounds.size.height / 480 *10)];
    self.sourceLabel.font = [UIFont boldSystemFontOfSize:10];
    self.sourceLabel.textColor = [UIColor grayColor];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *10, _sourceLabel.frame.origin.y + 10 + 5, [UIScreen mainScreen].bounds.size.width / 320 *300, [UIScreen mainScreen].bounds.size.height / 480 *40)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.numberOfLines = 0;
    
    self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *10, _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 5, [UIScreen mainScreen].bounds.size.width / 320 *150, [UIScreen mainScreen].bounds.size.height / 480 *10)];
    self.authorLabel.font = [UIFont boldSystemFontOfSize:10];
    self.authorLabel.textColor = [UIColor grayColor];
    self.pubdateLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *200, _authorLabel.frame.origin.y, [UIScreen mainScreen].bounds.size.width / 320 *110, [UIScreen mainScreen].bounds.size.height / 480 *10)];
    self.pubdateLabel.font = [UIFont boldSystemFontOfSize:10];
    self.pubdateLabel.textColor = [UIColor grayColor];
    self.pubdateLabel.textAlignment = NSTextAlignmentRight ;
    self.XianLabel = [[UILabel alloc] init];
    self.XianLabel.frame = CGRectMake(10, _pubdateLabel.frame.origin.y + 5 + 20, 300, 1);
    self.XianLabel.backgroundColor = [UIColor lightGrayColor];
    

    //        // 按钮边框宽度
    //        label.layer.borderWidth = 1.5;
    //        // 设置圆角
    //        label.layer.cornerRadius = 4.5;
    
    
    

    
    [self.contentView addSubview:_scroll];
    [_scroll addSubview:_webView];
    [_scroll addSubview:_XianLabel];
    [_scroll addSubview:_image];
    [_scroll addSubview:_sourceLabel];
    [_scroll addSubview:_titleLabel];
    [_scroll addSubview:_authorLabel];
    [_scroll addSubview:_pubdateLabel];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 480 * 426, [UIScreen mainScreen].bounds.size.width / 320 *320, [UIScreen mainScreen].bounds.size.height / 480 *30)];
    label.backgroundColor = [UIColor whiteColor];
    label.alpha = 0.8f;
    [self.contentView addSubview:label];
    
    _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"返回副本.png"]] forState:UIControlStateNormal];
    //    button.backgroundColor = [UIColor redColor];
    
    _button1.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *15 , [UIScreen mainScreen].bounds.size.height / 480 *426, [UIScreen mainScreen].bounds.size.width / 320 *30 , [UIScreen mainScreen].bounds.size.height / 480 *30);
//    [button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    
    _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"分享.png"]] forState:UIControlStateNormal];
    
    
    _button2.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *65 , [UIScreen mainScreen].bounds.size.height / 480 *425, [UIScreen mainScreen].bounds.size.width / 320 *30 , [UIScreen mainScreen].bounds.size.height / 480 *30);

    _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button3 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"收藏2.png"]] forState:UIControlStateNormal];
    //    button.backgroundColor = [UIColor redColor];
    
    _button3.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *115 , [UIScreen mainScreen].bounds.size.height / 480 *422, [UIScreen mainScreen].bounds.size.width / 320 *30 , [UIScreen mainScreen].bounds.size.height / 480 *30);
   
    
    
    
    _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button4 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"字体.png"]] forState:UIControlStateNormal];
    
    
    _button4.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *165 , [UIScreen mainScreen].bounds.size.height / 480 *426, [UIScreen mainScreen].bounds.size.width / 320 *30 , [UIScreen mainScreen].bounds.size.height / 480 *30);

    
    _button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button5 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"左.png"]] forState:UIControlStateNormal];
    //    button.backgroundColor = [UIColor redColor];
    
    _button5.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *215 , [UIScreen mainScreen].bounds.size.height / 480 *426, [UIScreen mainScreen].bounds.size.width / 320 *30 , [UIScreen mainScreen].bounds.size.height / 480 *30);
    
    
    _button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button6 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"右.png"]] forState:UIControlStateNormal];
    //    button.backgroundColor = [UIColor redColor];
    
    _button6.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *265, [UIScreen mainScreen].bounds.size.height / 480 *426, [UIScreen mainScreen].bounds.size.width / 320 *30 , [UIScreen mainScreen].bounds.size.height / 480 *30);
    
    
    
    
    [self.contentView addSubview:_button1];
    
    
    [self.contentView addSubview:_button2];
    
    
    [self.contentView addSubview:_button3];
    
    
    [self.contentView addSubview:_button4];
    
    
    [self.contentView addSubview:_button5];
    
    
    [self.contentView addSubview:_button6];
   
    
    
    [_image release];
    [_scroll release];
    [_sourceLabel release];
    [_titleLabel release];
    [_authorLabel release];
    [_pubdateLabel release];
    [_XianLabel release];
    [_webView release];

    
    
    
}


@end
