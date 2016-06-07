//
//  BaseViewController.h
//  Tourmaline
//
//  Created by dongan on 16/6/6.
//  Copyright © 2016年 dongan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 *   navigation left right button
 */
@property (strong, nonatomic) UIButton      *leftNavigationBtn;
@property (strong, nonatomic) UIButton      *rightNavigationBtn;

/**
 *  @param leftNavigationBtn
 *  导航栏左侧button的点击事件
 */
- (void)leftNavigationBtnClick:(UIButton *)leftNavigationBtn;

/**
 *  @param rightNavigationBtn
 *  导航栏右侧button的点击事件
 */
- (void)rightNavigationBtnClick:(UIButton *)rightNavigationBtn;

@end
