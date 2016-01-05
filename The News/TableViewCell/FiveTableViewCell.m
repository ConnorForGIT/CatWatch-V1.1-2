//
//  FiveTableViewCell.m
//  IDailyWatch
//
//  Created by 申洲 on 14-10-16.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "FiveTableViewCell.h"

@implementation FiveTableViewCell
-(void)dealloc
{
    [_webView release];
    [super dealloc];
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}
-(void)createView
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height / 480 *(480 - 64 - 60))];
    //把WebView锁死
    self.webView.scrollView.scrollEnabled = NO;
//   webView自适应
    _webView.scalesPageToFit = YES;


    _webView.delegate = self;
    [self.contentView addSubview:_webView];
    [_webView release];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    
    NSString * urlString = url.absoluteString;
    

    if ([urlString hasSuffix:@"jpg"]) {
        
        //动画放大
        //根据url网址下载图片
        
        return NO;
    }
    
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView { //webview 自适应高度
    CGRect frame = webView.frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;
//    NSLog(@"%f",webView.frame.size.height);
    //tableView reloadData
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
