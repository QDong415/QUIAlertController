//
//  QAlertViewController
//
//  Created by QDong on 2022-7-30.
//  Copyright (c) 2021年 QDong QQ:285275534@qq.com. All rights reserved.
//

#import "AlertNavigationViewController.h"


@interface AlertNavigationViewController ()

@end

@implementation AlertNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - <QUIModalPresentationContentViewControllerProtocol>

- (CGSize)preferredContentSizeInModalPresentationViewController:(QUIModalPresentationViewController *)controller keyboardHeight:(CGFloat)keyboardHeight limitSize:(CGSize)limitSize {
    
    UIEdgeInsets safeAreaInsets;
    if (@available(iOS 11.0, *)) {
        safeAreaInsets = controller.view.safeAreaInsets;
    } else {
        safeAreaInsets = UIEdgeInsetsZero;
    }
    
    return CGSizeMake(CGRectGetWidth(controller.view.bounds) - 60, CGRectGetHeight(controller.view.bounds) - (safeAreaInsets.top + safeAreaInsets.bottom) - (controller.contentViewMargins.top + controller.contentViewMargins.bottom));
}

@end
