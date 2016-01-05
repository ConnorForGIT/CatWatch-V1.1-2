//
//  LiftViewController.m
//  IDailyWatch
//
//  Created by   赵东东 on 14-10-14.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "LiftViewController.h"
#import "SearchViewController.h"
#import "RESideMenu.h"
#import "FavoriteViewController.h"
#import "sheZhiViewController.h"
#import "AboutViewController.h"
#import "DataBaseManager.h"

@interface LiftViewController ()

@end

@implementation LiftViewController

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
    // Do any additional setup after loading the view.
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing12.png"]];
    

    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(10, 180, 180, 0.5)];
    line1.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:line1];
    [line1 release];
    
    UIButton *downLoadButton = [UIButton buttonWithType:UIButtonTypeSystem];
    downLoadButton.frame = CGRectMake(50, 140, 150, 30);

    [downLoadButton setTitle:@"我的收藏夹" forState:UIControlStateNormal];
    downLoadButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [downLoadButton addTarget:self action:@selector(downLoadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    downLoadButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    downLoadButton.tintColor = [UIColor whiteColor];
    [self.view addSubview:downLoadButton];
    
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(10, 230, 180, 0.5)];
    line2.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:line2];
    [line2 release];
    
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeSystem];
    clearButton.frame = CGRectMake(50, 195, 150, 30);

    [clearButton setTitle:@"清除缓存" forState:UIControlStateNormal];
    clearButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [clearButton addTarget:self action:@selector(clearButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    clearButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    clearButton.tintColor = [UIColor whiteColor];
    [self.view addSubview:clearButton];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(10, 280, 180, 0.5)];
    line3.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:line3];
    [line3 release];
    
    
//    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(10, 330, 200, 0.5)];
//    line4.backgroundColor = [UIColor cyanColor];
//    [self.view addSubview:line4];
//    [line4 release];
    
    
    
    UIButton *shezhiButton = [UIButton buttonWithType:UIButtonTypeSystem];
    shezhiButton.frame = CGRectMake(clearButton.frame.origin.x, clearButton.frame.size.height + clearButton.frame.origin.y + 20, clearButton.frame.size.width, clearButton.frame.size.height);
    [shezhiButton setTitle:@"意见反馈" forState:UIControlStateNormal];
    shezhiButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [shezhiButton addTarget:self action:@selector(shezhiButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    shezhiButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    shezhiButton.tintColor = [UIColor whiteColor];
    [self.view addSubview:shezhiButton];
    
    

    
    UIButton *fankuiButton = [UIButton buttonWithType:UIButtonTypeSystem];
     fankuiButton.frame = CGRectMake(shezhiButton.frame.origin.x, shezhiButton.frame.size.height + shezhiButton.frame.origin.y + 20, shezhiButton.frame.size.width, shezhiButton.frame.size.height);
    [fankuiButton setTitle:@"关于我们" forState:UIControlStateNormal];
    fankuiButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [fankuiButton addTarget:self action:@selector(fankuiButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    fankuiButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    fankuiButton.tintColor = [UIColor whiteColor];
    [self.view addSubview:fankuiButton];
    
    



    for (int i = 0; i < 5; i++) {
        NSString *str = [NSString stringWithFormat:@"0%d.png", i];
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:str]];
        image.frame = CGRectMake(10, 90 + i * 50, 25, 25);
        [self.view addSubview:image];
        [image release];
        
    }

    


}
- (void)fankuiButtonClicked:(UIButton *)button

{
    AboutViewController * vc = [[AboutViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:nil];
    
    [vc release];
    
}
-(void)shezhiButtonClicked:(UIButton *)button
{

    sheZhiViewController *vc = [[sheZhiViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:nil];

    [vc release];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *path = [paths lastObject];
        NSString *str = [NSString stringWithFormat:@"缓存已清除%.1fM", [self folderSizeAtPath:path]];
        
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"清除成功" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
        [al release];
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:path];
        for (NSString *p in files) {
            NSError *error;
            NSString *Path = [path stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:Path]) {
                [[NSFileManager defaultManager] removeItemAtPath:Path error:&error];
            }
        }
        
    }
    
}
- (void)clearButtonClicked:(UIButton *)button
{
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"是否清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
    [alert release];
     
}
-(void)downLoadButtonClicked:(UIButton *)button
{
    FavoriteViewController * vc = [[FavoriteViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    if ([DataBaseManager select].count == 0) {
        UIAlertView * al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂无收藏" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [al show];
        [al release];
    } else {
        
        [self presentViewController:navi animated:YES completion:nil];
        
    }
    [vc release];
    
    
}



- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
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
