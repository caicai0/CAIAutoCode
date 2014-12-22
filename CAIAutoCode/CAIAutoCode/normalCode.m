//
//  normalCode.m
//  CAIAutoCode
//
//  Created by liyufeng on 14/12/22.
//  Copyright (c) 2014年 liyufeng. All rights reserved.
//

#import "normalCode.h"
#import "EXTRuntimeExtensions.h"
@implementation normalCode

//- (id)decodeObjectForKey:(NSString *)key;
//- (BOOL)decodeBoolForKey:(NSString *)key;
//- (int)decodeIntForKey:(NSString *)key;
//- (int32_t)decodeInt32ForKey:(NSString *)key;
//- (int64_t)decodeInt64ForKey:(NSString *)key;
//- (float)decodeFloatForKey:(NSString *)key;
//- (double)decodeDoubleForKey:(NSString *)key;

//- (void)encodeObject:(id)objv forKey:(NSString *)key;
//- (void)encodeBool:(BOOL)boolv forKey:(NSString *)key;
//- (void)encodeInt:(int)intv forKey:(NSString *)key;
//- (void)encodeInt32:(int32_t)intv forKey:(NSString *)key;
//- (void)encodeInt64:(int64_t)intv forKey:(NSString *)key;
//- (void)encodeFloat:(float)realv forKey:(NSString *)key;
//- (void)encodeDouble:(double)realv forKey:(NSString *)key;

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.numdouble = [aDecoder decodeDoubleForKey:@"numdouble"];
        
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
        id value = [aDecoder decodeObjectForKey:propertyName];
        NSError * error = nil;
        MTLValidateAndSetValue(self, propertyName, value, YES, &error);
        if (error) {
            NSLog(@"error:%@",error);
        }
    }
}

- (void)decoderWithCoder:(NSCoder *)aDecoder{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
    for (i=0; i<outCount; i++) {
        objc_property_t property = properties[i];
        NSString * propertyName = [[NSString alloc]initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
        id value = [aDecoder decodeObjectForKey:propertyName];
        NSError * error = nil;
        MTLValidateAndSetValue(self, propertyName, value, YES, &error);
        if (error) {
            NSLog(@"error:%@",error);
        }
    }
}

static BOOL MTLValidateAndSetValue(id obj, NSString *key, id value, BOOL forceUpdate, NSError **error) {
    __autoreleasing id validatedValue = value;
    
    @try {
        if (![obj validateValue:&validatedValue forKey:key error:error]) return NO;
        
        if (forceUpdate || value != validatedValue) {
            [obj setValue:validatedValue forKey:key];
        }
        
        return YES;
    } @catch (NSException *ex) {
        NSLog(@"*** Caught exception setting key \"%@\" : %@", key, ex);
        
        // Fail fast in Debug builds.
#if DEBUG
        @throw ex;
#else
        if (error != NULL) {
            *error = [NSError mtl_modelErrorWithException:ex];
        }
        
        return NO;
#endif
    }
}


@end
