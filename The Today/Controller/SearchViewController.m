//
//  SearchViewController.m
//  iNews
//
//  Created by 东东 on 14-9-13.
//  Copyright (c) 2014年 test. All rights reserved.
//

#import "SearchViewController.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "ToDayViewController.h"

@interface SearchViewController ()
@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.dataArray = [NSMutableArray array];
        self.dataArr = [NSMutableArray array];
        self.arrCity = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回11.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    self.title = @"城市天气";
    //创建UISearchBar
    mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    mySearchBar.delegate = self;
    [mySearchBar setPlaceholder:@"搜索列表"];
    
   //创建UISearchDisplayController
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    
    //创建UITableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 40) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
	self.tableView.tableHeaderView = mySearchBar;
    
    [self.view addSubview:_tableView];
    
    //获取本地城市
    NSString *pathCity = [[NSBundle mainBundle]pathForResource:@"Country" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:pathCity];
    
    self.arrCity = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    for (NSMutableDictionary *dic in _arrCity) {
        
        [self.dataArray addObject:[[dic allValues] objectAtIndex:0]];
        [self.dataArr addObject:[[dic allKeys] objectAtIndex:0]];
    }
    
    [_dataArr mutableCopy];//字符串城市数组
    [_dataArray mutableCopy];//汉字城市数组


}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//tableView 行数 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return searchResults.count; // 搜索获得数组
    }
    else {
        return _dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = searchResults[indexPath.row];
    }
    else {
        cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    }
    return cell;
}
// 点击方法 获取 天气
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // 两种情况 搜索出的searchResultsTableView
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSString *city = searchResults[indexPath.row];
        for (int i = 0; i < _dataArray.count; i++) {
            // 本地城市名字数组 和 天气网站拼接
            if ([city isEqualToString:[_dataArray objectAtIndex:i]]) {
                NSString *str = [NSString stringWithFormat:@"http://www.weather.com.cn/data/cityinfo/%@.html", [_dataArr objectAtIndex:i]];
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                
                [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    self.block([responseObject objectForKey:@"weatherinfo"]);
                    
                }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     }];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            
        }
        

        
    }else{
        // 本地城市数组数组 和 天气网站拼接

        
    NSString *str = [NSString stringWithFormat:@"http://www.weather.com.cn/data/cityinfo/%@.html", self.dataArr[indexPath.row]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        

        
        [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            self.block([responseObject objectForKey:@"weatherinfo"]);
            
        }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             }];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma UISearchDisplayDelegate
//搜素 

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    int a = 0;
    
    searchResults = [[NSMutableArray alloc]init];

    if (mySearchBar.text.length>0&&![ChineseInclude isIncludeChineseInString:mySearchBar.text]) {
        
        for (int i=0; i<_dataArray.count; i++) {
            
            if ([ChineseInclude isIncludeChineseInString:_dataArray[i]]) {
                
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:_dataArray[i]];
                NSRange titleResult=[tempPinYinStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [searchResults addObject:_dataArray[i]];
                    a++;
                }
                
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:_dataArray[i]];
                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleHeadResult.length>0) {
                    if (a == 0) {
                        [searchResults addObject:_dataArray[i]];
                    }
                }
            }
            else {
                NSRange titleResult=[_dataArray[i] rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [searchResults addObject:_dataArray[i]];
                }
            }
        }
    } else if (mySearchBar.text.length>0&&[ChineseInclude isIncludeChineseInString:mySearchBar.text]) {
        for (NSString *tempStr in _dataArray) {
            NSRange titleResult=[tempStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                [searchResults addObject:tempStr];
            }
        }
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.frame = CGRectMake(-320, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height );
    [UIView animateWithDuration:0.7 animations:^{
        cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    } completion:^(BOOL finished) {
        ;
    }];
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
