//
//  InBrandsController.m
//  IDailyWatch
//
//  Created by   赵东东 on 14-10-16.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "InBrandsController.h"
#import "BrandsCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "Mycell.h"
#import "Product.h"
#import <ShareSDK/ShareSDK.h>
#import "DataBaseManager.h"

@interface InBrandsController ()
@property (nonatomic , retain)UICollectionView *collection;
@property (nonatomic , retain)BrandsCollectionCell *cell;
@property (nonatomic , retain)UILabel *viewF;
@property (nonatomic, retain) UIButton *buttonSmall;
@property (nonatomic, retain) UIButton *buttonCentre;
@property (nonatomic, retain) UIButton *buttonBig;
@property (nonatomic, retain) UIButton *buttonPlus;
@property (nonatomic, retain) UILabel *labelPM;
@property (nonatomic, retain) UILabel *labelHX;
@property (nonatomic, retain) UILabel *labelZT;



@end

@implementation InBrandsController
- (void)dealloc
{
    [_productModel release];
    [_modelArr release];
    [_slider release];
    [_collection release];
    [_cell release];
    [_viewF release];
    [_labelPM release];
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
        self.modelArr = [NSMutableArray array];
        
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)]; //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
    titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
    titleLabel.textAlignment = 1;
    titleLabel.text = @"BRANDS";  //设置标题
    self.navigationItem.titleView = titleLabel;
    [titleLabel release];

    // Do any additional setup after loading the view.
    self.myWidth = [UIScreen mainScreen].bounds.size.width;
    self.myHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回11.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _myWidth, _myHeight) collectionViewLayout:layout];
    _collection.backgroundColor = [UIColor whiteColor];
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.pagingEnabled = YES;
    
    
    [_collection setContentOffset:CGPointMake(self.count * self.view.frame.size.width, 0)];
    
    [self.view addSubview:_collection];
    
    [_collection registerClass:[BrandsCollectionCell class] forCellWithReuseIdentifier:@"11"];
    [_collection release];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _modelArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"11" forIndexPath:indexPath];
    [_cell createWeb];
    Product *pt = self.modelArr[indexPath.item] ;
    _cell.lable1.text = pt.name;
    _cell.lable2.text = pt.Intitle;
    _cell.web.delegate = self;
    [_cell.web loadHTMLString:pt.web baseURL:nil];
    [_cell.images setImageWithURL:[NSURL URLWithString:pt.Inphoto]placeholderImage:[UIImage imageNamed:@"加载.PNG"]];
    
    

    
//功能栏
    [_cell.button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_cell.button2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_cell.button3 addTarget:self action:@selector(button3Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_cell.button4 addTarget:self action:@selector(button4Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_cell.button5 addTarget:self action:@selector(button5Action) forControlEvents:UIControlEventTouchUpInside];
    
    [_cell.button6 addTarget:self action:@selector(button6Action) forControlEvents:UIControlEventTouchUpInside];
    
    return _cell;
}



-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
    CGRect newFrame = webView.frame;
    newFrame.size.height = actualSize.height;
    webView.frame = newFrame;
    
    
    CGSize newsize=CGSizeMake(0,170  + webView.frame.size.height);
    _cell.scrolView.contentSize = newsize;
    
}


// 功能栏
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.viewF = [[UILabel alloc] initWithFrame:CGRectMake(0 , [UIScreen mainScreen].bounds.size.height / 480 * 296, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height / 480 * 100)];
    _viewF.backgroundColor = [UIColor whiteColor];
    

    
    self.labelPM = [[UILabel alloc] init];
    _labelPM.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 * 30, [UIScreen mainScreen].bounds.size.height / 480 * 306, [UIScreen mainScreen].bounds.size.width / 320 *100, [UIScreen mainScreen].bounds.size.height / 480 * 30);
    _labelPM.text = @"屏幕亮度";
    
    
    
    
    self.labelHX = [[UILabel alloc] init];
    _labelHX.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *30, [UIScreen mainScreen].bounds.size.height / 480 *346, [UIScreen mainScreen].bounds.size.width / 320 *270, 1);
    _labelHX.backgroundColor = [UIColor lightGrayColor];
    
    
    self.labelZT = [[UILabel alloc] init];
    _labelZT.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *30, [UIScreen mainScreen].bounds.size.height / 480 *356, [UIScreen mainScreen].bounds.size.width / 320 *100, [UIScreen mainScreen].bounds.size.height / 480 *30);
    _labelZT.text = @"字体大小";
  
    
    self.buttonSmall = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonSmall.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *160, [UIScreen mainScreen].bounds.size.height/ 480 *361, [UIScreen mainScreen].bounds.size.width / 320 *30, [UIScreen mainScreen].bounds.size.height / 480 *20);
    
    [_buttonSmall addTarget:self action:@selector(small) forControlEvents:UIControlEventTouchUpInside];
    // 按钮边框宽度
    _buttonSmall.layer.borderWidth = 1.5;
    // 设置圆角
    _buttonSmall.layer.cornerRadius = 4.5;
    _buttonSmall.backgroundColor = [UIColor blackColor];
    [_buttonSmall setTitle:@"小" forState:UIControlStateNormal];
    [_buttonSmall setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *160,[UIScreen mainScreen].bounds.size.height / 480 * 306, [UIScreen mainScreen].bounds.size.width / 320 *120, [UIScreen mainScreen].bounds.size.height / 480 *20)];
    [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    _slider.tintColor = [UIColor orangeColor];
    
    
    self.buttonCentre = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonCentre.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *190, [UIScreen mainScreen].bounds.size.height / 480 *361, [UIScreen mainScreen].bounds.size.width / 320 *30, [UIScreen mainScreen].bounds.size.height / 480 *20);
    [_buttonCentre addTarget:self action:@selector(centre) forControlEvents:UIControlEventTouchUpInside];
    _buttonCentre.backgroundColor = [UIColor blackColor];
    [_buttonCentre setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    
    // 按钮边框宽度
    _buttonCentre.layer.borderWidth = 1.5;
    // 设置圆角
    _buttonCentre.layer.cornerRadius = 4.5;
    [_buttonCentre setTitle:@"中" forState:UIControlStateNormal];
    
    
    self.buttonBig = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonBig.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 320 *220, [UIScreen mainScreen].bounds.size.height / 480 *361, [UIScreen mainScreen].bounds.size.width / 320 *30, [UIScreen mainScreen].bounds.size.height / 480 *20);
    [_buttonBig addTarget:self action:@selector(big) forControlEvents:UIControlEventTouchUpInside];
    _buttonBig.backgroundColor = [UIColor blackColor];
    [_buttonBig setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    
    // 按钮边框宽度
    _buttonBig.layer.borderWidth = 1.5;
    // 设置圆角
    _buttonBig.layer.cornerRadius = 4.5;
    [_buttonBig setTitle:@"大" forState:UIControlStateNormal];
    
    
    self.buttonPlus = [UIButton buttonWithType:UIButtonTypeCustom];
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
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
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
- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    if (_collection.contentOffset.x == (self.modelArr.count - 1)*320) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，到头了哦😊" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
        _collection.contentOffset = CGPointMake((self.modelArr.count -2 )*320, 0);
    }
    _collection.contentOffset = CGPointMake(_collection.contentOffset.x + 320, 0);
}

-(void)small
{
    float a = 80;
    
    NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",a];
    [_cell.web stringByEvaluatingJavaScriptFromString:str1];
    
}
-(void)centre
{
    float a = 100;
    
    NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",a];
    [_cell.web stringByEvaluatingJavaScriptFromString:str1];
    
}
-(void)big
{
    float a = 120;
    
    NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",a];
    [_cell.web stringByEvaluatingJavaScriptFromString:str1];
    
}
-(void)plus
{
    float a = 150;
    
    NSString* str1 =[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%f%%'",a];
    [_cell.web stringByEvaluatingJavaScriptFromString:str1];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
