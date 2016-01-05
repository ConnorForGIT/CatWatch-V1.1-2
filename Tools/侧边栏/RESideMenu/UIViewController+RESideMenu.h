//
// UIViewController+RESideMenu.h
// RESideMenu


#import <UIKit/UIKit.h>

@class RESideMenu;

@interface UIViewController (RESideMenu)

@property (strong, readonly, nonatomic) RESideMenu *sideMenuViewController;

// IB Action Helper methods

- (IBAction)presentLeftMenuViewController:(id)sender;
- (IBAction)presentRightMenuViewController:(id)sender;
- (void)showLeftMenuViewControllerWithPan:(UIPanGestureRecognizer *)recognizer;

@end
