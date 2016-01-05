//
//  TwoTableViewCell.m
//  IDailyWatch
//
//  Created by 申洲 on 14-10-15.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "TwwTableViewCell.h"

@implementation TwwTableViewCell
-(void)dealloc
{
    [_button release];
    [_labelPubdate release];
    [_labelSummary release];
    [_labelTitle release];
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
    self.button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *10, [UIScreen mainScreen].bounds.size.height / 480 *10, [UIScreen mainScreen].bounds.size.width / 320 *100, [UIScreen mainScreen].bounds.size.height / 480 *100);
  
    [self.contentView addSubview:_button];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(_button.frame.size.width + 10 + 10, [UIScreen mainScreen].bounds.size.height / 480 *10, [UIScreen mainScreen].bounds.size.width / 320 *190, [UIScreen mainScreen].bounds.size.height / 480 *20)];
    self.labelTitle.font = [UIFont boldSystemFontOfSize:12];
    [self.contentView addSubview:_labelTitle];
    [_labelTitle release];
    
    self.labelPubdate = [[UILabel alloc] initWithFrame:CGRectMake(_labelTitle.frame.origin.x, [UIScreen mainScreen].bounds.size.height / 480 *35, [UIScreen mainScreen].bounds.size.width / 320 *190, [UIScreen mainScreen].bounds.size.height / 480 *10)];
    self.labelPubdate.font = [UIFont boldSystemFontOfSize:10];
    self.labelPubdate.textColor = [UIColor grayColor];
    [self.contentView addSubview:_labelPubdate];
    [_labelPubdate release];
    
    self.labelSummary = [[UILabel alloc] initWithFrame:CGRectMake(_labelPubdate.frame.origin.x, [UIScreen mainScreen].bounds.size.height / 480 *50, [UIScreen mainScreen].bounds.size.width / 320 *190, [UIScreen mainScreen].bounds.size.height / 480 *60)];
    self.labelSummary.textColor = [UIColor grayColor];  self.labelSummary.font = [UIFont boldSystemFontOfSize:11];
    //label上字自动换行
    self.labelSummary.numberOfLines = 0;
    
    [self.contentView addSubview:_labelSummary];
    [_labelSummary release];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
