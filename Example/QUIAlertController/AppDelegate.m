//
//  QAlertViewController
//
//  Created by QDong on 2022-7-30.
//  Copyright (c) 2021年 QDong QQ:285275534@qq.com. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

//为了能在OC里调用Swift的方法. "XXX-Swift.h" ,XXX 是 Build Setting->Product Name
#import "QUIAlertController_Example-Swift.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //OC版本
    RootViewController *vc = [[RootViewController alloc] init];
    
    //Swift版本
    //RootSwiftViewController *vc = [[RootSwiftViewController alloc] init];
    
    [self.window setRootViewController:vc];
    [self.window makeKeyAndVisible];
    return YES;
}



@end
