//
//  ModelOfNews.m
//  IDailyWatch
//
//  Created by 18班 班长 on 14-10-25.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "ModelOfNews.h"

@implementation ModelOfNews

-(void)dealloc
{
    [_titleStr release];
    [_cover_thumbURL release];
    [_cover_landscapeURL release];
    [_pubdateStr release];
    [_author release];
    [_source release];
    [_link_shareURL release];
    [_summaryStr release];
    [_contentStr release];
    
    [super dealloc];
    
}

+ (ModelOfNews *)modelSourceTitle:(NSString *)titleStr
                   cover_thumbURL:(NSString *)cover_thumbURL
               cover_landscapeURL:(NSString *)cover_landscapeURL
                       pubdateStr:(NSString *)pubdateStr
                           author:(NSString *)author
                           source:(NSString *)source
                    link_shareURL:(NSString *)link_shareURL
                       summaryStr:(NSString *)summaryStr
                       contentStr:(NSString *)contentStr
{
    ModelOfNews * model = [[ModelOfNews alloc]init];
    model.titleStr = titleStr;
    model.cover_thumbURL =cover_thumbURL;
    model.cover_landscapeURL = cover_landscapeURL;
    model.pubdateStr = pubdateStr;
    model.author = author;
    model.source = source;
    model.link_shareURL = link_shareURL;
    model.summaryStr = summaryStr;
    model.contentStr = contentStr;
    
    return [model autorelease];
}

@end
