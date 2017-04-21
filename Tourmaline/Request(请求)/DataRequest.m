//
//  DataRequest.m
//  Tourmaline
//
//  Created by 安东 on 2017/4/21.
//  Copyright © 2017年 dongan. All rights reserved.
//

#import "DataRequest.h"
#import "NetRequestClass.h"

typedef void (^successReturnBlock)(id returnValue);

@interface DataRequest()

@property (copy, nonatomic) successReturnBlock  successBlock;

@end
@implementation DataRequest

#pragma mark - 发送请求
- (void)netRequestBlockWithUrl:(NSString *)url paramter:(NSDictionary *)paramter successBlock:(successReturnBlock)block {
  [NetRequestClass netRequestPOSTWithRequestURL:url
                                      Parameter:paramter
                               ReturnValueBlock:^(id returnValue) {
                                 block(returnValue);
                               } ErrorCodeBlock:^(id errorCode) {
                                 self.errorBlock(errorCode);
                               } FailureBlock:^{
                                 self.failureBlock();
                               }];
}

#pragma mark - 登录
- (void)loginWithAccount:(NSString *)account password:(NSString *)password {
  
  NSString *url = @"http://";
  NSDictionary *paramter = @{@"account":account,
                             @"passWord":password};
  DefineWeakSelf;
  [self netRequestBlockWithUrl:url paramter:paramter successBlock:^(id returnValue) {
    weakSelf.returnBlock(returnValue);
  }];
}

@end
