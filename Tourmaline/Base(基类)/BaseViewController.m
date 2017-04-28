//
//  BaseViewController.m
//  Tourmaline
//
//  Created by 安东 on 2017/2/20.
//  Copyright © 2017年 安东. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController () <UITableViewDelegate, UITableViewDataSource>

@property (copy,   nonatomic) leftNavigationClickBlock  leftNavBlock;
@property (copy,   nonatomic) rightNavigationClickBlock rightNavBlock;
@property (copy,   nonatomic) headerRefreshingBlock     headerBlock;
@property (copy,   nonatomic) footerRefreshingBlock     footerBlock;

@end

@implementation BaseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  // 设置默认的背景颜色为白色
  [self.view setBackgroundColor:[UIColor whiteColor]];
  
  // 设置navigationBar上title的颜色
  self.navigationController.navigationBar.titleTextAttributes =
  [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
}

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

#pragma mark - 右划返回手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
    return [self.navigationController.viewControllers count] > 1;
  }
  return YES;
}

#pragma mark - navigationBar button left
- (void)showLeftNavBtnWithClick:(leftNavigationClickBlock)leftClickBlock {
  
  [self leftNavigationBtn];
  self.leftNavBlock = leftClickBlock;
}

#pragma mark - navigationBar button right
- (void)showRightNavBtnWithClick:(rightNavigationClickBlock)rightClickBlock {
  
  [self rightNavigationBtn];
  self.rightNavBlock = rightClickBlock;
}

#pragma mark - navigationBar 左右按钮点击事件
- (void)leftNavigationBtnClick:(UIButton *)leftNavigationBtn {
  
  if (self.leftNavBlock) {
    self.leftNavBlock(leftNavigationBtn);
  } else {
    [self.navigationController popViewControllerAnimated:YES];
  }
}

- (void)rightNavigationBtnClick:(UIButton *)rightNavigationBtn {
  if (self.rightNavBlock) {
    self.rightNavBlock(rightNavigationBtn);
  }
}


#pragma mark tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return ZERO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 刷新
- (void)tableViewHeaderRefreshWithTableView:(UIScrollView *)tableView
                           headerClickBlock:(headerRefreshingBlock)block {
  MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                   refreshingAction:@selector(headerRefreshing)];
  header.stateLabel.font = ADFont(15.f);
  header.lastUpdatedTimeLabel.hidden = YES;
  [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
  [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
  [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
  tableView.mj_header = header;
  self.headerBlock = block;
}

#pragma mark - 加载
- (void)tableViewFooterRefreshWithTableView:(UIScrollView *)tableView
                           footerClickBlock:(footerRefreshingBlock)block {
  MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self
                                                                           refreshingAction:@selector(footerRefreshing)];
  footer.stateLabel.font = ADFont(15.f);
  [footer setTitle:@"上拉刷新" forState:MJRefreshStateIdle];
  [footer setTitle:@"释放更新" forState:MJRefreshStatePulling];
  [footer setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
  [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
  tableView.mj_footer = footer;
  self.footerBlock = block;
}

#pragma mark 开始进入刷新状态
- (void)headerRefreshing {
  self.headerBlock();
}

- (void)footerRefreshing {
  self.footerBlock();
}

#pragma mark - tableview 停止刷新
- (void)tableViewEndRefreshingWithNewCount:(NSInteger)count {
  [self.tableView.mj_header endRefreshing];
  if (count == ZERO) {
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
  } else {
    [self.tableView.mj_footer endRefreshing];
  }
}

#pragma mark - 创建tableview  tableview懒加载
- (UITableView *)tableView {
  if (!_tableView) {
    _tableView = [[UITableView alloc] init];
    [_tableView setFrame:self.view.frame];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setTableFooterView:[[UIView alloc] init]];
    [_tableView setShowsVerticalScrollIndicator:NO];
    [_tableView setRowHeight:ZERO];
//    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
  }
  return _tableView;
}

#pragma mark - getters and setters
- (NSMutableArray *)dataSource {
  if (!_dataSource) {
    _dataSource = [NSMutableArray array];
  }
  return _dataSource;
}

- (DataRequest *)dataRequest {
  if (!_dataRequest) {
    _dataRequest = [[DataRequest alloc] init];
  }
  return _dataRequest;
}

-(UIButton *)leftNavigationBtn {
  if (!_leftNavigationBtn) {
    _leftNavigationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftNavigationBtn setFrame:CGRectMake(ZERO, ZERO, BASEHEIGHT, BASEHEIGHT)];
    [_leftNavigationBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_leftNavigationBtn setImage:[UIImage imageNamed:@"nav_button_left_back_default"] forState:UIControlStateNormal];
    [_leftNavigationBtn setImage:[UIImage imageNamed:@"nav_button_left_back_pressed"] forState:UIControlStateHighlighted];
    [_leftNavigationBtn addTarget:self
                           action:@selector(leftNavigationBtnClick:)
                 forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:_leftNavigationBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
  }
  return _leftNavigationBtn;
}

-(UIButton *)rightNavigationBtn {
  if (!_rightNavigationBtn) {
    _rightNavigationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightNavigationBtn setFrame:CGRectMake(ZERO, ZERO, BASEHEIGHT, BASEHEIGHT)];
    [_rightNavigationBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_rightNavigationBtn addTarget:self
                            action:@selector(rightNavigationBtnClick:)
                  forControlEvents:UIControlEventTouchUpInside];
    [_rightNavigationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[_rightNavigationBtn titleLabel] setFont:ADFont(16.f)];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:_rightNavigationBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
  }
  return _rightNavigationBtn;
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
