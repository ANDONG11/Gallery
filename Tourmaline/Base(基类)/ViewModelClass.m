//
//  ViewModelClass.m
//  HSSYDemo
//
//  Created by previz on 16/5/4.
//  Copyright © 2016年 dongan. All rights reserved.
//

#import "ViewModelClass.h"

@implementation ViewModelClass

#pragma 获取网络可到达状态
-(void) netWorkStateWithNetConnectBlock: (NetWorkBlock) netConnectBlock WithURlStr: (NSString *) strURl {
//  BOOL netState = [NetRequestClass netWorkReachabilityWithURLString:strURl];
//  netConnectBlock(netState);
}

#pragma 接收穿过来的block
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock {
  _returnBlock = returnBlock;
  _errorBlock = errorBlock;
  _failureBlock = failureBlock;
}

- (void) setBlockWithProgressBlock: (ProgressBlock) progressBlock {
  _progressBlock = progressBlock;
}

@end
