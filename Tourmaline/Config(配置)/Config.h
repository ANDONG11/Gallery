//
//  Config.h
//  Tourmaline
//
//  Created by dongan on 16/6/6.
//  Copyright © 2016年 dongan. All rights reserved.
//

#ifndef Config_h
#define Config_h


#define SCREENWIDTH         [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT        [UIScreen mainScreen].bounds.size.height
#define NAVIGATIONBARHEIGHT  64
#define BASEHEIGHT           44
#define ZERO                 0
#define DefineWeakSelf __weak __typeof(self) weakSelf = self


#define SizeScale (SCREENWIDTH == 414 ? 1 : (SCREENWIDTH == 320 ? 0.8 : 0.9))
#define ADFont(value) [UIFont systemFontOfSize:value * SizeScale weight:UIFontWeightThin]
// 定义返回请求数据的block类型
typedef void (^ReturnValueBlock)(id returnValue);
typedef void (^ErrorCodeBlock)(id errorCode);
typedef void (^ProgressBlock)(id progress);
typedef void (^FailureBlock)();
typedef void (^NetWorkBlock)(id netConnetState);

#endif /* Config_h */
