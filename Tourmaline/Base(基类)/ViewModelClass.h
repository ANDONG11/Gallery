//
//  ViewModelClass.h
//  HSSYDemo
//
//  Created by previz on 16/5/4.
//  Copyright © 2016年 dongan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewModelClass : NSObject

@property (copy, nonatomic) ReturnValueBlock  returnBlock;
@property (copy, nonatomic) ErrorCodeBlock    errorBlock;
@property (copy, nonatomic) FailureBlock      failureBlock;
@property (copy, nonatomic) ProgressBlock     progressBlock;


//获取网络的链接状态
-(void) netWorkStateWithNetConnectBlock: (NetWorkBlock) netConnectBlock WithURlStr: (NSString *) strURl;

// 传入交互的Block块
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock;

- (void) setBlockWithProgressBlock: (ProgressBlock) progressBlock;
@end
