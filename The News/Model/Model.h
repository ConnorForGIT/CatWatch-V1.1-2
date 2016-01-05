//
//  Model.h
//  IDailyWatch
//
//  Created by 申洲 on 14-10-16.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^MyBlock) (NSMutableArray *);
@interface Model : NSObject
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *cover_thumbURL;
@property (nonatomic, retain) NSString *cover;
@property (nonatomic, retain) NSString *pubdate;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *source;
@property (nonatomic, retain) NSString *link_shareURL;
@property (nonatomic, retain) NSString *summarySTR;
@property (nonatomic, retain) NSString *contentSTR;
@property (nonatomic, retain) NSMutableArray *dataModel;
@property (nonatomic, copy) MyBlock dataBlcok;

@property (nonatomic, assign) NSInteger page;

-(void)getDataFromBlock:(MyBlock)block;
@end
