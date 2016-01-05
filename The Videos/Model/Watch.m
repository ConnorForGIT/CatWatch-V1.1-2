//
//  Watch.m
//  IDailyWatch
//
//  Created by   赵东东 on 14-10-15.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "Watch.h"

@implementation Watch
- (void)dealloc
{
    [_photo release];
    [_title release];
    [_time release];
    [_Intitle1 release];
    [_Intitle2 release];
    [_Intitle3 release];
    [_Intitle4 release];
    [_Inweb release];
    [_move release];
    [_InPhoto release];
    [super dealloc];
}
-(id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.guid = [dic objectForKey:@"guid"];
        self.photo = [dic objectForKey:@"cover_thumb"];
        self.time = [dic objectForKey:@"pubdate"];
        self.title = [dic objectForKey:@"title"];
        self.Intitle1 = [dic objectForKey:@"source"];
        self.Intitle2 = [dic objectForKey:@"title"];
        self.Intitle3 = [dic objectForKey:@"author"];
        self.Intitle4 = [dic objectForKey:@"pubdate"];
        self.Inweb = [dic objectForKey:@"content"];
        self.move = [dic objectForKey:@"link_video"];
        self.InPhoto = [dic objectForKey:@"cover"];
        
    }
    return self;
}
@end
