//
//  UILabel+XLAtrtributeTextTap.h
//  DDTool
//
//  Created by ddSoul on 17/2/9.
//  Copyright © 2017年 邓西亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (XLAtrtributeTextTap)

/** 需要点击的字符串*/
- (void)xl_addAttributeTextTapActionWithString:(NSString *)string
                                        handle:(void (^)())handle;

@end
