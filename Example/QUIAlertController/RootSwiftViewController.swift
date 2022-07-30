//
//  QUITableViewController.swift
//  QSwift
//
//  Created by QDong on 2021/3/25.
//

import Foundation
import UIKit
import QUIAlertController

class RootSwiftViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let reuseIdentifier = "UITableViewCell"
    
    private(set) var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    
    func initTableView() {
        tableView = UITableView.init(frame: view.bounds, style: .plain)
        
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
        cell.textLabel?.text = "ddd"
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
            alertController.addAction(QUIAlertAction(title: "确定", style: .destructive, handler: { alertController, action in

            }))

            alertController.showWith(animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    
    deinit {
        tableView.delegate = nil
        tableView.dataSource = nil
    }
}
