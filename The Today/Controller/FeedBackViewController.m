//
//  FeedBackViewController.m
//  极客闪讯
//
//  Created by LIMING on 14/10/28.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "FeedBackViewController.h"
#import <MessageUI/MFMailComposeViewController.h>


@interface FeedBackViewController ()<MFMailComposeViewControllerDelegate,UIAlertViewDelegate>
@property(nonatomic, retain)UITextView *message;
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"与我们联系";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回11.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
    float myWidth = [UIScreen mainScreen].bounds.size.width;
    float myHeight = [UIScreen mainScreen].bounds.size.height;
    self.message = [[UITextView alloc]initWithFrame:CGRectMake(myWidth * 20 / 320  , myHeight * 20 / 480 , myWidth * 280 / 320, myHeight * 150 / 480)];
    self.message.keyboardAppearance = UIKeyboardAppearanceDark;
    self.message.backgroundColor = [UIColor grayColor];
    self.message.alpha = 0.5;
    

    
    
    
    
    [self.view addSubview:_message];
    [_message release];
     UITapGestureRecognizer *tapKeyBoardBack = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardBack)];

    [self.view addGestureRecognizer:tapKeyBoardBack];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicker:)];
    UILabel *feedbackLabel = [[UILabel alloc]initWithFrame:CGRectMake(myWidth  / 4, _message.frame.origin.y + _message.frame.size.height + 20, myWidth  / 2, myHeight * 30 / 480)];
    feedbackLabel.userInteractionEnabled = YES;
    feedbackLabel.backgroundColor = [UIColor orangeColor];
    feedbackLabel.text = @"点击发送邮件";
    feedbackLabel.textColor = [UIColor whiteColor];
    feedbackLabel.layer.cornerRadius = 10;
    feedbackLabel.layer.masksToBounds = YES;
    feedbackLabel.textAlignment = 1;
    feedbackLabel.alpha = 0.7;
    [feedbackLabel addGestureRecognizer:tap];
    [self.view addSubview:feedbackLabel];
    [feedbackLabel release];
    [tap release];
}



- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark  键盘收回
- (void)keyBoardBack
{
     [self.message resignFirstResponder];
}
#pragma mark 发送反馈信息
-(void)showPicker:(id)sender
{
    if (![self.message.text isEqualToString:@""]) {
        Class mailClass = NSClassFromString(@"MFMailComposeViewController");
        if (mailClass != nil) {
            if ([mailClass canSendMail]) {
                [self displayComposerSheet];
            }else{
                [self launchMailAppOnDevice];
            }
        }else{
            [self launchMailAppOnDevice];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message Failed!" message:@"反馈信息不能为空" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

-(void)displayComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc]init];
    picker.mailComposeDelegate = self;
    [picker setSubject:@"邮件主题"];
    NSArray *toRecipient = [NSArray arrayWithObject:@"317505283@qq.com"];
    [picker setToRecipients:toRecipient];
    NSString *emailBody = self.message.text;
    [picker setMessageBody:emailBody isHTML:NO];
    [self presentViewController:picker animated:YES completion:nil];
    [picker release];
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (result == MFMailComposeResultFailed) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message Failed!" message:@"Your email has failed to send" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    self.message.hidden = NO;
    switch (result) {
        case MFMailComposeResultCancelled:
            _message.text = @"Result: canceled";
            break;
        case MFMailComposeResultSaved:
            _message.text = @"Result: saved";
            break;
        case MFMailComposeResultSent:
            _message.text = @"Result: sent";
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"用户反馈" message:@"发送成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            break;
        case MFMailComposeResultFailed:
            _message.text = @"Result: failed";
            break;
        default:
            _message.text = @"Result: not sent";
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)launchMailAppOnDevice
{
    NSString *recipients = @"mailto:496347267@qq.com&subject=用户反馈!";//@"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from California!";
    NSString *body = [NSString stringWithFormat:@"&body=%@",self.message.text];
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}
-(void)viewDidUnload
{
    self.message = nil;
}
- (void)dealloc
{
    [_message release];
    [super dealloc];
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
