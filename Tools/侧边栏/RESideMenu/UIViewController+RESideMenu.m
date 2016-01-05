//
// UIViewController+RESideMenu.m
// RESideMenu


#import "UIViewController+RESideMenu.h"
#import "RESideMenu.h"

@implementation UIViewController (RESideMenu)

- (RESideMenu *)sideMenuViewController
{
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[RESideMenu class]]) {
            return (RESideMenu *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}

#pragma mark -
#pragma mark IB Action Helper methods

- (IBAction)presentLeftMenuViewController:(id)sender
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (IBAction)presentRightMenuViewController:(id)sender
{
    [self.sideMenuViewController presentRightMenuViewController];
}
- (void)showLeftMenuViewControllerWithPan:(UIPanGestureRecognizer *)recognizer{
    [self.sideMenuViewController showLeftMenuViewControllerWithPan:recognizer];
}
@end
