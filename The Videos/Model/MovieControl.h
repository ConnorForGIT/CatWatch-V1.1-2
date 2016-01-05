//
//  MovieControl.h
//  IDailyWatch
//
//  Created by   赵东东 on 14/10/20.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface MovieControl : NSObject
+(MPMoviePlayerController *)creatWithURL:(NSURL *)URL;

- (void)playNewMovie:(NSString *)url;
@end
