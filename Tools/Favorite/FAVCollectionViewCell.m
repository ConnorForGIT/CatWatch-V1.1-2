//
//  FAVCollectionViewCell.m
//  IDailyWatch
//
//  Created by 18班 班长 on 14-10-28.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "FAVCollectionViewCell.h"

@implementation FAVCollectionViewCell

-(void)dealloc
{
    [_labelAuthor release];
    [_labelDate release];
    [_labelSource release];
    [_labelTitle release];
    [_scroll release];
    
    
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.labelSource = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
        self.labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.labelSource.frame.origin.x, self.labelSource.frame.size.height + self.labelSource.frame.origin.y + 5, self.labelSource.frame.size.width, self.labelSource.frame.size.height)];
        self.labelAuthor = [[UILabel alloc]initWithFrame:CGRectMake(self.labelTitle.frame.origin.x, self.labelTitle.frame.size.height + self.labelTitle.frame.origin.y + 5, self.labelTitle.frame.size.width / 2, self.labelTitle.frame.size.height)];
        self.labelDate = [[UILabel alloc]initWithFrame:CGRectMake(self.labelAuthor.frame.origin.x + self.labelAuthor.frame.size.width + 5, self.labelAuthor.frame.origin.y, self.labelAuthor.frame.size.width - 5, self.labelAuthor.frame.size.height)];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(_labelAuthor.frame.origin.x, _labelAuthor.frame.origin.y + _labelAuthor.frame.size.height + 10, 300, 1);
        btn.backgroundColor = [UIColor lightGrayColor];
        [self.scroll addSubview:btn];
        
        
        [self.scroll addSubview:self.labelSource];
        [self.scroll addSubview:self.labelTitle];
        [self.scroll addSubview:self.labelAuthor];
        [self.scroll addSubview:self.labelDate];
        
        [self addSubview:_scroll];
        [_scroll release];
        [_labelAuthor release];
        [_labelDate release];
        [_labelSource release];
        [_labelTitle release];
        
    }
    return self;
}

@end
