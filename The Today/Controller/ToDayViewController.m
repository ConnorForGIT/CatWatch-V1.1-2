//
//  ToDayViewController.m
//  iDaily Watch
//
//  Created by 老师先给我发 on 14-10-13.
//  Copyright (c) 2014年 Team 2 All rights reserved.
//

#import "ToDayViewController.h"
#import "UIViewController+RESideMenu.h"
#import "SearchViewController.h"
///
#import "ToDayViewController.h"
#import "ToDayModel.h"
#import "ModelSource.h"
#import "UIImageView+WebCache.h"
#import "SlideImageView.h"
#import "ToDayContentViewController.h"


@interface ToDayViewController ()
@property (nonatomic, retain)UIButton *buttonV;
@property (nonatomic, retain)UIImageView *imageViewW;
@property (nonatomic, retain)UILabel *labelT;
@property (nonatomic, retain)UILabel *labelC;
@property (nonatomic, retain)NSString *str3;
@end

@implementation ToDayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"TODAY";
        self.modelController = [NSMutableArray array];
       
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];

    CGRect rect1 = CGRectMake(15, 10, self.view.frame.size.width - 35, self.view.frame.size.height - 150);
    slideImageView = [[SlideImageView alloc]initWithFrame:rect1 ZMarginValue:5 XMarginValue:10 AngleValue:0.3 Alpha:1000];
    slideImageView.borderColor = [UIColor lightGrayColor];
    slideImageView.delegate = self;
    UITextField *text = [[UITextField alloc]init];
    text.borderStyle = UITextBorderStyleBezel;
    
    
    
    
    UIButton *searchbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    searchbutton.frame = CGRectMake(0, 0, 25, 25);
    [searchbutton setBackgroundImage:[UIImage imageNamed:@"caidan01.png"] forState:UIControlStateNormal];
    [searchbutton addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:searchbutton];
    self.navigationItem.leftBarButtonItem = item;
    
    self.buttonV = [[UIButton  alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [_buttonV addTarget:self action: @selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.buttonV];
    [self.buttonV release];

    self.imageViewW = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    self.imageViewW.image = [UIImage imageNamed:@"search.png"];
    [self.buttonV addSubview:self.imageViewW];
    [self.imageViewW release];
    
    self.labelT = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 60, 20)];
    self.labelT.font = [UIFont fontWithName:@"arial" size:10];
    self.labelT.textColor = [UIColor orangeColor];
//    self.labelT.text = @"获取天气";
        //self.labelT.backgroundColor = [UIColor greenColor];
//    self.labelT.backgroundColor = [UIColor colorWithPatternImage:];
    [self.buttonV addSubview:self.labelT];
    [self.labelT release];
    
    self.labelC = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, 60, 20)];
    self.labelC.font = [UIFont fontWithName:@"arial" size:10];
    self.labelC.textColor = [UIColor orangeColor];
        //self.labelC.backgroundColor = [UIColor blueColor];
    [self.buttonV addSubview:self.labelC];
    [self.labelC release];
    
///
    
    
    dispatch_queue_t globelMainQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globelMainQueue, ^{
        
        ToDayModel * model = [[ToDayModel alloc]init];
        [model getDataFromBlock:^(NSMutableArray *dataSource) {
            for (int i = 0; i < dataSource.count; i++) {
                if ([[dataSource[i] typeStr] isEqualToString:@"1"]) {
                    [dataSource removeObjectAtIndex:i];
                }
                
                
                
                self.modelController = dataSource;

            }
            
            for(int i=0; i < 20; i++)
            {
                [slideImageView addModelSource:self.modelController[i]];
            }
            [slideImageView setImageShadowsWtihDirectionX:2 Y:2 Alpha:0.7];
            [slideImageView reLoadUIview];
        }];
        
    });
    

    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)]; //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
    titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
    titleLabel.textAlignment = 1;
    titleLabel.text = @"TODAY";  //设置标题
    self.navigationItem.titleView = titleLabel;
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *280, 5, [UIScreen mainScreen].bounds.size.width / self.view.frame.size.width *30, [UIScreen mainScreen].bounds.size.height / self.view.frame.size.height *30);
    [btn setImage:[UIImage imageNamed:@"左按钮.png"] forState:UIControlStateNormal];
    
//    [self.navigationController.navigationBar addSubview:btn];
    
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg6.jpg"]]];
    [self.view addSubview:slideImageView];
    [self.view addSubview:clickLabel];
    
    
}
-(void)buttonClicked:(UIButton *)button
{
    SearchViewController *search = [[SearchViewController alloc]init];
    search.block = ^(NSDictionary *dic){
        NSString *str = [dic objectForKey:@"city"];
        NSString *str1 = [dic objectForKey:@"temp1"];
        NSString *str2 = [dic objectForKey:@"temp2"];
        
        NSString *strTaL = [NSString stringWithFormat:@"%@/%@",str2, str1];
        self.str3 = [dic objectForKey:@"weather"];
        
        
        self.labelT.text = strTaL;
        self.labelC.text = str;
        
        NSUInteger len =  [self.str3 length];
       
        NSRange range = NSMakeRange(len - 1, 1);
        
        NSString *zi = [self.str3 substringWithRange:range];
        self.imageViewW.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",zi]];

    };

    
    
    [self.navigationController pushViewController:search animated:YES];
//    self.hidesBottomBarWhenPushed = YES;
//    self.hidesBottomBarWhenPushed = NO;
    [search release];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)SlideImageViewDidClickWithIndex:(int)index
{
    ToDayContentViewController * vc = [[ToDayContentViewController alloc]initWithNibName:nil bundle:nil page:index modelArr:_modelController];
    [vc setHidesBottomBarWhenPushed:YES];
    
    
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
