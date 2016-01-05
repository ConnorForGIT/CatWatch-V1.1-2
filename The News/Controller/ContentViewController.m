//
//  ContentViewController.m
//  IDailyWatch
//
//  Created by 申洲 on 14-10-15.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "ContentViewController.h"
#import "ThreeTableViewCell.h"
#import "FourTableViewCell.h"
#import "FiveTableViewCell.h"
#import "Model.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "NewsViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "NewsCollectionViewCell.h"
#import "DataBaseManager.h"


@interface ContentViewController ()<UIScrollViewDelegate>

@end
BOOL flog;
@implementation ContentViewController
-(void)dealloc
{
    [_collection release];
    [_scrollView release];
    [_dataSource release];
    [_webView release];
    [_labelHX release];
    [_labelPM release];
    [_labelZT release];
    [_button release];
    [_buttonBig release];
    [_buttonCentre release];
    [_buttonPlus release];
    [_buttonSmall release];
    [_viewF release];
    [_slider release];
    
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataSource = [NSMutableArray array];
//        self.b = [NSMutableArray array];
        
        
    }
    return self;
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)]; //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
    titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
    titleLabel.textAlignment = 1;
    titleLabel.text = @"NEWS";  //设置标题
    self.navigationItem.titleView = titleLabel;

    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回11.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
    [self collectionView];
    
    
    
    
}



#pragma mark -
#pragma mark 创建视图
-(void)collectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    //横向滑动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height / 480 * (480 - 64)) collectionViewLayout:layout];

    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.pagingEnabled = YES;
    
 

    
  
    
    [_collection setContentOffset:CGPointMake(_i * 320, 0)];
    [_collection registerClass:[NewsCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collection];
    [_collection release];
    
    
}


#pragma mark -
#pragma mark 数据源
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    _cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    NSURL *url = [NSURL URLWithString:[_dataSource[indexPath.item] cover] ];
    [_cell.image setImageWithURL:url placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"加载.PNG"]]];
    _cell.sourceLabel.text = [_dataSource[indexPath.item
] source];
    _cell.titleLabel.text = [_dataSource[indexPath.item] title];
    _cell.authorLabel.text = [_dataSource[indexPath.item]author];
    _cell.pubdateLabel.text = [_dataSource[indexPath.item] pubdate];
    [_cell.button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_cell.button2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_cell.button3 addTarget:self action:@selector(button3Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_cell.button4 addTarget:self action:@selector(button4Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_cell.button5 addTarget:self action:@selector(button5Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_cell.button6 addTarget:self action:@selector(button6Action) forControlEvents:UIControlEventTouchUpInside];

    
    self.webView = [[UIWebView alloc] init];
    self.webView.frame = CGRectMake(10, _cell.XianLabel.frame.origin.y + 25, 300, 100);
    
    _webView.scrollView.scrollEnabled = NO;
    _webView.delegate = self;
    
    [_webView loadHTMLString:[_dataSource[indexPath.item] contentSTR] baseURL:nil];
    [_cell.scroll addSubview:_webView];
    [_webView release];
    
//    NSArray * arr = [DataBaseManager select];
//    Model * modelA = _dataSource[indexPath.item];
//    
//    for (Model * model in arr) {
//        if ([model.title isEqualToString:modelA.title]) {
//            self.flag1 = YES;
//            break;
//        } else {
//            self.flag1 = NO;
//        }
//    }

    return _cell;
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth = 280;" //缩放系数
     "for(i=0;i < document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "myimg.height = myimg.height * (maxwidth/oldwidth) + 90;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    [_webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //设置一个自适应的size
    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
    CGRect newFrame = webView.frame;
    newFrame.size.height = actualSize.height;
    webView.frame = newFrame;
    
    
    CGSize newsize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 150 +200 + 10 + 10 + 10 + webView.frame.size.height);
    _cell.scroll.contentSize = newsize;
//    _collection.contentSize = newsize;
    
    

}

-(void)button1Action
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)button2Action
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];

    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@ \n %@中发现了这篇文章,与大家一同分享☺",[_dataSource[_i] title],[_dataSource[_i] link_shareURL]]                                        defaultContent:@"默认分享内容，没内容时显示"
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
    NSInteger num = self.collection.contentOffset.x / self.view.frame.size.width;
    Model * model = _dataSource[num];
    NSString * str = nil;
    
    if (self.flag1) {
        str = @"已取消收藏";
        [DataBaseManager removeNews:model];
        self.flag1 = NO;
    } else {
        [DataBaseManager insertNews:model];
        str = @"收藏成功";
        self.flag1 = YES;
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
    if (_collection.contentOffset.x == (_dataSource.count - 1)*320) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，到头了哦😊" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        _collection.contentOffset = CGPointMake((_dataSource.count -2 )*320, 0);
    }
    _collection.contentOffset = CGPointMake(_collection.contentOffset.x + 320, 0);
}

-(void)small
{
    float a = 80;
    
    NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",a];
    [_webView stringByEvaluatingJavaScriptFromString:str1];
//    _buttonSmall.backgroundColor = [UIColor redColor];
    [self webViewDidFinishLoad:_webView];
    
}
-(void)centre
{
    float a = 100;
    
    NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",a];
    [_webView stringByEvaluatingJavaScriptFromString:str1];
    //    _buttonSmall.backgroundColor = [UIColor redColor];
    
}
-(void)big
{
    float a = 120;
    
    NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",a];
    [_webView stringByEvaluatingJavaScriptFromString:str1];
    //    _buttonSmall.backgroundColor = [UIColor redColor];
    
}
-(void)plus
{
    float a = 150;
    
    NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",a];
    [_webView stringByEvaluatingJavaScriptFromString:str1];
    //    _buttonSmall.backgroundColor = [UIColor redColor];
    
}
//slder 触发方法
-(void)sliderAction:(UISlider *)slder
{
    //调用系统方法 条件亮度
    [[UIScreen mainScreen]setBrightness:slder.value];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _viewF = [[UILabel alloc] initWithFrame:CGRectMake(0 , [UIScreen mainScreen].bounds.size.height / 480 * 296, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height / 480 * 100)];
    _viewF.backgroundColor = [UIColor whiteColor];
    _viewF.alpha = 0.8f;
    
   
    
    _labelPM = [[UILabel alloc] init];
    _labelPM.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 * 30, [UIScreen mainScreen].bounds.size.height / 480 * 306, [UIScreen mainScreen].bounds.size.width / 320 *100, [UIScreen mainScreen].bounds.size.height / 480 * 30);
    _labelPM.text = @"屏幕亮度";
    
    
    
    _labelHX = [[UILabel alloc] init];
    _labelHX.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *30, [UIScreen mainScreen].bounds.size.height / 480 *346, [UIScreen mainScreen].bounds.size.width / 320 *260, 1);
    _labelHX.backgroundColor = [UIColor lightGrayColor];
    _labelZT = [[UILabel alloc] init];
    _labelZT.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *30, [UIScreen mainScreen].bounds.size.height / 480 *356, [UIScreen mainScreen].bounds.size.width / 320 *100, [UIScreen mainScreen].bounds.size.height / 480 *30);
    _labelZT.text = @"字体大小";
    
    _buttonSmall = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonSmall.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *160, [UIScreen mainScreen].bounds.size.height/ 480 *361, [UIScreen mainScreen].bounds.size.width / 320 *30, [UIScreen mainScreen].bounds.size.height / 480 *20);
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *160,[UIScreen mainScreen].bounds.size.height / 480 * 306, [UIScreen mainScreen].bounds.size.width / 320 *120, [UIScreen mainScreen].bounds.size.height / 480 *20)];
    [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    _slider.tintColor = [UIColor orangeColor];
   
    [_buttonSmall addTarget:self action:@selector(small) forControlEvents:UIControlEventTouchUpInside];
    // 按钮边框宽度
    _buttonSmall.layer.borderWidth = 1.5;
    // 设置圆角
    _buttonSmall.layer.cornerRadius = 4.5;
    _buttonSmall.backgroundColor = [UIColor blackColor];
    [_buttonSmall setTitle:@"小" forState:UIControlStateNormal];
    [_buttonSmall setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    _buttonCentre = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonCentre.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *190, [UIScreen mainScreen].bounds.size.height / 480 *361, [UIScreen mainScreen].bounds.size.width / 320 *30, [UIScreen mainScreen].bounds.size.height / 480 *20);
    [_buttonCentre addTarget:self action:@selector(centre) forControlEvents:UIControlEventTouchUpInside];
    _buttonCentre.backgroundColor = [UIColor blackColor];
    
    
    // 按钮边框宽度
    _buttonCentre.layer.borderWidth = 1.5;
    // 设置圆角
    _buttonCentre.layer.cornerRadius = 4.5;
    [_buttonCentre setTitle:@"中" forState:UIControlStateNormal];
    [_buttonCentre setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
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
    [_buttonPlus setTitle:@"超" forState:UIControlStateNormal];
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
