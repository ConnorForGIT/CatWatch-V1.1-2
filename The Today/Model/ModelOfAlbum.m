//
//  ModelOfAlbum.m
//  IDailyWatch
//
//  Created by 18班 班长 on 14-10-25.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "ModelOfAlbum.h"

@implementation ModelOfAlbum

-(void)dealloc
{
    [_titleStr release];
    [_cover_thumbURL release];
    [_cover_landscapeURL release];
    [_pubdateStr release];
    [_link_shareURL release];
    [_contentStr release];
    
    [super dealloc];
    
}
+ (ModelOfAlbum *)modelSourceTitle:(NSString *)titleStr
                    cover_thumbURL:(NSString *)cover_thumbURL
                cover_landscapeURL:(NSString *)cover_landscapeURL
                        pubdateStr:(NSString *)pubdateStr
                     link_shareURL:(NSString *)link_shareURL
                        contentStr:(NSString *)contentStr
{
    ModelOfAlbum * model = [[ModelOfAlbum alloc]init];
    model.titleStr = titleStr;
    model.cover_thumbURL =cover_thumbURL;
    model.cover_landscapeURL = cover_landscapeURL;
    model.pubdateStr = pubdateStr;
    model.link_shareURL = link_shareURL;
    model.contentStr = contentStr;
    
    return [model autorelease];
}

@end
