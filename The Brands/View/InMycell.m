//
//  InMycell.m
//  IDailyWatch
//
//  Created by   赵东东 on 14/10/21.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "InMycell.h"

@implementation InMycell
- (void)dealloc
{
    [_picture release];
    [super dealloc];
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.picture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 155, 55)];
        [self.contentView addSubview:_picture];
    }
    return self;
}
@end
