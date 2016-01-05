//
//  FourTableViewCell.m
//  IDailyWatch
//
//  Created by 申洲 on 14-10-16.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "FourTableViewCell.h"

@implementation FourTableViewCell
-(void)dealloc
{
    [_sourceLabel release];
    [_pubdateLabel release];
    [_authorLabel release];
    [_titleLabel release];
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
    self.sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *10, [UIScreen mainScreen].bounds.size.height / 480 *10, [UIScreen mainScreen].bounds.size.width / 320 *300, [UIScreen mainScreen].bounds.size.height / 480 *10)];
    self.sourceLabel.font = [UIFont boldSystemFontOfSize:10];
    self.sourceLabel.textColor = [UIColor grayColor];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *10, _sourceLabel.frame.size.height + 10 + 5, [UIScreen mainScreen].bounds.size.width / 320 *300, [UIScreen mainScreen].bounds.size.height / 480 *40)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.numberOfLines = 0;
    
    self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *10, _titleLabel.frame.origin.y + _titleLabel.frame.size.height + 5, [UIScreen mainScreen].bounds.size.width / 320 *150, [UIScreen mainScreen].bounds.size.height / 480 *10)];
    self.authorLabel.font = [UIFont boldSystemFontOfSize:10];
    self.authorLabel.textColor = [UIColor grayColor];
    self.pubdateLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *200, _authorLabel.frame.origin.y, [UIScreen mainScreen].bounds.size.width / 320 *110, [UIScreen mainScreen].bounds.size.height / 480 *10)];
    self.pubdateLabel.font = [UIFont boldSystemFontOfSize:10];
    self.pubdateLabel.textColor = [UIColor grayColor];
    self.pubdateLabel.textAlignment = NSTextAlignmentRight ;
    [self.contentView addSubview:_sourceLabel];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_authorLabel];
    [self.contentView addSubview:_pubdateLabel];
    [_sourceLabel release];
    [_titleLabel release];
    [_authorLabel release];
    [_pubdateLabel release];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
