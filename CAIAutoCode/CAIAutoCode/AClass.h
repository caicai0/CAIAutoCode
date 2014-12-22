//
//  AClass.h
//  CAIAutoCode
//
//  Created by 李玉峰 on 14/12/22.
//  Copyright (c) 2014年 liyufeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAIAutoEncode.h"

@interface AClass : CAIAutoEncode

@property (nonatomic, strong)NSString * string;
@property (nonatomic, assign)NSInteger integer;
@property (nonatomic, assign)float numFloat;
@property (nonatomic, assign)double numDouble;

@end
