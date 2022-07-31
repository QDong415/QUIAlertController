//
//  QAlertViewController
//
//  Created by QDong on 2022-7-30.
//  Copyright (c) 2021年 QDong QQ:285275534@qq.com. All rights reserved.
//

#import "CommonCodeWriteView.h"

@interface CommonCodeWriteView ()


@property (nonatomic, strong) UILabel *centerLabel;


@end

@implementation CommonCodeWriteView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
     
    _centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _centerLabel.numberOfLines = 0;
    _centerLabel.text = @"黄色View是基于Frame代码写的UIView，中间是个UILabel。\n\n黄色View的宽高为200pt。整个Alert的宽高我设置为240pt\n\n以上参数都可以修改";
    [self addSubview:_centerLabel];
    
}



@end
