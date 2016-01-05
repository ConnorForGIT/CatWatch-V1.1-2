//
//  Product.h
//  IDailyWatch
//
//  Created by   赵东东 on 14-10-17.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject
@property (nonatomic , retain)NSString *name;
@property (nonatomic , retain)NSString *photo;
@property (nonatomic , retain)NSString *Inphoto;
@property (nonatomic , retain)NSString *Intitle;
@property (nonatomic , retain)NSString *web;

-(id)initWithDictionary:(NSDictionary *)dic;

@end
