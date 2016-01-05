//
//  BrandsViewController.m
//  IDailyWatch
//
//  Created by 老师先给我发 on 14-10-13.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "BrandsViewController.h"
#import "Mycell.h"
#import "Product.h"
#import "InBrandsController.h"
#import "UIImageView+WebCache.h"

@interface BrandsViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic , retain)NSMutableArray *arr;
@property (nonatomic , retain)NSMutableArray *arr1;
@property (nonatomic , retain)NSMutableDictionary *dic;

@end

@implementation BrandsViewController
- (void)dealloc
{
    [_pickView release];
    [_arr release];
    [_arr1 release];
    [_dic release];
    [super dealloc];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.arr = [NSMutableArray array];
        self.arr1 = [NSMutableArray array];
    }
    return self;
}
-(void)getDate
{
    
    self.dic = [NSMutableDictionary dictionary];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://watch-cdn.idailywatch.com/api/list/brands/zh-hans?page=1&ver=iphone&app_ver=9" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.arr1 = [NSMutableArray arrayWithArray:responseObject];
        for (int i = 0; i < _arr1.count; i++) {
            Product *model = [[Product alloc]initWithDictionary:[_arr1 objectAtIndex:i]];
            [_arr addObject:model];
            [model release];
        }
        
        [self create];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"尚无网络" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
         [alertView show];
         [alertView release];
     }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)]; //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
    titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
    titleLabel.textAlignment = 1;
    titleLabel.text = @"BRANDS";  //设置标题
    self.navigationItem.titleView = titleLabel;
    [titleLabel release];
    [self getDate];
}
-(void)create
{
    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 568 * 126, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 568 * 486)];
    _pickView.delegate = self;
    //显示选中框
    _pickView.showsSelectionIndicator = YES;
    _pickView.dataSource = self;
    [self.view addSubview:_pickView];
    [_pickView release];
    
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 320 * 40, [UIScreen mainScreen].bounds.size.height / 568 * 56, [UIScreen mainScreen].bounds.size.width / 320 * 240, [UIScreen mainScreen].bounds.size.height / 568 * 30)];
    _nameLabel.backgroundColor = [UIColor lightGrayColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.alpha = 0.6;
    [self.view addSubview:_nameLabel];
    [_nameLabel release];
    
    //创建选中按钮
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 * 120, [UIScreen mainScreen].bounds.size.height / 568 * 390,[UIScreen mainScreen].bounds.size.width / 320 * 80, [UIScreen mainScreen].bounds.size.height / 568 * 40);
    [selectButton setTitle:@"SELECT" forState:UIControlStateNormal];
    selectButton.backgroundColor = [UIColor blackColor];
    [selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectButton];
    
    
}

- (void)selectAction:(id)sender
{
    InBrandsController * vc = [[InBrandsController alloc]init];
    vc.modelArr = _arr;
    vc.count = _nameLabel.tag;
    NSLog(@"%ld", (long)self.nameLabel.tag);
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

#pragma mark ---Picker Date Source Methods---
//返回显示的行数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回当前显示的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _arr.count;
}
#pragma mark ---Picker Delegate Methods---
//设置显示行高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return [UIScreen mainScreen].bounds.size.height / 568 * 70;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _nameLabel.text = [_arr[row] name];
    _nameLabel.tag = row;
}
//图片
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIView *bView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 320 * 200, [UIScreen mainScreen].bounds.size.height / 568 * 70)] autorelease];
    UIImageView * brandImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width / 320 * 200, [UIScreen mainScreen].bounds.size.height / 568 * 70)] autorelease];
    [brandImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [_arr[row] photo]]]placeholderImage:[UIImage imageNamed:@"123.gif"]];
    [bView addSubview:brandImageView];
    if (row == 0) {
        
        _nameLabel.text = [_arr[0] name];
    }else
    {
        _nameLabel.text = @"....";
    }
    
    return bView;
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
