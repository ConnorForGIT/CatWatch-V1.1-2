//
//  ToDayViewController.h
//  iDaily Watch
//
//  Created by 老师先给我发 on 14-10-13.
//  Copyright (c) 2014年 Team 2 All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideImageView.h"
@interface ToDayViewController : UIViewController<SlideImageViewDelegate>
{
    SlideImageView * slideImageView;
    UILabel* indexLabel;
    UILabel* clickLabel;
}
@property (nonatomic, retain) NSMutableArray * modelController;
@end
