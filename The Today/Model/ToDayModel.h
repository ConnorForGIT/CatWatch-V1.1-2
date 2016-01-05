//
//  ToDayModel.h
//  IDailyWatch
//
//  Created by 18班 班长 on 14-10-25.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MyBlock) (NSMutableArray *dataSource);
@interface ToDayModel : NSObject

@property(nonatomic, retain) NSMutableArray * dataModel;
@property(nonatomic, copy)MyBlock dataBlock;
@property(nonatomic, retain) NSMutableArray *modelArr;

- (void)getDataFromBlock:(MyBlock)block;

@end
