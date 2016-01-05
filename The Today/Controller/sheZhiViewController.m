//
//  sheZhiViewController.m
//  IDailyWatch
//
//  Created by   赵东东 on 14/10/31.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "sheZhiViewController.h"
#import "FeedBackViewController.h"

@interface sheZhiViewController ()

@end

@implementation sheZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
     [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];//修改title字体颜色

    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];

    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回11.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
    
    
    
    
    
    // 图标
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, self.view.frame.size.height / 6, 80, 80)];
    iconImageView.image = [UIImage imageNamed:@"LOG3.png"];
    iconImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:iconImageView];
    [iconImageView release];
    
    UILabel *banbenLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, iconImageView.frame.size.height + iconImageView.frame.origin.y + 50, 280, self.view.frame.size.height * 30 / 480)];
    banbenLabel.text = @"  当前版本";
    banbenLabel.font = [UIFont fontWithName:@"arial" size:12];
    banbenLabel.layer.borderWidth = 0.5;
    banbenLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:banbenLabel];
    [banbenLabel release];
    
    UILabel *banbennumber = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 30, self.view.frame.size.height * 30 / 480)];
    banbennumber.text = @"1.0";
    banbennumber.font = [UIFont fontWithName:@"arial" size:12];
    banbennumber.textColor = [UIColor lightGrayColor];
    [banbenLabel addSubview:banbennumber];
    
    
    UILabel *xinbanLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, banbenLabel.frame.size.height + banbenLabel.frame.origin.y + 3, 280, self.view.frame.size.height * 30 / 480)];
    xinbanLabel.text = @"  新版更新";
    xinbanLabel.font = [UIFont fontWithName:@"arial" size:12];
    xinbanLabel.layer.borderWidth = 0.5;
    xinbanLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:xinbanLabel];
    [xinbanLabel release];
    
    UILabel *xinbannumber = [[UILabel alloc] initWithFrame:CGRectMake(240, 0, 40, self.view.frame.size.height * 30 / 480)];
    xinbannumber.text = @"无新版";
    xinbannumber.font = [UIFont fontWithName:@"arial" size:12];
    xinbannumber.textColor = [UIColor lightGrayColor];
    [xinbanLabel addSubview:xinbannumber];
    
    
    
    UIButton *messageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    messageButton.frame = CGRectMake(20, banbenLabel.frame.size.height + banbenLabel.frame.origin.y  + 42, 280, self.view.frame.size.height * 30 / 480);
    [messageButton setTitle:@"与我们联系                                                          > " forState:UIControlStateNormal];
    messageButton.tintColor = [UIColor blackColor];
    messageButton.titleLabel.font = [UIFont fontWithName:@"arial" size:12];
    messageButton.layer.borderWidth = 0.5;
    messageButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [messageButton addTarget:self action:@selector(showPicker:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:messageButton];
    
    
    
    
    
    
    
    
    

    

}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)showPicker:(UIButton *)button
{
    FeedBackViewController *vc = [[FeedBackViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
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
