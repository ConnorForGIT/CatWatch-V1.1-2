//
//  EventsModel.m
//  IDailyWatch
//
//  Created by 申洲 on 14-10-21.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "EventsModel.h"
#import "AFNetworking.h"

@implementation EventsModel
-(void)dealloc
{
    [_title release];
    [_cover_thumbURL release];
    [_pubdate release];
    [_author release];
    [_source release];
    [_link_shareURL release];
    [_summarySTR release];
    [_contentSTR release];
    [_dataModel release];
    [_cover release];
    Block_release(_dataBlock);
    [super dealloc];
    
}

-(void)getDataFromBlock:(MyBlock)block
{
    self.dataBlock = block;
    self.dataModel = [NSMutableArray array];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[NSString stringWithFormat:@"http://watch-cdn.idailywatch.com/api/list/events/zh-hans?page=%d&ver=iphone&app_ver=9", self.page + 1] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        for (NSDictionary * dic in responseObject) {
            EventsModel *model = [[EventsModel alloc] init];
            model.title = [dic objectForKey:@"title"];
            model.cover_thumbURL = [dic objectForKey:@"cover_thumb"];
            model.cover = [dic objectForKey:@"cover"];
            model.pubdate = [dic objectForKey:@"pubdate"];
            model.author = [dic objectForKey:@"author"];
            model.source = [dic objectForKey:@"source"];
            model.summarySTR = [dic objectForKey:@"summary"];
            model.contentSTR = [dic objectForKey:@"content"];
            model.link_shareURL = [dic objectForKey:@"link_share"];
            [_dataModel addObject:model];
        }
        self.dataBlock(_dataModel);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //没网的时候出框框~
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"尚无网络" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
    }];
    
}

@end
