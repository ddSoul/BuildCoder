//
//  XLRefreshHeader.h
//  XLRefresh
//
//  Created by 邓西亮 on 16/10/21.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+XLRefresh.h"

@interface XLRefreshHeader : UIView


UIKIT_EXTERN const CGFloat SURefreshHeaderHeight;
UIKIT_EXTERN const CGFloat SURefreshPointRadius;

@property (nonatomic, copy) void(^handle)();

#pragma mark - 停止动画
- (void)endRefreshing;

@end
