//
//  BaseViewController.m
//  Tourmaline
//
//  Created by dongan on 16/6/6.
//  Copyright © 2016年 dongan. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  // 设置默认的背景颜色为白色
  [self.view setBackgroundColor:[UIColor whiteColor]];
  
  // navigationBar button
  self.leftNavigationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.leftNavigationBtn setFrame:CGRectMake(0, 0, 44, 44)];
  [self.leftNavigationBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
  [self.leftNavigationBtn addTarget:self
                             action:@selector(leftNavigationBtnClick:)
                   forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftNavigationBtn];
  self.navigationItem.leftBarButtonItem = leftBtnItem;
  

  self.rightNavigationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.rightNavigationBtn setFrame:CGRectMake(0, 0, 44, 44)];
  [self.rightNavigationBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
  [self.rightNavigationBtn addTarget:self
                              action:@selector(leftNavigationBtnClick:)
                    forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightNavigationBtn];
  self.navigationItem.rightBarButtonItem = rightBtnItem;
}

- (void)leftNavigationBtnClick:(UIButton *)leftNavigationBtn {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightNavigationBtnClick:(UIButton *)rightNavigationBtn {
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
