//
//  Watch.h
//  IDailyWatch
//
//  Created by   赵东东 on 14-10-15.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Watch : NSObject
@property (nonatomic, copy) NSString * guid;
@property (nonatomic , retain)NSString *photo;
@property (nonatomic , retain)NSString *title;
@property (nonatomic , retain)NSString *time;
@property (nonatomic , retain)NSString *Intitle1;
@property (nonatomic , retain)NSString *Intitle2;
@property (nonatomic , retain)NSString *Intitle3;
@property (nonatomic , retain)NSString *Intitle4;
@property  (nonatomic, retain)NSString *Inweb;
@property (nonatomic , retain)NSString *move;
@property (nonatomic , retain)NSString *InPhoto;



-(id)initWithDictionary:(NSDictionary *)dic;

@end
