//
//  UIScrollView+XLRefresh.m
//  XLRefresh
//
//  Created by 邓西亮 on 16/10/21.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "UIScrollView+XLRefresh.h"
#import "XLRefreshHeader.h"
#import <objc/runtime.h>

@implementation UIScrollView (XLRefresh)

- (void)addRefreshHeaderWithHandle:(void (^)())handle {
    
    XLRefreshHeader * header = [[XLRefreshHeader alloc]init];
    header.handle = handle;
    self.header = header;
    [self insertSubview:header atIndex:0];
}

#pragma mark - Associate
- (void)setHeader:(XLRefreshHeader *)header {
    objc_setAssociatedObject(self, @selector(header), header, OBJC_ASSOCIATION_ASSIGN);
}

- (XLRefreshHeader *)header {
    return objc_getAssociatedObject(self, @selector(header));
}

#pragma mark - Swizzle
+ (void)load {
    Method originalMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method swizzleMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"su_dealloc"));
    method_exchangeImplementations(originalMethod, swizzleMethod);
}

- (void)su_dealloc {
    self.header = nil;
    [self su_dealloc];
}

@end
