//
//  ToDayModel.m
//  IDailyWatch
//
//  Created by 18班 班长 on 14-10-25.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "ToDayModel.h"
#import "ModelSource.h"
#import "AFNetworking.h"
#import "ModelOfAlbum.h"
#import "ModelOfNews.h"


@implementation ToDayModel

-(void)dealloc
{
    [_dataModel release];
    Block_release(_dataBlock);
    
    [super dealloc];
}


- (void)getDataFromBlock:(MyBlock)block
{
    
    self.dataModel = [NSMutableArray array];
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger GET:[NSString stringWithFormat:@"http://watch-cdn.idailywatch.com/api/list/cover/zh-hans?page=1&ver=iphone&app_ver=9"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary * dic in responseObject) {
            NSMutableArray * albumDataSource = [NSMutableArray array] ;
            NSMutableArray * newsDataSource = [NSMutableArray array];
            for (NSDictionary * dicAlbum in [dic objectForKey:@"album"]) {
                ModelOfAlbum  *   modelAlbum = [ModelOfAlbum modelSourceTitle:[dicAlbum objectForKey:@"title"] cover_thumbURL:[dicAlbum objectForKey:@"cover_thumb"] cover_landscapeURL:[dicAlbum objectForKey:@"cover_landscape"] pubdateStr:[dicAlbum objectForKey:@"pubdate"] link_shareURL:[dicAlbum objectForKey:@"link_share"] contentStr:[dicAlbum objectForKey:@"content"]];
                [albumDataSource addObject:modelAlbum];
            }
            
            for (NSDictionary * dicNews in [dic objectForKey:@"news"]) {
                ModelOfNews  *  modelOfNews = [ModelOfNews modelSourceTitle:[dicNews objectForKey:@"title"] cover_thumbURL:[dicNews objectForKey:@"cover_thumb"] cover_landscapeURL:[dicNews objectForKey:@"cover_landscape"] pubdateStr:[dicNews objectForKey:@"pubdate"] author:[dicNews objectForKey:@"author"] source:[dicNews objectForKey:@"source"] link_shareURL:[dicNews objectForKey:@"link_share"] summaryStr:[dicNews objectForKey:@"summary"] contentStr:[dicNews objectForKey:@"content"]];
                [newsDataSource addObject:modelOfNews];
            }
            
            ModelSource * model = [ModelSource modelSourceOtherTitle:[dic objectForKey:@"title"] cover_thumbURL:[dic objectForKey:@"cover_thumb"] cover_landscapeURL:[dic objectForKey:@"cover_landscape"] cover_landscape_568hURL:[dic objectForKey:@"cover_landscape_568h"] pubdateStr:[dic objectForKey:@"pubdate"] author:[dic objectForKey:@"author"] source:[dic objectForKey:@"source"] link_videoURL:[dic objectForKey:@"link_video"] link_websiteURL:[dic objectForKey:@"link_wechat"] link_shareURL:[dic objectForKey:@"link_share"] summaryStr:[dic objectForKey:@"summary"] contentStr:[dic objectForKey:@"content"] weibo_screen_name:[dic objectForKey:@"weibo_screen_name"] weibo_id:[dic objectForKey:@"weibo_id"] weibo_postfix:[dic objectForKey:@"weibo_postfix"] typestr:[[dic objectForKey:@"type"] stringValue] videoSum:[dic objectForKey:@"has_video"]  albumModelDataSource:albumDataSource newsModelDataSource:newsDataSource];
            [_dataModel addObject:model];
            
        }        self. dataBlock = block;
        self.dataBlock(_dataModel);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"尚无网络" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertView show];
        [alertView release];

    }];
    
}

@end
