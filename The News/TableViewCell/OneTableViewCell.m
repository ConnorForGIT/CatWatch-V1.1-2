//
//  OneTableViewCell.m
//  IDailyWatch
//
//  Created by 申洲 on 14-10-15.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "OneTableViewCell.h"

@implementation OneTableViewCell
-(void)dealloc
{
    [_button release];
    [_lable release];
    [super dealloc];
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createView];
    }
    return self;
}
-(void)createView
{
   
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 480 *160);
    //取消button的点击事件
    self.button.userInteractionEnabled = NO;
    [self.contentView addSubview:_button];
    
    self.lable = [[UILabel alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 480 *130, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 480 *30)];
    
    UIColor *aColor = [UIColor colorWithWhite:0.1 alpha:0.6];
    //改label上的字体大小!
    self.lable.font = [UIFont boldSystemFontOfSize:13];
    //label上的字体居中
    self.lable.textAlignment = NSTextAlignmentCenter;
    self.lable.backgroundColor = aColor;
    [self.contentView addSubview:_lable];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
