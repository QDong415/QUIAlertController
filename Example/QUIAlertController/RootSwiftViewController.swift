//
//  QUITableViewController.swift
//  QSwift
//
//  Created by QDong on 2021/3/25.
//

import Foundation
import UIKit
import QUIAlertController

@objc class RootSwiftViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let reuseIdentifier = "UITableViewCell"
    
    private(set) var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    
    func initTableView() {
        tableView = UITableView.init(frame: view.bounds, style: .plain)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:reuseIdentifier)
        
        //移除底部多余的separator
        if(tableView.style == UITableView.Style.plain){
            let footerView: UIView = UIView();
            tableView.tableFooterView = footerView;
        }
        
        tableView.delegate = self;
        tableView.dataSource = self;
        view.addSubview(tableView)
    }
    
    
    //旋转屏幕，和 第一次的willAppear和didAppear中间 都会调用这个方法；app进入后台1秒后，会调用4次这个方法
    //如果tableview不是用约束add上去的，那么一定要在这里重新设置frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        //测试结果：约束布局下 tbf =  (0.0, 0.0, 390.0, 844.0)；frame下可能需要frame =
        let shouldChangeTableViewFrame: Bool = !self.view.bounds.equalTo(tableView.frame);
        if (shouldChangeTableViewFrame) {
            tableView.frame = self.view.bounds;
        }
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // 分别测试过 iOS 11 前后的系统版本，最终总结，对于 Plain 类型的 tableView 而言，要去掉 header / footer 请使用 0，对于 Grouped 类型的 tableView 而言，要去掉 header / footer 请使用 CGFLOAT_MIN
        return tableView.style == UITableView.Style.plain ? 0 : CGFloat.leastNormalMagnitude;
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // 分别测试过 iOS 11 前后的系统版本，最终总结，对于 Plain 类型的 tableView 而言，要去掉 header / footer 请使用 0，对于 Grouped 类型的 tableView 而言，要去掉 header / footer 请使用 CGFLOAT_MIN
        return tableView.style == UITableView.Style.plain ? 0 : 8;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.numberOfLines = 0
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Alert弹框"
        case 1:
            cell.textLabel?.text = "Alert弹框 + UITextField"
        case 2:
            cell.textLabel?.text = "Alert弹框 + 内容是view + view是用xib约束"
        case 3:
            cell.textLabel?.text = "Alert弹框 + 内容是view + view是frame"
        case 4:
            cell.textLabel?.text = "基于presentViewController弹框 + 内容是自定义View"
        case 5:
            cell.textLabel?.text = "基于presentViewController弹框 + 内容是ViewController"
        case 6:
            cell.textLabel?.text = "基于presentViewController弹框 + 内容是UINavigationController"
            
        default:
            break
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 0:
            let alertController = QUIAlertController(title: "Alert标题", message: "不用系统的，就可以非常灵活的定制弹框的所有UI属性，避免和效果图不一致", preferredStyle: .alert)
            //点击黑色背景隐藏
            alertController.shouldRespondMaskViewTouch = true

            //添加一个取消按钮
            let cancelAction = QUIAlertAction(title: "我知道了", style: .cancel, handler: nil)
            //可以为这个取消按钮设置按钮颜色、字体大小。如果不设置，默认是浅蓝色
            cancelAction.buttonAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
                NSAttributedString.Key.kern: NSNumber(value: 0)
            ]

            alertController.addAction(cancelAction)

            //添加一个确认按钮
            alertController.addAction(QUIAlertAction(title: "确定", style: .destructive, handler: { (alertController: QUIAlertController, action: QUIAlertAction) in

            }))

            alertController.showWith(animated: true)
            
        case 1:
            // Alert弹框 + UITextField
            let alertController = QUIAlertController(title: "请输入账号信息", message: "两项填写一项即可", preferredStyle: .alert)

            alertController.addAction(QUIAlertAction(title: "确定", style: .destructive, handler: { alertController, action in
                if let text = alertController.textFields![0].text {
                    print("\(text)")
                }
            }))
            alertController.addCancelAction()
            alertController.addTextField(configurationHandler: { textField in
                textField.placeholder = "账号"
            })
            alertController.addTextField(configurationHandler: { textField in
                textField.placeholder = "密码"
            })

            // 输入框的布局默认是贴在一起的，默认不需要修改，这里只是展示可以通过这个 block 自行调整。
            alertController.alertTextFieldMarginBlock = { alertController, aTextFieldIndex in
                var margin: UIEdgeInsets = .zero
                if aTextFieldIndex == alertController.textFields!.count - 1 {
                    margin.bottom = 16
                } else {
                    margin.bottom = 6
                }
                return margin
            }

            alertController.showWith(animated: true)
            
        case 2:
            // Alert弹框 + 内容是view + view是用xib约束
            let thirdView = UINib(nibName: "ThirdView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ThirdView

            //实际开发中，你往往希望：弹框的高度 == 在xib里手动拉好的高度。弹框的宽度 == 屏幕宽度 - 20 - 20
            //所以我们需要设置 弹框的宽度 = xibView的宽度 = 屏幕宽度 - 40
            let alertWidth: CGFloat = self.view.frame.size.width - 40
            
            //必须外面再套一层，然后设置autoresizingMask。这样alert的高度就是xib你手动拉出来的高度
            let containerView = UIView(frame: thirdView.frame)
            thirdView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            containerView.addSubview(thirdView)
            
            //然后重设包裹层的frame，利用autoresizing的特性，让xibView的宽高等比例缩放
            containerView.frame = CGRect.init(x: 0, y: 0, width: alertWidth, height: thirdView.frame.size.height);

            let action1 = QUIAlertAction(title: "取消", style: .cancel, handler: nil)
            let action2 = QUIAlertAction(title: "确定", style: .destructive, handler: { alertController, action in
            })
            let alertController = QUIAlertController(title: nil, message: nil, preferredStyle: .alert)

            //Alert弹框的最大宽度。这样设置的话就等于左右20pt空隙
            alertController.alertContentMaximumWidth = alertWidth
            //不需要顶部的提示语
            alertController.alertHeaderInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

            alertController.addAction(action1)
            alertController.addAction(action2)
            alertController.addCustomView(containerView)
            alertController.showWith(animated: true)
            
        case 3:
            // Alert弹框 + 内容是view + view是frame
            let thirdView = CommonCodeWriteView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            thirdView.backgroundColor = UIColor.yellow
            let action2 = QUIAlertAction(title: "确定", style: .destructive, handler: { alertController, action in
            })
            let alertController = QUIAlertController(title: nil, message: nil, preferredStyle: .alert)

            //CustomView宽度我上面设置的是200，整个alertView的宽度我设置的是240，所以左右有20的内间距
            alertController.alertContentMaximumWidth = 240

            alertController.addCustomView(thirdView)
            alertController.addAction(action2)
            alertController.showWith(animated: true)
            
        case 4:
            // 基于presentViewController弹框 + 内容是自定义View
            let thirdView = CommonCodeWriteView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
            thirdView.backgroundColor = UIColor.yellow

            let modal2ViewController = QUIModalPresentationViewController()
            modal2ViewController.contentView = thirdView
            modal2ViewController.animationStyle = .popup //中心弹出
            // 以 presentViewController 的形式展示时，animated 要传 NO，否则系统的动画会覆盖 QUIModalPresentationAnimationStyle 的动画
            present(modal2ViewController, animated: false)
            
        case 5:
            // 基于presentViewController弹框 + 内容是ViewController
            let contentViewController = ConInAlertViewController();
            let modalViewController = QUIModalPresentationViewController();
            modalViewController.contentViewController = contentViewController;
            modalViewController.animationStyle = .slide; //从下向上
            // 以 presentViewController 的形式展示时，animated 要传 NO，否则系统的动画会覆盖 QUIModalPresentationAnimationStyle 的动画
            present(modalViewController, animated: false)
        
        case 6:
            //基于presentViewController弹框 + 内容是UINavigationController
            let contentViewController = ConInAlertViewController();
            let nav = AlertNavigationViewController(rootViewController: contentViewController);
            let modalViewController = QUIModalPresentationViewController();
            modalViewController.contentViewController = nav;
            modalViewController.animationStyle = .fade; //渐变
            // 以 presentViewController 的形式展示时，animated 要传 NO，否则系统的动画会覆盖 QUIModalPresentationAnimationStyle 的动画
            present(modalViewController, animated: false)
        
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
    deinit {
        tableView.delegate = nil
        tableView.dataSource = nil
    }
}
