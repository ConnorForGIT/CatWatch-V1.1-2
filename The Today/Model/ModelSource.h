//
//  ModelSource.h
//  IDailyWatch
//
//  Created by 老师先给我发 on 14-10-15.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelOfNews.h"
#import "ModelOfAlbum.h"

@interface ModelSource : NSObject
@property(nonatomic,retain)NSString* videoSum;
@property (nonatomic, retain) NSString * typeStr;
@property (nonatomic, retain) NSString * titleStr;
@property (nonatomic, retain) NSString * cover_thumbURL;
@property (nonatomic, retain) NSString * cover_landscapeURL;
@property (nonatomic, retain) NSString * cover_landscape_568hURL;
@property (nonatomic, retain) NSString * pubdateStr;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSString * link_videoURL;
@property (nonatomic, retain) NSString * link_websiteURL;
@property (nonatomic, retain) NSString * link_shareURL;
@property (nonatomic, retain) NSString * summaryStr;
@property (nonatomic, retain) NSString * contentStr;
@property (nonatomic, retain) NSString * weibo_screen_name;
@property (nonatomic, retain) NSString * weibo_id;
@property (nonatomic, retain) NSString * weibo_postfix;
@property (nonatomic, retain) NSMutableArray * albumModelDataSource;
@property (nonatomic, retain) NSMutableArray * newsModelDataSource;

+ (ModelSource *)modelSourceOtherTitle:(NSString *)titleStr
                        cover_thumbURL:(NSString *)cover_thumbURL
                    cover_landscapeURL:(NSString *)cover_landscapeURL
               cover_landscape_568hURL:(NSString *)cover_landscape_568hURL
                            pubdateStr:(NSString *)pubdateStr
                                author:(NSString *)author
                                source:(NSString *)source
                         link_videoURL:(NSString *)link_videoURL
                       link_websiteURL:(NSString *)link_websiteURL
                         link_shareURL:(NSString *)link_shareURL
                            summaryStr:(NSString *)summaryStr
                            contentStr:(NSString *)contentStr
                     weibo_screen_name:(NSString *)weibo_screen_name
                              weibo_id:(NSString *)weibo_id
                         weibo_postfix:(NSString *)weibo_postfix
                                  typestr:(NSString *)typestr
                              videoSum:(NSString*)videoSum
                            albumModelDataSource:( NSMutableArray *)albumModelDataSource
                             newsModelDataSource:( NSMutableArray *)newsModelDataSource;

@end
