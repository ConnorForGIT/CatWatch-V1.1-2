//
//  MyCecondcell.h
//  IDailyWatch
//
//  Created by   赵东东 on 14-10-15.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MovieControl.h"
#import "Watch.h"

@protocol pushDelegate <NSObject>

-(void)pushView:(UIViewController *)view;

@end

@class ASIHTTPRequest;
@interface MyCecondcell : UICollectionViewCell
{
    ASIHTTPRequest *videoRequest;
    unsigned long long Recordull;
    BOOL isPlay;
}

@property (nonatomic , retain)UIScrollView *MyscrollView;
@property (nonatomic , retain)UILabel *InLable1;
@property (nonatomic , retain)UILabel *InLable2;
@property (nonatomic , retain)UILabel *InLable3;
@property (nonatomic , retain)UILabel *InLable4;
@property (nonatomic , retain)UIImageView *InimageView;
@property (nonatomic , retain)UIWebView *InWebView;
@property (nonatomic , retain)UIImageView *play;
@property (nonatomic , retain)UITapGestureRecognizer *tap;
@property (nonatomic, retain)NSString *urlString;

@property (nonatomic, retain)Watch *watch;

@property (nonatomic, retain)MPMoviePlayerController *player;

@property (nonatomic, copy)void (^blockTo)();

@property (nonatomic, assign)float myWidth;
@property (nonatomic, assign)float myHeight;
@property (nonatomic , retain)UIButton *button1;
@property (nonatomic , retain)UIButton *button2;
@property (nonatomic , retain)UIButton *button3;
@property (nonatomic , retain)UIButton *button4;
@property (nonatomic , retain)UIButton *button5;
@property (nonatomic , retain)UIButton *button6;


@property (nonatomic, assign)id <pushDelegate> delegate;





@end
