//
//  QAlertViewController
//
//  Created by QDong on 2022-7-30.
//  Copyright (c) 2021年 QDong QQ:285275534@qq.com. All rights reserved.
//

#import "ConInAlertViewController.h"


@interface ConInAlertViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}


@end

@implementation ConInAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"导航栏";
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    if (@available(iOS 15.0, *)) {
        _tableView.sectionHeaderTopPadding = 0;
    }
    _tableView.showsHorizontalScrollIndicator = false;
    //设置列表数据源
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    BOOL shouldChangeTableViewFrame = !CGRectEqualToRect(self.view.bounds, _tableView.frame);
    if (shouldChangeTableViewFrame) {
        _tableView.frame = self.view.bounds;
    }
}

//返回列表分组数，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//返回列表每个分组section拥有cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ConInAlertViewController *vc = [ConInAlertViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]
            initWithStyle:UITableViewCellStyleDefault
            reuseIdentifier:@""];
    cell.textLabel.numberOfLines = 0;
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = @"《普通界面》";
        }
            break;
        case 1:{
            cell.textLabel.text = @"《普通界面 + 自定义面板》";
        }
            break;
        case 2:{
            cell.textLabel.text = @"《聊天界面》\n 特点1：弹出键盘时候tableview自动滚到底部\n 特点2：输入文字换行时候tableview也会往上移动";
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"《聊天界面 + tableview基于约束》";
        }
            break;
        case 4:
        {
            cell.textLabel.text = @"《朋友圈界面》\n 特点1：平时不显示底部输入栏\n 特点2：点击cell后显示输入栏，且当前cell自动滚动到输入栏上方\n 特点3：输入文字换行时候当前cell也会往上移动";
        }
            break;
        case 5:
        {
            cell.textLabel.text = @"《朋友圈界面 + 键盘一直在底部》\n别的特点和朋友圈一致";
        }
            break;
        case 6:
        {
            cell.textLabel.text = @"《发动态界面 + 底部是工具栏》\n 特点1：输入栏自定义\n 特点2：输入栏可一直在底部，也可以弹出键盘时候再显示";
        }
            break;
        case 7:
        {
            cell.textLabel.text = @"《TextField界面》";
        }
            break;
        case 8:
        {
            cell.textLabel.text = @"《输入条右边是“发送”按钮》";
        }
            break;
        case 9:
        {
            cell.textLabel.text = @"《Swift聊天界面》";
        }
            break;
        default:
            break;
    }
    
    return cell;
}

//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2 ||indexPath.row == 4 ||indexPath.row == 6 ){
        return 140;
    }
    return 60;
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
