//
//  ImageViewController.m
//  Daily Watch
//
//  Created by 陈东旭 on 14-10-23.
//  Copyright (c) 2014年 安静的美男子. All rights reserved.
//

#import "ImageViewController.h"
#import "SDImageCache.h"
#import "TodayViewController.h"
#import "ModelOfAlbum.h"
#import "ModelSource.h"
#import "ModelOfNews.h"
#import "UIImageView+WebCache.h"

@interface ImageViewController ()

@end

@implementation ImageViewController
- (void)dealloc
{
    [_headView release];
    [_backScrollView release];
    [_imageDataSource release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self createHeadView];
    [self createBsckScrollView];
//    self.view.backgroundColor = [UIColor blackColor];
}
-(void)createHeadView
{
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    [_headView setBackgroundColor:[UIColor blackColor]];
    [_headView setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:0.6]];
    [self.view addSubview:_headView];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, 0, self.view.frame.size.width/2, 44)];
    [imageView setImage:[UIImage imageNamed:@"TitleLogo@2x~iphone.png"]];
    [_headView addSubview:imageView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(5, 0, 60, 44);
    [button setImage:[UIImage imageNamed:@"ButtonEntryToolCloseHighlighted@2x~iphone.png"] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"ButtonEntryToolCloseHighlighted@3x~iphone.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:button];
    [imageView release];

    UIView * aView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    aView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:aView];
    [aView release];
    
    
}

#pragma mark-
#pragma mark 返回按钮
-(void)buttonAction:(UIButton * )button
{

    [self dismissViewControllerAnimated:NO completion:nil];

}



#pragma mark-
#pragma mark 创建backScrollView
-(void)createBsckScrollView
{


    _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,(self.view.frame.size.height-self.view.frame.size.width)/2 - 75 , self.view.frame.size.width,  self.view.frame.size.width+100)];
    _backScrollView.contentSize = CGSizeMake(self.view.frame.size.width*self.imageDataSource.count, 0);
    [_backScrollView setPagingEnabled:YES];
    [_backScrollView setBounces:NO];
    [_backScrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width*(self.start +1), _backScrollView.frame.origin.y, _backScrollView.bounds.size.width, _backScrollView.bounds.size.height) animated:YES];
    [_backScrollView setShowsHorizontalScrollIndicator:NO];
    for (int i = 0; i < _imageDataSource.count; i++) {
        UIImageView * imageView= [[UIImageView alloc]initWithFrame:CGRectMake(self.backScrollView.bounds.size.width*i, 0, self.backScrollView.bounds.size.width, self.backScrollView.bounds.size.height)];
        [ imageView setImageWithURL:[NSURL URLWithString:[ _imageDataSource[i] cover_landscapeURL]]];
        [_backScrollView addSubview:imageView];
        [imageView release];
    }
    
    [self.view addSubview:_backScrollView];
    
    [_backScrollView setContentOffset:CGPointMake((self.start-1) * self.view.frame.size.width, 0)];
    





}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
