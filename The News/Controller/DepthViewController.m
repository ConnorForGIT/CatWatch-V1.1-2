//
//  DepthViewController.m
//  IDailyWatch
//
//  Created by 申洲 on 14-10-20.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "DepthViewController.h"
#import "TwwTableViewCell.h"
#import "FeatureModel.h"
#import "MJRefresh.h"
#import "UIButton+WebCache.h"
#import "ContentViewController.h"

@interface DepthViewController ()

@end

@implementation DepthViewController

-(void)dealloc
{
    [_tableView release];
    [_dataSource release];
    Block_release(_model1);
    [super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //初始化数组
        self.dataSource = [NSMutableArray array];
        
        self.model1 = [[FeatureModel alloc]init];
    }
    return self;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.title = @"FEATURE";
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)]; //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
    titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
    titleLabel.textAlignment = 1;
    titleLabel.text = @"FEATURE";  //设置标题
    self.navigationItem.titleView = titleLabel;

    //选择自己喜欢的颜色
    UIColor * color = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回11.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict =[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    FeatureModel *model = [[FeatureModel alloc] init];
    
    [model getDataFromBlock:^(NSMutableArray * data) {
        _dataSource = data;
        //创建视图
        [self createTableView];
        [self setupRefresh];
    }];

}


#pragma mark -
#pragma mark 创建tableView
-(void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 480 *(480 - 64)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView release];
}
#pragma mark -
#pragma mark 数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    return [UIScreen mainScreen].bounds.size.height / 480 *120;
}

//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentViewController *vc = [[ContentViewController alloc] init];
    //    [vc view];

    vc.dataSource = _dataSource;
    vc.i = indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -
#pragma mark 刷新
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
