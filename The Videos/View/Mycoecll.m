//
//  Mycoecll.m
//  IDailyWatch
//
//  Created by   赵东东 on 14-10-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "Mycoecll.h"

@implementation Mycoecll
- (void)dealloc
{
    [_picture release];
    [_lable1 release];
    [_lable2 release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.picture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 110)];
        [self.contentView addSubview:_picture];
        
        
        self.lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, 150, 35)];
        _lable1.font = [UIFont boldSystemFontOfSize:13];
        _lable1.numberOfLines = 0;
        [self.contentView addSubview:_lable1];
        
        
        self.lable2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 145, 150, 15)];
        _lable2.font = [UIFont boldSystemFontOfSize:10];
        _lable2.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lable2];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
