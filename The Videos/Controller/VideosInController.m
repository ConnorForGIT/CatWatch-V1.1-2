//
//  VideosInController.m
//  IDailyWatch
//
//  Created by   赵东东 on 14-10-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "VideosInController.h"
#import "UIImageView+WebCache.h"
#import "Watch.h"
#import <ShareSDK/ShareSDK.h>

#import "ASIHTTPRequest.h"

@interface VideosInController ()
@property (nonatomic , retain)UICollectionView *collection;
@property (nonatomic, retain)NSString *str;
@property (nonatomic, retain)UIButton *buttonType1;
@property(nonatomic, retain)UIView *myView;



@end

@implementation VideosInController

- (void)dealloc
{
    [_collection release];
    [_str release];
    [_myView release];
    [_arrModel release];
    [_model release];
    [_moveVc release];
    [_cell release];
    [_moviePlayer release];
    [_viewF release];
    [_labelHX release];
    [_labelZT release];
    [_slider release];
    [super dealloc];
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)]; //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
    titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
    titleLabel.textAlignment = 1;
    titleLabel.text = @"VIDEOS";  //设置标题
    self.navigationItem.titleView = titleLabel;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回11.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    

    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height  ) collectionViewLayout:layout];
     [self.collection setContentOffset:CGPointMake(_i * 320, 0) animated:YES];

    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.pagingEnabled = YES;

    [self.view addSubview:_collection];
    

    [_collection registerClass:[MyCecondcell class] forCellWithReuseIdentifier:@"22"];

}
- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.arrModel.count - 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    _cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"22" forIndexPath:indexPath];

    Watch *watch = [self.arrModel objectAtIndex:indexPath.row];
    
    _cell.InLable1.text = watch.Intitle1;
    _cell.InLable2.text = watch.Intitle2;
    _cell.InLable3.text = watch.Intitle3;
    _cell.InLable4.text = watch.Intitle4;
    
    
   

    
    [_cell.InimageView setImageWithURL:[NSURL URLWithString:watch.InPhoto]placeholderImage:[UIImage imageNamed:@"加载.PNG"]];
    [_cell.InWebView loadHTMLString:watch.Inweb baseURL:nil];
    [_cell.InWebView setFrame:CGRectMake(0, 300, 320, 100)];
    
    _cell.InWebView.delegate = self;
    _cell.delegate = self;
    
    _cell.blockTo = ^(){
        
        //添加
        [self videoPlay:watch];
        [self.collection reloadData];

    };
    
    //功能栏
    [_cell.button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_cell.button2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_cell.button3 addTarget:self action:@selector(button3Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_cell.button4 addTarget:self action:@selector(button4Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_cell.button5 addTarget:self action:@selector(button5Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_cell.button6 addTarget:self action:@selector(button6Action) forControlEvents:UIControlEventTouchUpInside];


    return _cell;
}

#pragma mark 流媒体
- (void)videoPlay:(Watch *)watch{
    if (![watch.move hasSuffix:@".mp4"]) {
        NSArray *array=[watch.move componentsSeparatedByString:@".mp4"];
        watch.move = [NSString stringWithFormat:@"%@.mp4", array[0]];
    }
    
    
    NSString *webPath = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/TempVideo"];
    NSString *cachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/CacheVideo"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:cachePath])
    {
        [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if ([fileManager fileExistsAtPath:[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",watch.guid]]]) {
        _moveVc = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4", watch.guid]]]];
        [self presentMoviePlayerViewControllerAnimated:_moveVc];
        
        videoRequest = nil;
    }else{
        
        ASIHTTPRequest *request=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", watch.move]]];
        
        //下载完存储目录
        [request setDownloadDestinationPath:[cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4", watch.guid]]];
        //临时存储目录
        [request setTemporaryFileDownloadPath:[webPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4", watch.guid]]];
        
        [request setBytesReceivedBlock:^(unsigned long long size, unsigned long long total) {

            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setDouble:total forKey:@"file_length"];
            Recordull += size;//Recordull全局变量，记录已下载的文件的大小
            if (!isPlay&&Recordull > 400000) {
                isPlay = !isPlay;
                [self playVideo:watch.guid];
            }
        }];
        //断点续载
        [request setAllowResumeForFileDownloads:YES];
        [request startAsynchronous];
        videoRequest = request;
        
    }
}

- (void)playVideo:(NSString *)str{
    _moveVc =[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://127.0.0.1:12345/%@.mp4", str]]];
    [self presentMoviePlayerViewControllerAnimated:_moveVc];
}

//-(void)viewDidDisappear:(BOOL)animated
//{
//    if (_moveVc.fullscreen == YES) {
//        return;
//    }
//    [super viewDidDisappear:animated];
//    if (_moveVc) {
//        [_moveVc stop];
//        [_moveVc.view removeFromSuperview];
//    }
//    
//
//}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
    CGRect newFrame = webView.frame;
    newFrame.size.height = actualSize.height;
    webView.frame = newFrame;
    
    CGSize newsize=CGSizeMake(0, 280 +64 + webView.frame.size.height);
    _cell.MyscrollView.contentSize = newsize;

}

//功能栏

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _viewF = [[UILabel alloc] initWithFrame:CGRectMake(0 , [UIScreen mainScreen].bounds.size.height / 480 * 296, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height / 480 * 100)];
    _viewF.backgroundColor = [UIColor whiteColor];
    //    _viewF.alpha = 0.8f;
    
    
    _labelPM = [[UILabel alloc] init];
    _labelPM.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 * 30, [UIScreen mainScreen].bounds.size.height / 480 * 306, [UIScreen mainScreen].bounds.size.width / 320 *100, [UIScreen mainScreen].bounds.size.height / 480 * 30);
    _labelPM.text = @"屏幕亮度";
    
    
    
    _labelHX = [[UILabel alloc] init];
    _labelHX.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *30, [UIScreen mainScreen].bounds.size.height / 480 *346, [UIScreen mainScreen].bounds.size.width / 320 *270, 1);
    _labelHX.backgroundColor = [UIColor lightGrayColor];
    _labelZT = [[UILabel alloc] init];
    _labelZT.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *30, [UIScreen mainScreen].bounds.size.height / 480 *356, [UIScreen mainScreen].bounds.size.width / 320 *100, [UIScreen mainScreen].bounds.size.height / 480 *30);
    _labelZT.text = @"字体大小";
    
    _buttonSmall = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonSmall.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *160, [UIScreen mainScreen].bounds.size.height/ 480 *361, [UIScreen mainScreen].bounds.size.width / 320 *30, [UIScreen mainScreen].bounds.size.height / 480 *20);
    
    [_buttonSmall addTarget:self action:@selector(small) forControlEvents:UIControlEventTouchUpInside];
    // 按钮边框宽度
    _buttonSmall.layer.borderWidth = 1.5;
    // 设置圆角
    _buttonSmall.layer.cornerRadius = 4.5;
    _buttonSmall.backgroundColor = [UIColor blackColor];
    [_buttonSmall setTitle:@"小" forState:UIControlStateNormal];
    [_buttonSmall setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *160,[UIScreen mainScreen].bounds.size.height / 480 * 306, [UIScreen mainScreen].bounds.size.width / 320 *120, [UIScreen mainScreen].bounds.size.height / 480 *20)];
    [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    _slider.tintColor = [UIColor orangeColor];
    
    _buttonCentre = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonCentre.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *190, [UIScreen mainScreen].bounds.size.height / 480 *361, [UIScreen mainScreen].bounds.size.width / 320 *30, [UIScreen mainScreen].bounds.size.height / 480 *20);
    [_buttonCentre addTarget:self action:@selector(centre) forControlEvents:UIControlEventTouchUpInside];
    _buttonCentre.backgroundColor = [UIColor blackColor];
    [_buttonCentre setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    
    // 按钮边框宽度
    _buttonCentre.layer.borderWidth = 1.5;
    // 设置圆角
    _buttonCentre.layer.cornerRadius = 4.5;
    [_buttonCentre setTitle:@"中" forState:UIControlStateNormal];
    
    
    _buttonBig = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonBig.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *220, [UIScreen mainScreen].bounds.size.height / 480 *361, [UIScreen mainScreen].bounds.size.width / 320 *30, [UIScreen mainScreen].bounds.size.height / 480 *20);
    [_buttonBig addTarget:self action:@selector(big) forControlEvents:UIControlEventTouchUpInside];
    _buttonBig.backgroundColor = [UIColor blackColor];
    [_buttonBig setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    
    // 按钮边框宽度
    _buttonBig.layer.borderWidth = 1.5;
    // 设置圆角
    _buttonBig.layer.cornerRadius = 4.5;
    [_buttonBig setTitle:@"大" forState:UIControlStateNormal];
    
    
    _buttonPlus = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonPlus.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *250, [UIScreen mainScreen].bounds.size.height / 480 *361, [UIScreen mainScreen].bounds.size.width / 320 *30, [UIScreen mainScreen].bounds.size.height / 480 *20);
    [_buttonPlus addTarget:self action:@selector(plus) forControlEvents:UIControlEventTouchUpInside];
    _buttonPlus.backgroundColor = [UIColor blackColor];
    [_buttonPlus setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    
    // 按钮边框宽度
    _buttonPlus.layer.borderWidth = 1.5;
    // 设置圆角
    _buttonPlus.layer.cornerRadius = 4.5;
    [_buttonPlus setTitle:@"特" forState:UIControlStateNormal];

    
    
    [self.view addSubview:_viewF];
    
    [self.view bringSubviewToFront:_viewF];
    [self.view addSubview:_buttonSmall];
    [self.view bringSubviewToFront:_buttonSmall];
    
    [self.view addSubview:_buttonCentre];
    [self.view bringSubviewToFront:_buttonCentre];
    [self.view addSubview:_buttonBig];
    [self.view bringSubviewToFront:_buttonBig];
    
    [self.view addSubview:_buttonPlus];
    [self.view bringSubviewToFront:_buttonPlus];
    
    [self.view addSubview:_labelZT];
    [self.view bringSubviewToFront:_labelZT];
    
    [self.view addSubview:_labelHX];
    [self.view bringSubviewToFront:_labelHX];
    
    
    [self.view addSubview:_labelPM];
    [self.view bringSubviewToFront:_labelHX];
    [self.view addSubview:_slider];
    [self.view bringSubviewToFront:_slider];
    
    _viewF.hidden = YES;
    
    _buttonBig.hidden = YES;
    _buttonCentre.hidden = YES;
    _buttonSmall.hidden = YES;
    _buttonPlus.hidden = YES;
    _labelHX.hidden = YES;
    _labelPM.hidden = YES;
    _labelZT.hidden = YES;
    _slider.hidden = YES;
    
    
    
}
-(void)button1Action
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)button2Action
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];

    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"我在CatWatch中发现了这篇文章,与大家一同分享☺"]                                        defaultContent:@"默认分享内容，没内容时显示"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.sharesdk.cn"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];

    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                }
                                else if (state == SSResponseStateFail)
                                {
                                }
                            }];

}

-(void)button3Action
{
    UIAlertView * altert = [[UIAlertView alloc]initWithTitle:nil message:@"该页暂不提供收藏" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [altert show];
    [altert release];
    
}
-(void)button4Action
{
    if (_viewF.hidden == NO) {
        _viewF.hidden = YES;
        
        _buttonBig.hidden = YES;
        _buttonCentre.hidden = YES;
        _buttonSmall.hidden = YES;
        _buttonPlus.hidden = YES;
        _labelHX.hidden = YES;
        _labelPM.hidden = YES;
        _labelZT.hidden = YES;
        _slider.hidden = YES;
        
    }else {
        _viewF.hidden = NO;
        
        _buttonBig.hidden = NO;
        _buttonCentre.hidden = NO;
        _buttonSmall.hidden = NO;
        _buttonPlus.hidden = NO;
        _labelHX.hidden = NO;
        _labelPM.hidden = NO;
        _labelZT.hidden = NO;
        _slider.hidden = NO;
    }
    
}




-(void)button5Action
{
    if (_collection.contentOffset.x == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，到头了哦😊" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        _collection.contentOffset = CGPointMake(320, 0);
    }
    _collection.contentOffset = CGPointMake(_collection.contentOffset.x - 320, 0);
}
-(void)button6Action
{
    if (_collection.contentOffset.x == (self.arrModel.count - 2)*320) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，到头了哦😊" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        _collection.contentOffset = CGPointMake((self.arrModel.count -3 )*320, 0);
    }
    _collection.contentOffset = CGPointMake(_collection.contentOffset.x + 320, 0);
}
-(void)small
{
    float a = 80;
    
    NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",a];
    [_cell.InWebView stringByEvaluatingJavaScriptFromString:str1];
    //    _buttonSmall.backgroundColor = [UIColor redColor];
    
}
-(void)centre
{
    float a = 100;
    
    NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",a];
    [_cell.InWebView stringByEvaluatingJavaScriptFromString:str1];
    //    _buttonSmall.backgroundColor = [UIColor redColor];
    
}
-(void)big
{
    float a = 120;
    
    NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",a];
    [_cell.InWebView stringByEvaluatingJavaScriptFromString:str1];
    //    _buttonSmall.backgroundColor = [UIColor redColor];
    
}
-(void)plus
{
    float a = 150;
    
    NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",a];
    [_cell.InWebView stringByEvaluatingJavaScriptFromString:str1];
    //    _buttonSmall.backgroundColor = [UIColor redColor];
    
}

//slder 触发方法
-(void)sliderAction:(UISlider *)slder
{
    //调用系统方法 条件亮度
    [[UIScreen mainScreen]setBrightness:slder.value];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
