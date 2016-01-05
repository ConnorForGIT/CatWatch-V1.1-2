//
//  VideosInController.h
//  IDailyWatch
//
//  Created by   赵东东 on 14-10-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Watch.h"
#import "MyCecondcell.h"
@class ASIHTTPRequest;


@interface VideosInController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate,UIWebViewDelegate>
{
    ASIHTTPRequest *videoRequest;
    unsigned long long Recordull;
    BOOL isPlay;
}


@property(nonatomic, retain) NSMutableArray * arrModel;
@property (nonatomic, retain)Watch *model;
@property(nonatomic , assign)NSInteger  i;
@property (nonatomic , retain)MPMoviePlayerViewController *moveVc;
@property(nonatomic, retain)    MyCecondcell *cell;
@property (nonatomic, retain)MPMoviePlayerViewController *moviePlayer;
@property (nonatomic , retain)UILabel *viewF;
@property (nonatomic, retain) UIButton *buttonSmall;
@property (nonatomic, retain) UIButton *buttonCentre;
@property (nonatomic, retain) UIButton *buttonBig;
@property (nonatomic, retain) UIButton *buttonPlus;
@property (nonatomic, retain) UILabel *labelPM;
@property (nonatomic, retain) UILabel *labelHX;
@property (nonatomic, retain) UILabel *labelZT;
@property (nonatomic, retain) UISlider *slider;
@end
