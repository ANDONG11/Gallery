//
//  ViewController.m
//  Tourmaline
//
//  Created by previz on 16/5/16.
//  Copyright © 2016年 dongan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  // 所有controller都用继承BaseViewController 
  self.navigationItem.title = @"登录";
  [self showRightNavBtnWithClick:^(id sender) {
    NSLog(@"right click");
  }];
  [self.rightNavigationBtn setTitle:@"right" forState:UIControlStateNormal];
  
  DefineWeakSelf;
  [self.tableView setRowHeight:60];
  [self tableViewHeaderRefreshWithTableView:self.tableView headerClickBlock:^{
    [weakSelf tableViewEndRefreshingWithNewCount:ZERO];
  }];
  
  // 请求数据
  [self.dataRequest loginWithAccount:@"111" password:@"000"];
  [self.dataRequest setBlockWithReturnBlock:^(id returnValue) {
    
  } WithErrorBlock:^(id errorCode) {
    
  } WithFailureBlock:^{
    NSLog(@"没写链接啊 怎么能访问");
  }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return 10;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
