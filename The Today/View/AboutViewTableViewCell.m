//
//  AboutViewTableViewCell.m
//  IDailyWatch
//
//  Created by   赵东东 on 14/11/1.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "AboutViewTableViewCell.h"

@implementation AboutViewTableViewCell
-(void)dealloc
{
    [_button release];
    [_labelEmail release];
    [_labelMY release];
    [_labelName release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button.frame = CGRectMake(10, 10, 100, 120);
        self.button.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_button];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
