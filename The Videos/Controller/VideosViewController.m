//
//  VideosViewController.m
//  IDailyWatch
//
//  Created by 老师先给我发 on 14-10-13.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "VideosViewController.h"
#import "VideosInController.h"
#import "Mycoecll.h"
#import "UIImageView+WebCache.h"
#import "Watch.h"


@interface VideosViewController ()
@property (nonatomic , retain)UICollectionView *collectionVeiw;
@property (nonatomic , retain)NSMutableArray *arr;
@property (nonatomic , retain)NSMutableArray *arr1;
@property (nonatomic , retain)NSMutableDictionary * one;
@property (nonatomic , retain)UIImageView *imgeView;
@property (nonatomic, assign)NSInteger resCount;
@property (nonatomic , retain)UIImageView *voide;
@property (nonatomic , retain)UITapGestureRecognizer *tap;
@end

@implementation VideosViewController
-(void)dealloc
{
    [_arr release];
    [_arr1 release];
    [_one release];
    [_imgeView release];
    [_voide release];
    [_tap release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.resCount = 1;

        // Custom initialization
        self.arr = [NSMutableArray array];
        self.arr1 = [NSMutableArray array];
        self.one = [NSMutableDictionary dictionary];
            }
    return self;
}
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.collectionVeiw addHeaderWithTarget:self action:@selector(headerRereshing)];
    
#pragma mark 自动刷新(一进入程序就下拉刷新)
    
    [self.collectionVeiw headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.collectionVeiw addFooterWithTarget:self action:@selector(footerRereshing)];
    
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 刷新表格
        [self.collectionVeiw reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.collectionVeiw headerEndRefreshing];
    });
}
- (void)footerRereshing
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (2 == self.resCount) {
        [self.collectionVeiw footerEndRefreshing];
    }
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.collectionVeiw reloadData];
        
        NSString *strURL = [NSString stringWithFormat:@"http://watch-cdn.idailywatch.com/api/list/video/zh-hans?page=%ld&ver=iphone&app_ver=9", (long)self.resCount];
        
        [manager GET:strURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSMutableArray *arry  = [NSMutableArray arrayWithArray:responseObject];
            for (int i = 0; i < arry.count; i++) {
                
                Watch *wat = [[Watch alloc] initWithDictionary:[arry objectAtIndex:i]];
                [self.arr addObject:wat];
            
            }
            [_arr removeLastObject];
            
            [_collectionVeiw reloadData];

            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.collectionVeiw footerEndRefreshing];
    });
    self.resCount++;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getDate];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];

    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)]; //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
    titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
    titleLabel.textAlignment = 1;
    titleLabel.text = @"VIDEOS";  //设置标题
    self.navigationItem.titleView = titleLabel;

}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getDate
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://watch-cdn.idailywatch.com/api/list/video/zh-hans?page=1&ver=iphone&app_ver=9" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.arr1 = [NSMutableArray arrayWithArray:responseObject];
        self.one = [_arr1 firstObject];
        for (int i = 1; i < _arr1.count; i++) {
            
            Watch *wat = [[Watch alloc] initWithDictionary:[_arr1 objectAtIndex:i]];
            [_arr addObject:wat];
        }
        
        [_arr removeLastObject];
        
        [_collectionVeiw reloadData];
        if (_arr.count != 0) {
            [self createCollectionView];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"尚无网络" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertView show];
        [alertView release];

    }];



    
}
- (void)createCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width) / 2 - 10,160);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 5 ;
    layout.minimumLineSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(155, 5, 5, 5);
    
    self.collectionVeiw = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width  , [UIScreen mainScreen].bounds.size.height - 64 - 49) collectionViewLayout:layout];
    _collectionVeiw.delegate = self;
    _collectionVeiw.dataSource = self;
    [self.view addSubview:_collectionVeiw];
    _collectionVeiw.backgroundColor = [UIColor whiteColor];
    [_collectionVeiw release];
    [_collectionVeiw registerClass:[Mycoecll class] forCellWithReuseIdentifier:@"11"];
    
    
    
    self.imgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    [_imgeView setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    NSString * pas = [_one objectForKey:@"cover"];
    [_imgeView setImageWithURL:[NSURL URLWithString:pas]];
    [self.collectionVeiw addSubview:_imgeView];
    [_imgeView  release];
    
    self.voide = [[UIImageView alloc] initWithFrame:CGRectMake(138, 70, 45, 45)];
    _voide.alpha = 0.7;
    _voide.image = [UIImage imageNamed:@"play.png"];
    [_imgeView addSubview:_voide];
    
    [_imgeView setUserInteractionEnabled:YES];
    
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_imgeView addGestureRecognizer:_tap];
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 130, 320, 20)];
    title.backgroundColor = [UIColor blackColor];
    title.alpha = 0.6;
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont boldSystemFontOfSize:13];
    title.text = [_one objectForKey:@"title"];
    [self.imgeView addSubview:title];
    [title release];
    [self setupRefresh];

    
}
-(void)tap:(UITapGestureRecognizer *)tap
{
    NSString *str =  [[[_one objectForKey:@"link_video"] componentsSeparatedByString:@"#"] firstObject];

    MPMoviePlayerViewController *movie  = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:str]];
    [self presentMoviePlayerViewControllerAnimated:movie];
    [movie release];
}
//协议方法
- (void)pushViewController:(UIViewController *)viewController
{
    [self.navigationController pushViewController:viewController animated:YES];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arr.count -1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Mycoecll *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"11" forIndexPath:indexPath];
    Watch *model =[_arr objectAtIndex:indexPath.row];
    [cell.picture setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"加载.PNG"]];
    cell.lable1.text = model.title;
    cell.lable2.text = model.time;
    
    return cell ;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    VideosInController *vc = [[VideosInController alloc] init];
    
    vc.arrModel = self.arr;
    vc.model = _arr[indexPath.row];
    vc.i = indexPath.item;
    [vc setHidesBottomBarWhenPushed:YES];
   [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}
//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    self.tabBarController.tabBar.hidden = YES;
//    
//}
//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    self.tabBarController.tabBar.hidden = NO;
//}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
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
