//
//  ActivityViewController.h
//  IDailyWatch
//
//  Created by 申洲 on 14-10-20.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsModel.h"

@interface ActivityViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataSource;
@property (nonatomic, assign) EventsModel *model1;
@end
