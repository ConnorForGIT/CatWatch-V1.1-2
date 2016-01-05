//
//  AboutViewController.m
//  IDailyWatch
//
//  Created by   赵东东 on 14/11/1.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "AboutViewController.h"


@interface AboutViewController ()

@end

@implementation AboutViewController
-(void)dealloc
{
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing.png"]];
    self.title = @"关于我们";
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];//修改title字体颜色
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回11.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    for (int i = 0; i < 3; i ++) {
        
        self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button1.frame = CGRectMake(10 + 102* i, 100, 100, 100);
        self.button1.backgroundColor = [UIColor redColor];
        [self.button1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"头像%d.jpg",i+1]] forState:UIControlStateNormal];
        //变圆
        self.button1.clipsToBounds = YES;
        self.button1.layer.cornerRadius = 50;
        
        [self.view addSubview:_button1];
    }
    self.labelName1 = [[UILabel alloc] init];
    self.labelName1.frame = CGRectMake(30 + 105 * 0, 210, 60, 30);
//    self.labelName1.backgroundColor = [UIColor magentaColor];
    self.labelName1.text = @"汲国兴";
    self.labelName1.font = [UIFont boldSystemFontOfSize:14];

    self.labelName1.textColor = [UIColor whiteColor];

    [self.view addSubview:_labelName1];
    self.labelName2 = [[UILabel alloc] init];
    self.labelName2.frame = CGRectMake(30 + 105 * 1, 210, 60, 30);
//    self.labelName2.backgroundColor = [UIColor magentaColor];
    self.labelName2.textColor = [UIColor whiteColor];
     self.labelName2.text = @"赵冬冬";
    [self.view addSubview:_labelName2];
    self.labelName2.font = [UIFont boldSystemFontOfSize:14];

    self.labelName3 = [[UILabel alloc] init];
    self.labelName3.frame = CGRectMake(30 + 108 * 2, 210, 60, 30);
//    self.labelName3.backgroundColor = [UIColor magentaColor];
     self.labelName3.text = @"申洲";
    self.labelName3.textColor = [UIColor whiteColor];
    self.labelName3.font = [UIFont boldSystemFontOfSize:14];

    [self.view addSubview:_labelName3];
    
    self.labelMY1 = [[UILabel alloc] init];
    self.labelMY1.frame = CGRectMake(30, 230, 60, 30);
    //    self.labelName1.backgroundColor = [UIColor magentaColor];
    self.labelMY1.text = @"IOS & PM";
    self.labelMY1.font = [UIFont boldSystemFontOfSize:10];
    self.labelMY1.textColor = [UIColor whiteColor];
    [self.view addSubview:_labelMY1];
    
    self.labelMY2 = [[UILabel alloc] init];
    self.labelMY2.frame = CGRectMake(30 + 105 * 1, 230, 60, 30);
    //    self.labelName2.backgroundColor = [UIColor magentaColor];
    self.labelMY2.font = [UIFont boldSystemFontOfSize:10];
    self.labelMY2.textColor = [UIColor whiteColor];
    self.labelMY2.text = @"IOS & PM";
    [self.view addSubview:_labelMY2];
    
    self.labelMY3 = [[UILabel alloc] init];
    self.labelMY3.frame = CGRectMake(30 + 108 * 2, 230, 60, 30);
    //    self.labelName3.backgroundColor = [UIColor magentaColor];
    self.labelMY3.font = [UIFont boldSystemFontOfSize:10];
    self.labelMY3.text = @"IOS & PM";
    self.labelMY3.textColor = [UIColor whiteColor];
    [self.view addSubview:_labelMY3];
    
    
    
    
    UILabel *aboutUsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 270, 300, 60)];
    aboutUsLabel.textColor = [UIColor whiteColor];
    aboutUsLabel.numberOfLines = 0;
    aboutUsLabel.text = @"    敢于创新，勇于开创，这就是我们，3个自信的年轻人！";
    [self.view addSubview:aboutUsLabel];
    [aboutUsLabel release];

    

}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
