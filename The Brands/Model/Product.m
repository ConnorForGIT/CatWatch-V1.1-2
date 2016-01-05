//
//  Product.m
//  IDailyWatch
//
//  Created by   赵东东 on 14-10-17.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "Product.h"

@implementation Product
- (void)dealloc
{
    [_name release];
    [_photo release];
    [_Inphoto release];
    [_Intitle release];
    [_web release];
    [super dealloc];
}
-(id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.name = [dic objectForKey:@"title"];
        self.photo = [dic objectForKey:@"cover_thumb"];
        self.Inphoto = [dic objectForKey:@"cover_landscape"];
        self.Intitle = [dic objectForKey:@"summary"];
        self.web = [dic objectForKey:@"content"];
    }
    
    
    return self;
    
}
@end
