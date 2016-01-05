//
//  ModelOfNews.h
//  IDailyWatch
//
//  Created by 18班 班长 on 14-10-25.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelOfNews : NSObject

@property (nonatomic, copy) NSString * titleStr;
@property (nonatomic, copy) NSString * cover_thumbURL;
@property (nonatomic, copy) NSString * cover_landscapeURL;
@property (nonatomic, copy) NSString * pubdateStr;
@property (nonatomic, copy) NSString * author;
@property (nonatomic, copy) NSString * source;
@property (nonatomic, copy) NSString * link_shareURL;
@property (nonatomic, copy) NSString * summaryStr;
@property (nonatomic, copy) NSString * contentStr;

+ (ModelOfNews *)modelSourceTitle:(NSString *)titleStr
                   cover_thumbURL:(NSString *)cover_thumbURL
               cover_landscapeURL:(NSString *)cover_landscapeURL
                       pubdateStr:(NSString *)pubdateStr
                           author:(NSString *)author
                           source:(NSString *)source
                    link_shareURL:(NSString *)link_shareURL
                       summaryStr:(NSString *)summaryStr
                       contentStr:(NSString *)contentStr;

@end
