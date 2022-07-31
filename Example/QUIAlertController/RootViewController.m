//
//  QAlertViewController
//
//  Created by QDong on 2022-7-30.
//  Copyright (c) 2021年 QDong QQ:285275534@qq.com. All rights reserved.
//

#import "RootViewController.h"
#import "VisibleViewControllerHelper.h"
#import "QUIAlertController.h"
#import "UIBorderViewHelper.h"
#import "ThirdView.h"
#import "AdjustEdgeInsetTextField.h"
#import "ConInAlertViewController.h"
#import "CommonCodeWriteView.h"
#import "AlertNavigationViewController.h"


@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"入口";
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    //设置列表数据源
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
}


//返回列表分组数，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//返回列表每个分组section拥有cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            QUIAlertController *alertController = [QUIAlertController alertControllerWithTitle:@"Alert标题" message:@"不用系统的，就可以非常灵活的定制弹框的所有UI属性，避免和效果图不一致" preferredStyle:QUIAlertControllerStyleAlert];
            //点击黑色背景隐藏
            alertController.shouldRespondMaskViewTouch = YES;

            //添加一个取消按钮
            QUIAlertAction *cancelAction = [QUIAlertAction actionWithTitle:@"我知道了" style:QUIAlertActionStyleCancel handler:nil];
            //可以为这个取消按钮设置按钮颜色、字体大小。如果不设置，默认是浅蓝色
            cancelAction.buttonAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:17],NSKernAttributeName:@(0)};
            
            [alertController addAction:cancelAction];
            
            //添加一个确认按钮
            [alertController addAction:[QUIAlertAction actionWithTitle:@"确定" style:QUIAlertActionStyleDestructive handler:^(QUIAlertController *alertController, QUIAlertAction *action) {
                
            }]];
            
            [alertController showWithAnimated:YES];
        }
            break;
        case 1:{
            // Alert弹框 + UITextField
            QUIAlertController *alertController = [QUIAlertController alertControllerWithTitle:@"请输入账号信息" message:@"两项填写一项即可" preferredStyle:QUIAlertControllerStyleAlert];
            
            [alertController addAction:[QUIAlertAction actionWithTitle:@"确定" style:QUIAlertActionStyleDestructive handler:^(QUIAlertController *alertController, QUIAlertAction *action) {
                NSLog(@"%@",alertController.textFields[0].text);
            }]];
            [alertController addCancelAction];
            [alertController addTextFieldWithConfigurationHandler:^(AdjustEdgeInsetTextField * _Nonnull textField) {
                textField.placeholder = @"账号";
            }];
            [alertController addTextFieldWithConfigurationHandler:^(AdjustEdgeInsetTextField * _Nonnull textField) {
                textField.placeholder = @"密码";
            }];
            
            // 输入框的布局默认是贴在一起的，默认不需要修改，这里只是展示可以通过这个 block 自行调整。
            alertController.alertTextFieldMarginBlock = ^UIEdgeInsets(__kindof QUIAlertController * _Nonnull alertController, NSInteger aTextFieldIndex) {
                UIEdgeInsets margin = UIEdgeInsetsZero;
                if (aTextFieldIndex == alertController.textFields.count - 1) {
                    margin.bottom = 16;
                } else {
                    margin.bottom = 6;
                }
                return margin;
            };

            [alertController showWithAnimated:YES];
        }
            break;
        case 2:{
            // Alert弹框 + 内容是view + view是用xib约束
            ThirdView *thirdView = [[[UINib nibWithNibName:@"ThirdView" bundle:nil] instantiateWithOwner:nil options:nil] objectAtIndex:0];
            
            //实际开发中，你往往希望：弹框的高度 == 在xib里手动拉好的高度。弹框的宽度 == 屏幕宽度 - 20 - 20
            //所以我们需要设置 弹框的宽度 = xibView的宽度 = 屏幕宽度 - 40
            float alertWidth = self.view.frame.size.width - 40;
            
            //必须外面再套一层，然后设置autoresizingMask。这样alert的高度就是xib你手动拉出来的高度
            UIView *containerView = [[UIView alloc] initWithFrame:thirdView.bounds];
            thirdView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            [containerView addSubview:thirdView];
            
            //然后重设包裹层的frame，利用autoresizing的特性，让xibView的宽高等比例缩放
            containerView.frame = CGRectMake(0, 0, alertWidth, thirdView.frame.size.height);
            
            QUIAlertAction *action1 = [QUIAlertAction actionWithTitle:@"取消" style:QUIAlertActionStyleCancel handler:NULL];
            QUIAlertAction *action2 = [QUIAlertAction actionWithTitle:@"确定" style:QUIAlertActionStyleDestructive handler:^(QUIAlertController *alertController, QUIAlertAction *action) {
            }];
            QUIAlertController *alertController = [QUIAlertController alertControllerWithTitle:nil message:nil preferredStyle:QUIAlertControllerStyleAlert];
            
            //Alert弹框的最大宽度。这样设置的话就等于左右20pt空隙
            alertController.alertContentMaximumWidth = alertWidth;
            //不需要顶部的提示语
            alertController.alertHeaderInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            
            [alertController addAction:action1];
            [alertController addAction:action2];
            [alertController addCustomView:containerView];
            [alertController showWithAnimated:YES];
        }
            break;
        case 3: {
            // Alert弹框 + 内容是view + view是frame
            CommonCodeWriteView *thirdView = [[CommonCodeWriteView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
            thirdView.backgroundColor = UIColor.yellowColor;
            QUIAlertAction *action2 = [QUIAlertAction actionWithTitle:@"确定" style:QUIAlertActionStyleDestructive handler:^(QUIAlertController *alertController, QUIAlertAction *action) {
            }];
            QUIAlertController *alertController = [QUIAlertController alertControllerWithTitle:nil message:nil preferredStyle:QUIAlertControllerStyleAlert];
            
            //CustomView宽度我上面设置的是200，整个alertView的宽度我设置的是240，所以左右有20的内间距
            alertController.alertContentMaximumWidth = 240;
            
            [alertController addCustomView:thirdView];
            [alertController addAction:action2];
            [alertController showWithAnimated:YES];
        }
            break;
        case 4: {
            // 基于presentViewController弹框 + 内容是自定义View
            CommonCodeWriteView *thirdView = [[CommonCodeWriteView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
            thirdView.backgroundColor = UIColor.yellowColor;
            
            QUIModalPresentationViewController *modal2ViewController = [[QUIModalPresentationViewController alloc] init];
            modal2ViewController.contentView = thirdView;
            modal2ViewController.animationStyle = QUIModalPresentationAnimationStylePopup; //中心弹出
            // 以 presentViewController 的形式展示时，animated 要传 NO，否则系统的动画会覆盖 QUIModalPresentationAnimationStyle 的动画
            [self presentViewController: modal2ViewController animated:NO completion:NULL];
        }
            break;
        case 5: {
            // 基于presentViewController弹框 + 内容是ViewController
            ConInAlertViewController *contentViewController = [[ConInAlertViewController alloc] init];
            QUIModalPresentationViewController *modalViewController = [[QUIModalPresentationViewController alloc] init];
            modalViewController.contentViewController = contentViewController;
            modalViewController.animationStyle = QUIModalPresentationAnimationStyleSlide; //从下向上
            // 以 presentViewController 的形式展示时，animated 要传 NO，否则系统的动画会覆盖 QUIModalPresentationAnimationStyle 的动画
            [self presentViewController: modalViewController animated:NO completion:NULL];
        }
            break;
        case 6: {
            //基于presentViewController弹框 + 内容是UINavigationController
            ConInAlertViewController *contentViewController = [[ConInAlertViewController alloc] init];
            AlertNavigationViewController *nav = [[AlertNavigationViewController alloc] initWithRootViewController:contentViewController];
            QUIModalPresentationViewController *modalViewController = [[QUIModalPresentationViewController alloc] init];
            modalViewController.contentViewController = nav;
            modalViewController.animationStyle = QUIModalPresentationAnimationStyleFade; //渐变
            // 以 presentViewController 的形式展示时，animated 要传 NO，否则系统的动画会覆盖 QUIModalPresentationAnimationStyle 的动画
            [self presentViewController:modalViewController animated:NO completion:NULL];
        }
            break;
        case 7:
        {
        }
            break;
        case 8:
        {
        }
            break;
        case 9:
        {
        }
            break;
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]
            initWithStyle:UITableViewCellStyleDefault
            reuseIdentifier:@""];
    cell.textLabel.numberOfLines = 0;
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = @"Alert弹框";
        }
            break;
        case 1:{
            cell.textLabel.text = @"Alert弹框 + UITextField";
        }
            break;
        case 2:{
            cell.textLabel.text = @"Alert弹框 + 内容是view + view是用xib约束";
        }
            break;
        case 3:{
            cell.textLabel.text = @"Alert弹框 + 内容是view + view是frame";
        }
            break;
        case 4:{
            cell.textLabel.text = @"基于presentViewController弹框 + 内容是自定义View";
        }
            break;
        case 5:
        {
            cell.textLabel.text = @"基于presentViewController弹框 + 内容是ViewController";
        }
            break;
        case 6:
        {
            cell.textLabel.text = @"基于presentViewController弹框 + 内容是UINavigationController";
        }
            break;
        default:
            break;
    }
    
    return cell;
}

//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}



@end
