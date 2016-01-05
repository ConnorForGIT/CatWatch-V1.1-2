//
//  FavoriteViewController.h
//  IDailyWatch
//
//  Created by 18班 班长 on 14-10-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwwTableViewCell.h"
@interface FavoriteViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain) NSMutableArray * modelArr;
@property(nonatomic, retain) TwwTableViewCell * tCell;
@property(nonatomic, retain) UITableView * tableView;
@end
