//
//  NewsViewController.h
//  IDailyWatch
//
//  Created by 老师先给我发 on 14-10-13.
//  Copyright (c) 2014年 Team 2 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface NewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataSource;
@property (nonatomic, assign) Model * model1;
@property (nonatomic, retain) UIButton *button;
@end
