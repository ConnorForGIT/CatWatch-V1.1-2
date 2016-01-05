//
//  FAVCollectionViewCell.h
//  IDailyWatch
//
//  Created by 18班 班长 on 14-10-28.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAVCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) UILabel * labelSource;
@property (nonatomic, retain) UILabel * labelTitle;
@property (nonatomic, retain) UILabel * labelAuthor;
@property (nonatomic, retain) UILabel * labelDate;

@property (nonatomic, retain) UIScrollView * scroll;


@end
