//
//  BaseViewController.h
//  Tourmaline
//
//  Created by 安东 on 2017/2/20.
//  Copyright © 2017年 安东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@class DataRequest;

typedef void (^leftNavigationClickBlock)(id sender);
typedef void (^rightNavigationClickBlock)(id sender);
typedef void (^headerRefreshingBlock)();
typedef void (^footerRefreshingBlock)();


/**
 父类controller 所有controller都继承与此controller
 */
@interface BaseViewController : UIViewController


/**
 数据源
 */
@property (strong, nonatomic) NSMutableArray     *dataSource;

/**
 数据请求
 */
@property (strong, nonatomic) DataRequest        *dataRequest;



/**
 表示图
 */
@property (strong, nonatomic) UITableView    *tableView;


/**
 navigation left button
 */
@property (strong, nonatomic) UIButton      *leftNavigationBtn;

/**
 navigation right button
 */
@property (strong, nonatomic) UIButton      *rightNavigationBtn;


/**
 显示navigation left button

 @param leftClickBlock left button click block
 */
- (void)showLeftNavBtnWithClick:(leftNavigationClickBlock)leftClickBlock;


/**
 显示navigation right button

 @param rightClickBlock right button click block
 */
- (void)showRightNavBtnWithClick:(rightNavigationClickBlock)rightClickBlock;



/**
 提示

 @param text 文字
 @param isHidden 显示完是否隐藏
 */
- (void) promptHudViewWithText:(NSString *)text isHidden:(BOOL)isHidden;

/**
 隐藏提示
 */
- (void)promptHudViewHide;

/**
 刷新

 @param tableView 需要刷新的控件 tableview collectionview
 @param block 刷新回调
 */
- (void)tableViewHeaderRefreshWithTableView:(UIScrollView *)tableView
                           headerClickBlock:(headerRefreshingBlock)block;

/**
 加载

 @param tableView 需要刷新的控件 tableview collectionview
 @param block 加载回调
 */
- (void)tableViewFooterRefreshWithTableView:(UIScrollView *)tableView
                           footerClickBlock:(footerRefreshingBlock)block;


/**
 停止刷新

 @param count 新请求的数据个数
 */
- (void)tableViewEndRefreshingWithNewCount:(NSInteger)count;


@end
