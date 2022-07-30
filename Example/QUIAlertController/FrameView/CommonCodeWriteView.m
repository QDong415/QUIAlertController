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
    _centerLabel.text = @"我是基于Frame写的UILabel、我是基于Frame写的UILabel、我是基于Frame写的UILabel、我是基于Frame写的UILabel、我是基于Frame写的UILabel";
    [self addSubview:_centerLabel];
    
}



@end
