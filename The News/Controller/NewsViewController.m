//
//  NewsViewController.m
//  IDailyWatch
//
//  Created by 老师先给我发 on 14-10-13.
//  Copyright (c) 2014年 Team 2 All rights reserved.
//

#import "NewsViewController.h"
#import "OneTableViewCell.h"
#import "TwwTableViewCell.h"
#import "ContentViewController.h"
#import "Model.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "CHTumblrMenuView.h"
#import "MJRefresh.h"

#import "NewViewController.h"
#import "ColumnViewController.h"
#import "ViewpointViewController.h"
#import "DepthViewController.h"
#import "ActivityViewController.h"


@interface NewsViewController ()
@property(nonatomic, assign)NSInteger tagg;

@end

@implementation NewsViewController
-(void)dealloc
{
    [_tableView release];
    [_button release];
    [_dataSource release];
    Block_release(_model1);
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataSource = [NSMutableArray array];
        self.model1 = [[Model alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    //navigation 换颜色
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    //右按钮
    _button = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 320 * 280, 10, 25, [UIScreen mainScreen].bounds.size.height / 480 * 20)];
    [_button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"11.png"]] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(rootButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_button];
    [_button release];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)]; //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
    titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
    titleLabel.textAlignment = 1;
    titleLabel.text = @"NEWS";  //设置标题
    self.navigationItem.titleView = titleLabel;
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(rootButtonAction)];
//    [self.navigationItem setLeftBarButtonItem:leftButton];
//    
//    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(rootButtonAction)];
//    self.navigationItem.rightBarButtonItem = item1;
//    [item1 release];
    //类的初始化
     Model *model = [[Model alloc] init];
    [model getDataFromBlock:^(NSMutableArray * data) {
        _dataSource = data;

        //创建TableView
        [self createTableView];
        [self setupRefresh];
    }];
    
}
#pragma mark - 
#pragma tableView效果

//- (void)tableView:(UITableView *)tableView willDisplayCell:(TwoTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    cell.frame = CGRectMake(-320, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
//        
//    }];
//    
//}
#pragma mark - 
#pragma mark 右按钮出现和小时
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.hidden = YES;
//    
//}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewWillAppear:(BOOL)animated
{
//    [super vie:animated];
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - 
#pragma mark 选项栏
- (void)rootButtonAction
{
    CHTumblrMenuView *menuView = [[CHTumblrMenuView alloc] init];
    
    [menuView addMenuItemWithTitle:@"全部" andIcon:[UIImage imageNamed:@"返回.png"] andSelectedBlock:^{
        
    }];
    
    
    [menuView addMenuItemWithTitle:@"新闻" andIcon:[UIImage imageNamed:@"新闻.png"] andSelectedBlock:^{
        NewViewController *vc = [[NewViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }];
    [menuView addMenuItemWithTitle:@"专栏" andIcon:[UIImage imageNamed:@"专栏.png"] andSelectedBlock:^{
        ColumnViewController *vc = [[ColumnViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }];
    [menuView addMenuItemWithTitle:@"观点" andIcon:[UIImage imageNamed:@"观点.png"] andSelectedBlock:^{
        ViewpointViewController *vc = [[ViewpointViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
        
    }];
    [menuView addMenuItemWithTitle:@"深度" andIcon:[UIImage imageNamed:@"深度.png"] andSelectedBlock:^{
        DepthViewController *vc = [[DepthViewController alloc] init];
        [self.navigationController pushViewController:vc  animated:YES];
        [vc release];
        
    }];
    [menuView addMenuItemWithTitle:@"活动" andIcon:[UIImage imageNamed:@"活动.png"] andSelectedBlock:^{
        ActivityViewController *vc = [[ActivityViewController alloc] init];
        [self.navigationController pushViewController:vc  animated:YES];
        [vc release];
        
    }];
    
    
    
    [menuView show];
}

#pragma mark -
#pragma mark 创建TableView
-(void)createTableView
{
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 480 *(480 - 64)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
   
    [self.view addSubview:_tableView];
}
#pragma mark -
#pragma mark 数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        OneTableViewCell *cell = [[OneTableViewCell alloc] init];
        cell.selectionStyle = NO;
        NSURL *url1 = [NSURL URLWithString:[_dataSource[0] cover]];
        
        [cell.button setImageWithURL:url1 placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"加载.PNG"]]];

        cell.lable.text = [_dataSource[0] title];
        cell.lable.textColor = [UIColor whiteColor];
                       
        return cell;
    }
    TwwTableViewCell *cell = [[TwwTableViewCell alloc] init];
    NSURL *url1 = [NSURL URLWithString:[_dataSource[indexPath.row] cover_thumbURL]];
    [cell.button setImageWithURL:url1 placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"加载.PNG"]]];
    cell.labelTitle.text = [_dataSource[indexPath.row] title];
    cell.labelPubdate.text = [_dataSource[indexPath.row] pubdate];
    cell.labelSummary.text = [_dataSource[indexPath.row] summarySTR];
    
    
    cell.selectionStyle = NO;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [UIScreen mainScreen].bounds.size.height / 480 *160;
    }
    return [UIScreen mainScreen].bounds.size.height / 480 *120;
}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentViewController *vc = [[ContentViewController alloc] init];
//    [vc view];

    vc.dataSource = _dataSource;

    
    vc.i = indexPath.row;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

//#pragma mark -
//#pragma mark 刷新
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    [self.tableView footerEndRefreshing];
    

}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
    
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}
- (void)footerRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        
        
        self.model1.page++;

        [self.model1 getDataFromBlock:^(NSMutableArray * data) {
            for (id modelData in data) {
                [_dataSource addObject:modelData];
            }
            
            [self.tableView reloadData];
        }];
     
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
    
    
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
