//
//  DataBaseManager.h
//  UI14_DataBase
//
//  Created by 老师先给我发 on 14-10-2.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ModelSource.h"
#import "Model.h"
#import "Product.h"

@interface DataBaseManager : NSObject

+ (void)open;
+ (void)close;
+ (void)create;
+ (void)insert:(ModelSource *)model;
+ (void)insertNews:(Model *)model;

+ (void)remove:(ModelSource *)model;
+ (void)removeNews:(Model *)model;

+ (void)update;
+ (NSMutableArray *)select;


@end
