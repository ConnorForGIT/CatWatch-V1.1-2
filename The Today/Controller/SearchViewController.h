//
//  SearchViewController.h
//  iNews
//
//  Created by 东东 on 14-9-13.
//  Copyright (c) 2014年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDayViewController.h"

@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>{
    
    NSMutableArray *searchResults;
    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDisplayController;
    
}

@property (nonatomic, retain)NSMutableArray *dataArray;
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *dataArr;
@property (nonatomic, retain)NSMutableArray *arrCity;
@property (nonatomic, retain)NSString *city;
@property (nonatomic, retain)NSMutableDictionary *dic;


@property (nonatomic, copy)void(^block)(NSDictionary *dic);



@end
