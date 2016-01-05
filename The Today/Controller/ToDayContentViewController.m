//
//  ToDayContentViewController.m
//  IDailyWatch
//
//  Created by 18班 班长 on 14-10-25.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "ToDayContentViewController.h"

#import "ToDayModel.h"
#import "WebViewCollectionViewCell.h"
#import "ModelSource.h"
#import "DataBaseManager.h"
#import "ImageViewController.h"
#import "UIButton+WebCache.h"

@interface ToDayContentViewController ()

@end

@implementation ToDayContentViewController
-(void)dealloc
{
    [_scroll release];

    [_modelArr release];
    [_webViewCell release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil page:(NSInteger)page modelArr:(NSMutableArray *)modelArr
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.pageTag = page;
        // Custom initialization
        self.modelArr = [NSMutableArray array];
        
        
        self.modelArr = modelArr;
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)]; //设置Label背景透明
        titleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
        titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
        titleLabel.textAlignment = 1;
        titleLabel.text = @"TODAY";  //设置标题
        self.navigationItem.titleView = titleLabel;
            
        
        
    }
    return self;
}
-(void)FAV
{
    NSInteger num = self.collectionView.contentOffset.x / self.view.frame.size.width;
    ModelSource * model = _modelArr[num];
    NSString * str = nil;
    
    if (self.flag) {
        str = @"已取消收藏";
        [DataBaseManager remove:model];
        self.flag = NO;
    } else {
        [DataBaseManager insert:model];
        str = @"收藏成功";
        self.flag = YES;
    }
    
    UIAlertView * altert = [[UIAlertView alloc]initWithTitle:nil message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [altert show];
    [altert release];

}
-(void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createCollectionView];
    
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回11.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(self.view.frame.size.width,self.view.frame.size.height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    CGPoint pt = CGPointMake(self.collectionView.frame.size.width * _pageTag, 0);
    [self.collectionView setContentOffset:pt];
    
    
    [self.collectionView registerClass:[WebViewCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];

    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _modelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    _webViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    _webViewCell.backgroundColor = [UIColor whiteColor];
    
    ModelSource * model = _modelArr[indexPath.item];
    _webViewCell.labelSource.text = model.source;
    _webViewCell.labelTitle.text = model.titleStr;
    _webViewCell.labelAuthor.text = model.author;
    _webViewCell.labelDate.text = model.pubdateStr;
    
    _webViewCell.headScrollView.contentSize = CGSizeMake((_webViewCell.headScrollView.bounds.size.width/5+20+15)*[model albumModelDataSource].count, 0);
    [_webViewCell.headScrollView setShowsHorizontalScrollIndicator:NO];//去掉滚动条
    for (int j = 0; j < [model albumModelDataSource].count; j++) {
        UIButton * imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        imageButton.titleLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
        _start = indexPath.item;
        imageButton.tag = 200+j;
        [imageButton setImageWithURL:[NSURL URLWithString:[[model albumModelDataSource][j] cover_thumbURL]]];
        [imageButton addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        imageButton.frame = CGRectMake(10+(_webViewCell.headScrollView.bounds.size.width/5+20+10)*j, 10, _webViewCell.headScrollView.bounds.size.width/5+20, _webViewCell.headScrollView.bounds.size.height-20);
        [_webViewCell.headScrollView addSubview:imageButton];
    }
    
    
    
    [_webViewCell.button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    
//    [_webViewCell.button2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_webViewCell.button3 addTarget:self action:@selector(button3Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_webViewCell.button4 addTarget:self action:@selector(button4Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_webViewCell.button5 addTarget:self action:@selector(button5Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_webViewCell.button6 addTarget:self action:@selector(button6Action) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [_webViewCell.webView setFrame: CGRectMake(_webViewCell.labelAuthor.frame.origin.x, _webViewCell.labelAuthor.frame.origin.y + _webViewCell.labelAuthor.frame.size.height + 20, 300, 100)];
    [_webViewCell.webView setScalesPageToFit:NO];
    [_webViewCell.webView setDelegate:self];
    
    [_webViewCell.webView setBackgroundColor:[UIColor whiteColor]];
    
    [_webViewCell.webView loadHTMLString:model.contentStr baseURL:nil];
    
    _webViewCell.scroll.contentSize = CGSizeMake(320, 0);
    
    [_webViewCell.scroll addSubview:_webViewCell.webView];

    
    
    NSArray * arr = [DataBaseManager select];
    ModelSource * modelA = _modelArr[indexPath.item];
    
    for (ModelSource * model in arr) {
        if ([model.titleStr isEqualToString:modelA.titleStr]) {
            self.flag = YES;
            break;
        } else {
            self.flag = NO;
        }
    }
    
    
    return _webViewCell;
}



-(void)imageButtonAction:(UIButton * )button
{
    ImageViewController * vc = [[ImageViewController alloc]init];
    ModelSource * model = _modelArr[_start];
    vc.imageDataSource =[model albumModelDataSource];
    vc.start = button.tag-200+1;
//    [self presentViewController:vc animated:NO completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


//- (void)webViewDidStartLoad:(UIWebView *)webView
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
    CGRect newFrame = webView.frame;
    newFrame.size.height = actualSize.height;
    webView.frame = newFrame;
    
    CGSize newsize=CGSizeMake(self.collectionView.contentSize.width, self.collectionView.frame.size.height + webView.frame.size.height);
    
    _collectionView.contentSize = newsize;
    
    _webViewCell.scroll.contentSize = CGSizeMake(0, webView.frame.size.height + 340);
}

-(void)button1Action
{
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void)button2Action
//{
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
//
//    //构造分享内容
//    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@ \n %@中发现了这篇文章,与大家一同分享☺",[_dataSource[_i] title],[_dataSource[_i] link_shareURL]]                                        defaultContent:@"默认分享内容，没内容时显示"
//                                                image:[ShareSDK imageWithPath:imagePath]
//                                                title:@"ShareSDK"
//                                                  url:@"http://www.sharesdk.cn"
//                                          description:@"这是一条测试信息"
//                                            mediaType:SSPublishContentMediaTypeNews];
//
//    [ShareSDK showShareActionSheet:nil
//                         shareList:nil
//                           content:publishContent
//                     statusBarTips:YES
//                       authOptions:nil
//                      shareOptions: nil
//                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                if (state == SSResponseStateSuccess)
//                                {
//                                    NSLog(@"分享成功");
//                                }
//                                else if (state == SSResponseStateFail)
//                                {
//                                    NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
//                                }
//                            }];
//
//}

-(void)button3Action
{
    NSInteger num = self.collectionView.contentOffset.x / self.view.frame.size.width;
    ModelSource * model = _modelArr[num];
    NSString * str = nil;
    
    if (self.flag) {
        str = @"已取消收藏";
        [DataBaseManager remove:model];
        self.flag = NO;
    } else {
        [DataBaseManager insert:model];

        str = @"收藏成功";
        self.flag = YES;
    }
    
    UIAlertView * altert = [[UIAlertView alloc]initWithTitle:nil message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
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
    if (_collectionView.contentOffset.x == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"SB啊到头了" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        _collectionView.contentOffset = CGPointMake(320, 0);
    }
    _collectionView.contentOffset = CGPointMake(_collectionView.contentOffset.x - 320, 0);
}
-(void)button6Action
{
    if (_collectionView.contentOffset.x == (_modelArr.count - 1)*320) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"SB啊到头了" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        _collectionView.contentOffset = CGPointMake((_modelArr.count -2 )*320, 0);
    }
    _collectionView.contentOffset = CGPointMake(_collectionView.contentOffset.x + 320, 0);
}

-(void)small
{
    float a = 80;
    
    NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",a];
    [_webViewCell.webView stringByEvaluatingJavaScriptFromString:str1];
    //    _buttonSmall.backgroundColor = [UIColor redColor];
    [self webViewDidFinishLoad:_webViewCell.webView];
    
}
-(void)centre
{
    float a = 100;
    
    NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",a];
    [_webViewCell.webView stringByEvaluatingJavaScriptFromString:str1];
    //    _buttonSmall.backgroundColor = [UIColor redColor];
    
}
-(void)big
{
    float a = 120;
    
    NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",a];
    [_webViewCell.webView stringByEvaluatingJavaScriptFromString:str1];
    //    _buttonSmall.backgroundColor = [UIColor redColor];
    
}
-(void)plus
{
    float a = 150;
    
    NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",a];
    [_webViewCell.webView stringByEvaluatingJavaScriptFromString:str1];
    //    _buttonSmall.backgroundColor = [UIColor redColor];
    
}
//slder 触发方法
-(void)sliderAction:(UISlider *)slder
{
    //调用系统方法 条件亮度
    [[UIScreen mainScreen]setBrightness:slder.value];
    
}





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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
