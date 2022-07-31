# QUIAlertController

[![CI Status](https://img.shields.io/travis/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/QUIAlertController.svg?style=flat)](https://travis-ci.org/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/QUIAlertController)
[![Version](https://img.shields.io/cocoapods/v/QUIAlertController.svg?style=flat)](https://cocoapods.org/pods/QUIAlertController)
[![License](https://img.shields.io/cocoapods/l/QUIAlertController.svg?style=flat)](https://cocoapods.org/pods/QUIAlertController)
[![Platform](https://img.shields.io/cocoapods/p/QUIAlertController.svg?style=flat)](https://cocoapods.org/pods/QUIAlertController)


## 功能：
- ✅放弃系统的UIAlertController，采用自定义UIViewController。这样所有属性都自由修改，比如`间距`，`弹框大小`，`内容margin`、`padding`等等
- ✅Alert的内容可以是View，且View可以是 基于`xib约束` 或 `手写frame`。并实现自由设置View宽高
- ✅实际开发中，你往往希望：`弹框里的内容` == xib(或者手写View) + 下面有个确认按钮 &&  `弹框的高度` == 在xib里手动拉好的高度 && `弹框的宽度` == 屏幕宽度 - 20pt - 20pt 。 本demo都支持
- ✅Alert的内容可以是`UIViewController`和`UINavigationController`
- ✅支持Swift

## 效果图

![](https://upload-images.jianshu.io/upload_images/26002059-8b07744861b41938.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/26002059-1943eb53087fff4a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/26002059-836d5b1d84bab6e5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/26002059-af8d6de6adf3f29b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/26002059-dd36b42bab3f15b9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![](https://upload-images.jianshu.io/upload_images/26002059-b8f1238e4509f743.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![](https://upload-images.jianshu.io/upload_images/26002059-61f6c1a4c99d051e.gif?imageMogr2/auto-orient/strip)


## 介绍：
- 本案很多代码出自QMUI，我在它的基础上进行了解耦，精简，修改不合理的部分，并让它支持xib约束
-  每次弹框主要是弹出两个UIViewController：大UIViewController包含AlertContent（即小UIViewController） + 黑色背景DimmingView。
- 每次showAlert的时候，核心逻辑是：
```
- (void) showAlert(){
    大UIViewController.contentView = 小UIViewController;
    UIWindow *window = [[UIWindow alloc] init];
    window.windowLevel = UIWindowLevelAlert;
    window.rootViewController = 大UIViewController;
    [window makeKeyAndVisible];
    self.window = window;
}

- (void) hideAlert(){
      self.window.hidden = YES;
      self.window.rootViewController = nil;
}

```


## 安装

先在终端里搜索 `pod search QUIAlertController ` 

如果搜索不到，需要更新你电脑的pod仓库，以下是更新步骤：
- 先 `pod repo update —verbose`  更新你本地电脑的pod仓库。然后再搜索一次试试看
- 如果还是搜索不到，执行 `rm ~/Library/Caches/CocoaPods/search_index.json` 。再搜索就OK了

## 调用方式：

普通title + message + 确认取消button：
```Objective-C
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
```
---

Alert弹框 + 内容是view + view是用xib约束：
```Objective-C
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
            
QUIAlertAction *action2 = [QUIAlertAction actionWithTitle:@"确定" style:QUIAlertActionStyleDestructive handler:^(QUIAlertController *alertController, QUIAlertAction *action) {
}];
QUIAlertController *alertController = [QUIAlertController alertControllerWithTitle:nil message:nil preferredStyle:QUIAlertControllerStyleAlert];
            
//Alert弹框的最大宽度。这样设置的话就等于左右20pt空隙
alertController.alertContentMaximumWidth = alertWidth;
//不需要顶部的提示语
alertController.alertHeaderInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            
[alertController addAction:action2];
[alertController addCustomView:containerView];
[alertController showWithAnimated:YES];
```

## 导入方式
```ruby
pod 'QUIAlertController'
```


## Author：DQ  
我的其他开源库，给个Star鼓励我写更多好库：

[IOS 1:1完美仿微信聊天表情键盘](https://github.com/QDong415/QKeyboardEmotionView)

[IOS 自定义UIAlertController，支持弹出约束XibView、弹出ViewController](https://github.com/QDong415/QUIAlertController)

[IOS 基于个推+华为push的一整套完善的 IM聊天系统](https://github.com/QDong415/iTopicOCChat)

[Android 朋友圈列表Feed流的最优化方案，让你的RecyclerView从49帧 -> 57帧](https://github.com/QDong415/QFeed)

[Android 仿大众点评、仿小红书 下拉拖拽关闭Activity](https://github.com/QDong415/QDragClose)

[Android 仿快手直播间手画礼物，手绘礼物](https://github.com/QDong415/QDrawGift)

[Android 直播间聊天消息列表RecyclerView。一秒内收到几百条消息依然不卡顿](https://github.com/QDong415/QLiveMessageHelper)

[Android 仿快手直播界面加载中，顶部的滚动条状LoadingView](https://github.com/QDong415/QStripeView)

[Android Kotlin MVVM框架，全世界最优化的分页加载接口、最接地气的封装](https://github.com/QDong415/QKotlin)

[Android 基于个推+华为push的一整套完善的android IM聊天系统](https://github.com/QDong415/iTopicChat)
