//
//  ImageViewController.h
//  Daily Watch
//
//  Created by 陈东旭 on 14-10-23.
//  Copyright (c) 2014年 安静的美男子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController
@property(nonatomic,retain)UIView * headView;
@property(nonatomic,retain)UIScrollView * backScrollView;
@property(nonatomic,retain)NSMutableArray * imageDataSource;
@property(nonatomic,assign)NSInteger start;
@end
