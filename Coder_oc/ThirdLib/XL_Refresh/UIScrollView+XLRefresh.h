//
//  UIScrollView+XLRefresh.h
//  XLRefresh
//
//  Created by 邓西亮 on 16/10/21.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLRefreshHeader;

@interface UIScrollView (XLRefresh)

@property (nonatomic, weak, readonly) XLRefreshHeader * header;

- (void)addRefreshHeaderWithHandle:(void (^)())handle;

@end
