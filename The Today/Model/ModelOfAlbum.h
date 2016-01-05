//
//  ModelOfAlbum.h
//  IDailyWatch
//
//  Created by 18班 班长 on 14-10-25.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelOfAlbum : NSObject

@property (nonatomic, copy) NSString * titleStr;
@property (nonatomic, copy) NSString * cover_thumbURL;
@property (nonatomic, copy) NSString * cover_landscapeURL;
@property (nonatomic, copy) NSString * pubdateStr;
@property (nonatomic, copy) NSString * link_shareURL;
@property (nonatomic, copy) NSString * contentStr;

+ (ModelOfAlbum *)modelSourceTitle:(NSString *)titleStr
                    cover_thumbURL:(NSString *)cover_thumbURL
                cover_landscapeURL:(NSString *)cover_landscapeURL
                        pubdateStr:(NSString *)pubdateStr
                     link_shareURL:(NSString *)link_shareURL
                        contentStr:(NSString *)contentStr;

@end
