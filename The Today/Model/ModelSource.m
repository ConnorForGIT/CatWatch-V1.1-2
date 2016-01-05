//
//  ModelSource.m
//  IDailyWatch
//
//  Created by 老师先给我发 on 14-10-15.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "ModelSource.h"

@implementation ModelSource
-(void)dealloc
{
    [_titleStr release];
    [_cover_thumbURL release];
    [_cover_landscapeURL release];
    [_cover_landscape_568hURL release];
    [_pubdateStr release];
    [_author release];
    [_source release];
    [_link_videoURL release];
    [_link_websiteURL release];
    [_link_shareURL release];
    [_summaryStr release];
    [_contentStr release];
    [_weibo_screen_name release];
    [_weibo_id release];
    [_weibo_postfix release];
    [_albumModelDataSource release];
    [_newsModelDataSource release];

    [super dealloc];
}
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
                   newsModelDataSource:( NSMutableArray *)newsModelDataSource
{
    ModelSource * model = [[ModelSource alloc]init];
    model.titleStr = titleStr;
    model.cover_thumbURL =cover_thumbURL;
    model.cover_landscapeURL = cover_landscapeURL;
    model.cover_landscape_568hURL = cover_landscape_568hURL;
    model.pubdateStr = pubdateStr;
    model.author = author;
    model.source = source;
    model.link_videoURL = link_videoURL;
    model.link_websiteURL = link_websiteURL;
    model.link_shareURL = link_shareURL;
    model.summaryStr = summaryStr;
    model.contentStr = contentStr;
    model.weibo_id = weibo_id;
    model.weibo_screen_name = weibo_screen_name;
    model.weibo_postfix = weibo_postfix;
    model.typeStr = typestr;
    model.videoSum = videoSum;
    model.albumModelDataSource = [NSMutableArray arrayWithArray:albumModelDataSource];
    model.newsModelDataSource = [NSMutableArray arrayWithArray:newsModelDataSource];
    
    return [model autorelease];
}

@end
