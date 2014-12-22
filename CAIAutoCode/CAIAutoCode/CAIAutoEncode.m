//
//  normalCode.m
//  CAIAutoCode
//
//  Created by liyufeng on 14/12/22.
//  Copyright (c) 2014年 liyufeng. All rights reserved.
//

#import "CAIAutoEncode.h"
#import <objc/runtime.h>
@implementation CAIAutoEncode

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
        for (i=0; i<outCount; i++) {
            objc_property_t property = properties[i];
            NSString * propertyName = [[NSString alloc]initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
            id value = [aDecoder decodeObjectForKey:propertyName];
            NSError * error = nil;
            CAIValidateAndSetValue(self, propertyName, value, YES, &error);
            if (error) {
                NSLog(@"error:%@",error);
            }
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
    for (i=0; i<outCount; i++) {
        objc_property_t property = properties[i];
        NSString * propertyName = [[NSString alloc]initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
        id value = [self valueForKey:propertyName];
        if (value!=nil) {
            [coder encodeObject:value forKey:propertyName];
        }
    }
}

static BOOL CAIValidateAndSetValue(id obj, NSString *key, id value, BOOL forceUpdate, NSError **error) {
    __autoreleasing id validatedValue = value;
    @try {
        if (![obj validateValue:&validatedValue forKey:key error:error]) return NO;
        if (forceUpdate || value != validatedValue) {
            [obj setValue:validatedValue forKey:key];
        }
        return YES;
    } @catch (NSException *ex) {
        NSLog(@"*** Caught exception setting key \"%@\" : %@", key, ex);
        return NO;
    }
}


@end
