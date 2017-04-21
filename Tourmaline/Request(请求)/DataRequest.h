//
//  DataRequest.h
//  Tourmaline
//
//  Created by 安东 on 2017/4/21.
//  Copyright © 2017年 dongan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewModelClass.h"

@interface DataRequest : ViewModelClass

- (void)loginWithAccount:(NSString *)account password:(NSString *)password;

@end
