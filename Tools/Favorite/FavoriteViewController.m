//
//  FavoriteViewController.m
//  IDailyWatch
//
//  Created by 18班 班长 on 14-10-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "FavoriteViewController.h"
#import "TwwTableViewCell.h"
#import "UIButton+WebCache.h"
#import "DataBaseManager.h"
#import "FAVContentViewController.h"
#import "ToDayContentViewController.h"

@interface FavoriteViewController ()

@end

@implementation FavoriteViewController
-(void)dealloc
{
    [_modelArr release];
    [_tCell release];
    [_tableView release];
    
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)]; //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
    titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
    titleLabel.textAlignment = 1;
    titleLabel.text = @"FAVORITE";  //设置标题
    self.navigationItem.titleView = titleLabel;
    
    
    self.modelArr = [NSMutableArray array];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回11.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(back)];

    
    
    self.modelArr = [DataBaseManager select];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self createTableView];
}
- (void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.view addSubview:_tableView];
    [_tableView release];
    
}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return UITableViewCellEditingStyleDelete;
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [_tableView setEditing:!_tableView.editing animated:animated];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //判断状态
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 修改数据源
        [DataBaseManager remove:_modelArr[indexPath.row]];
        [_modelArr removeObjectAtIndex:indexPath.row];
        // 修改UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{

    return 140;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"cell";
    
    _tCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!_tCell) {
        _tCell = [[[TwwTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier]autorelease];
    }
    NSURL *url1 = [NSURL URLWithString:[_modelArr[indexPath.row] cover_thumbURL]];
//    [_tCell.button setImageWithURL:url1 forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:nil]];
    [_tCell.button setImageWithURL:url1];
    _tCell.labelTitle.text = [_modelArr[indexPath.row] titleStr];
    _tCell.labelPubdate.text = [_modelArr[indexPath.row] pubdateStr];
    _tCell.labelSummary.text = [_modelArr[indexPath.row] summaryStr];

    return _tCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ToDayContentViewController * vc = [[ToDayContentViewController alloc]init];
    vc.modelArr = self.modelArr;
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
