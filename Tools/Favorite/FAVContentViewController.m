//
//  FAVContentViewController.m
//  IDailyWatch
//
//  Created by 18班 班长 on 14-10-28.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "FAVContentViewController.h"
#import "WebViewCollectionViewCell.h"
#import "ModelSource.h"

@interface FAVContentViewController ()

@end

@implementation FAVContentViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model:(NSMutableArray *)model page:(NSInteger)page
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.modelArr = [NSMutableArray array];
        self.modelArr = model;
        self.page = page;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    [self createCollectionView];
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
    CGPoint pt = CGPointMake(self.collectionView.frame.size.width * _page, 0);
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
    
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(_webViewCell.labelAuthor.frame.origin.x, _webViewCell.labelAuthor.frame.origin.y + _webViewCell.labelAuthor.frame.size.height + 20, 300, 100)];
    
    [self.webView setScalesPageToFit:NO];
    [self.webView setDelegate:self];
    [self.webView setBackgroundColor:[UIColor whiteColor]];
    
    [self.webView loadHTMLString:model.contentStr baseURL:nil];
    
    _webViewCell.scroll.contentSize = CGSizeMake(320, 0);
    
    [_webViewCell.scroll addSubview:_webView];
    [_webView release];
    
    
    return _webViewCell;
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
    
    _webViewCell.scroll.contentSize = CGSizeMake(0, webView.frame.size.height + 260);
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
