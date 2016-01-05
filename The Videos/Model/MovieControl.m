//
//  MovieControl.m
//  IDailyWatch
//
//  Created by   赵东东 on 14/10/20.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "MovieControl.h"


static MPMoviePlayerController *_movie = nil;
@implementation MovieControl
+(MPMoviePlayerController *)creatWithURL:(NSURL *)URL
{
    if (_movie == nil) {
        _movie = [[MPMoviePlayerController alloc]initWithContentURL:URL];
        [_movie prepareToPlay];
        //自动播放
        _movie.shouldAutoplay = YES;
        //添加
//        [self.con addSubview:_moveVc.view];
        
        //    [self.collection bringSubviewToFront:moveVc.view];
        [_movie setControlStyle:MPMovieControlStyleDefault];
        //设置大小
        [_movie.view setFrame:CGRectMake(0, 0, 320, 200)];
    }
    return _movie;
}

- (void)playNewMovie:(NSString *)url
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    _movie.contentURL = [NSURL URLWithString:url];
}

//-(void)doFinished:(id)sender
//{
//    
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
//    [_movie.view removeFromSuperview];
//    [_movie release];/Users/lanou3g/Desktop/IDailyWatch01/The Videos/View/MyCecondcell.m
//    _movie = nil;
//}

@end
