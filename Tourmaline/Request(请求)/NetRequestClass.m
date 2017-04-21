//
//  NetRequestClass.m
//  Tourmaline
//
//  Created by dongan on 17/2/20.
//  Copyright © 2017年 dongan. All rights reserved.
//

#import "NetRequestClass.h"
#import "AFNetworking.h"

static AFHTTPSessionManager *manager;
@implementation NetRequestClass

#pragma mark - 检测网络的可链接性
+ (BOOL) netWorkReachabilityWithURLString:(NSString *)strUrl {
  __block BOOL netState = NO;
  
  NSURL *baseURL = [NSURL URLWithString:strUrl];
  AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
  NSOperationQueue *operationQueue = manager.operationQueue;
  
  [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    switch (status) {
      case AFNetworkReachabilityStatusReachableViaWWAN:
      case AFNetworkReachabilityStatusReachableViaWiFi:
        [operationQueue setSuspended:NO];
        netState = YES;
        break;
      case AFNetworkReachabilityStatusNotReachable:
        netState = NO;
      default:
        [operationQueue setSuspended:YES];
        break;
    }
  }];
  [manager.reachabilityManager startMonitoring];
  
  return netState;
}

#pragma mark - 网络请求配置
+ (void)setManager {
  if (!manager) {
    manager = [AFHTTPSessionManager manager];
    // 申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 申明请求的数据是json类型
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/json", @"text/javascript",@"text/html",
                                                         @"text/plain",@"text/xml", nil];
    // 设置网络超时时间为8s，默认为60s
    manager.requestSerializer.timeoutInterval = 8.f;
    // 采用https请求
//    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
//    securityPolicy.allowInvalidCertificates = YES;
//    manager.securityPolicy = securityPolicy;
  }
}

#pragma mark - 网络请求成功返回
+ (void)successWithResponse:(id)responseObject block:(ReturnValueBlock)block errorBlock:(ErrorCodeBlock)errorBlock {
  NSData *data = responseObject;
  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
  NSString *status = [dic objectForKey:@"statusCode"];
  if ([status isEqual:@"0000"]) {
    block(dic);
  }  else {
    errorBlock(status);
  }
}

#pragma mark - 网络请求失败返回
+ (void)failureWithBlock:(FailureBlock)failureBlock Error:(NSError*)error {
  NSLog(@"%@",error);
  failureBlock();
}

#pragma mark - GET请求方式
+ (void) netRequestGETWithRequestURL:(NSString *) requestURLString
                           Parameter:(NSDictionary *) parameter
                    ReturnValueBlock:(ReturnValueBlock) block
                      ErrorCodeBlock:(ErrorCodeBlock) errorBlock
                        FailureBlock:(FailureBlock) failureBlock {
  [NetRequestClass setManager];
  requestURLString = [requestURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  [manager GET:requestURLString
    parameters:parameter
      progress:^(NSProgress * _Nonnull downloadProgress) {
      } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [NetRequestClass successWithResponse:responseObject block:block errorBlock:errorBlock];
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NetRequestClass failureWithBlock:failureBlock Error:error];
      }];
}

#pragma mark - POST请求方式
+ (void) netRequestPOSTWithRequestURL:(NSString *) resuestURLString
                            Parameter:(NSDictionary *) parameter
                     ReturnValueBlock:(ReturnValueBlock) block
                       ErrorCodeBlock:(ErrorCodeBlock) errorBlock
                         FailureBlock:(FailureBlock)failureBlock {
  [NetRequestClass setManager];
  resuestURLString = [resuestURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  [manager POST:resuestURLString
     parameters:parameter
       progress:^(NSProgress * _Nonnull downloadProgress) {
       }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [NetRequestClass successWithResponse:responseObject block:block errorBlock:errorBlock];
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [NetRequestClass failureWithBlock:failureBlock Error:error];
       }];
}

#pragma mark - PUT请求方式
+ (void) netRequestPUTWithRequestURL:(NSString *) resuestURLString
                           Parameter:(NSDictionary *) parameter
                    ReturnValueBlock:(ReturnValueBlock) block
                      ErrorCodeBlock:(ErrorCodeBlock) errorBlock
                        FailureBlock:(FailureBlock) failureBlock {
  [NetRequestClass setManager];
  resuestURLString = [resuestURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  [manager PUT:resuestURLString
    parameters:parameter
       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [NetRequestClass successWithResponse:responseObject block:block errorBlock:errorBlock];
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [NetRequestClass failureWithBlock:failureBlock Error:error];
       }];
}

#pragma mark - DELETE请求方式
+ (void) netRequestDELETEWithRequestURL:(NSString *) resuestURLString
                              Parameter:(NSDictionary *) parameter
                       ReturnValueBlock:(ReturnValueBlock) block
                         ErrorCodeBlock:(ErrorCodeBlock) errorBlock
                           FailureBlock:(FailureBlock) failureBlock {
  [NetRequestClass setManager];
  resuestURLString = [resuestURLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  [manager DELETE:resuestURLString
       parameters:parameter
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [NetRequestClass successWithResponse:responseObject block:block errorBlock:errorBlock];
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [NetRequestClass failureWithBlock:failureBlock Error:error];
          }];
}

#pragma mark - POST image请求方式
+ (void) netRequestPOSTImageWithRequestURL:(NSString *) resuestURLString
                                 Parameter:(NSDictionary *) parameter
                                      name:(NSString *)name
                               imagesArray:(NSArray *)images
                          ReturnValueBlock:(ReturnValueBlock) block
                            ErrorCodeBlock:(ErrorCodeBlock) errorBlock
                              FailureBlock:(FailureBlock)failureBlock {
  [NetRequestClass setManager];
  [manager POST:resuestURLString
     parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
       for (UIImage *image in images) {
         // 设置时间格式(给个时间便于区分)
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         formatter.dateFormat = @"yyyyMMddHHmmss";
         NSString *fileName = [formatter stringFromDate:[NSDate date]];
         NSData *imageData;
         if (UIImagePNGRepresentation(image) == nil) {
           imageData = UIImageJPEGRepresentation(image, 1);
         } else {
           imageData = UIImagePNGRepresentation(image);
         }
         [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/png"];
       }
     } progress:^(NSProgress * _Nonnull uploadProgress) {
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       [NetRequestClass successWithResponse:responseObject block:block errorBlock:errorBlock];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       [NetRequestClass failureWithBlock:failureBlock Error:error];
     }];
}

#pragma mark - POST video请求方式
+ (void) netRequestPOSTVideoWithRequestURL:(NSString *) resuestURLString
                                 Parameter:(NSDictionary *) parameter
                               filePathURL:(NSURL *)filePathURL
                          ReturnValueBlock:(ReturnValueBlock) block
                            ErrorCodeBlock:(ErrorCodeBlock) errorBlock
                              FailureBlock:(FailureBlock)failureBlock
                             ProgressBlock:(ProgressBlock)progressBlock{
  [NetRequestClass setManager];
  [manager POST:resuestURLString
     parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
       // 设置时间格式(给个时间便于区分)
       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
       formatter.dateFormat = @"yyyyMMddHHmmss";
       NSString *fileName = [formatter stringFromDate:[NSDate date]];
       [formData appendPartWithFileURL:filePathURL name:@"name" fileName:fileName mimeType:@"application/octet-stream" error:nil];
     } progress:^(NSProgress * _Nonnull uploadProgress) {
       progressBlock(uploadProgress);
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       [NetRequestClass successWithResponse:responseObject block:block errorBlock:errorBlock];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       [NetRequestClass failureWithBlock:failureBlock Error:error];
     }];
}




@end
