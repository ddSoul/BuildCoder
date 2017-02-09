//
//  UILabel+XLAtrtributeTextTap.m
//  DDTool
//
//  Created by ddSoul on 17/2/9.
//  Copyright © 2017年 邓西亮. All rights reserved.
//

#import "UILabel+XLAtrtributeTextTap.h"
#import <objc/runtime.h>

@implementation UILabel (XLAtrtributeTextTap)

static char *KMarginTop     = "KMarginTop";
static char *KMarginLeft    = "KMarginLeft";
static char *KMarginRight   = "KMarginRight";
static char *KLineSpace     = "KLineSpace";
static char *KString        = "KString";


/** runtime添加属性
 *  可能后续需要用到下属性
 *  marginTop文字区的上边距
 *  lineSpace行间距
 *  handle点击之后的处理
 *  isTapAction是否已经点击
 *  tapString点击的文字部分
 */
- (void)setMarginTop:(NSInteger)marginTop
{
    objc_setAssociatedObject(self, &KMarginTop, @(marginTop), OBJC_ASSOCIATION_ASSIGN);
}
- (NSInteger)marginTop
{
    return [objc_getAssociatedObject(self, &KMarginTop) integerValue];
}
- (void)setMarginLeft:(NSInteger)marginLeft
{
    objc_setAssociatedObject(self, &KMarginLeft, @(marginLeft), OBJC_ASSOCIATION_ASSIGN);
}
- (NSInteger)marginLeft
{
    return [objc_getAssociatedObject(self, &KMarginLeft) integerValue];
}
- (void)setMarginRight:(NSInteger)marginRight
{
    objc_setAssociatedObject(self, &KMarginRight, @(marginRight), OBJC_ASSOCIATION_ASSIGN);
}
- (NSInteger)marginRight
{
    return [objc_getAssociatedObject(self, &KMarginRight) integerValue];
}
- (void)setLineSpace:(NSInteger)lineSpace
{
    objc_setAssociatedObject(self, &KLineSpace, @(lineSpace), OBJC_ASSOCIATION_ASSIGN);
}
- (NSInteger)lineSpace
{
    return [objc_getAssociatedObject(self, &KLineSpace) integerValue];
}
- (void (^)())handle
{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setHandle:(void (^)())handle
{
    objc_setAssociatedObject(self, @selector(handle), handle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL)isTapAction
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setIsTapAction:(BOOL)isTapAction
{
    objc_setAssociatedObject(self, @selector(isTapAction), @(isTapAction), OBJC_ASSOCIATION_ASSIGN);
}
- (void)setTapString:(NSString *)tapString
{
    objc_setAssociatedObject(self, &KString, tapString , OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)tapString
{
    return objc_getAssociatedObject(self, &KString);
}


/** 需要点击的字符串*/
- (void)xl_addAttributeTextTapActionWithString:(NSString *)string
                                        handle:(void (^)())handle
{
    self.isTapAction = YES;
    self.tapString = string;
    
    if (self.handle != handle) {
        self.handle = handle;
    }
}

/** 对tapPoint进行对比判断 */
- (void)xL_containPointHandle:(CGPoint)point
{
    if (!self.isTapAction) {
        return;
    }
    
    UIFont *font = [UIFont systemFontOfSize:self.font.pointSize];
    
    NSArray *stringArray = [self.text componentsSeparatedByString:self.tapString];
    
    NSString *beforeString = [stringArray objectAtIndex:0];
    
    CGFloat beforeSizeW = [self getSizeWidthWithLabelString:beforeString
                                                       font:font];
    
    CGFloat sizeW = [self getSizeWidthWithLabelString:self.tapString
                                                 font:font];
    
    CGFloat sizeH = [self getSizeHeightWithLabelString:self.text
                                                  font:font];
    self.marginTop = (self.frame.size.height - sizeH)/2;
    
    //    NSInteger lineCount = sizeH.height/font.lineHeight;
    CGRect rect = CGRectMake(beforeSizeW, self.marginTop, sizeW, font.lineHeight);
    
    if (CGRectContainsPoint(rect, point)){
        self.handle();
    }
    
}
//** 计算size*/
- (CGFloat)getSizeWidthWithLabelString:(NSString *)string font:(UIFont *)font
{
    CGSize size = [string sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil]];
    return size.width;
}
- (CGFloat)getSizeHeightWithLabelString:(NSString *)string font:(UIFont *)font
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:font}
                                       context:nil].size;
    return size.height;
}

///** 重写系统HitTest:Event方法*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    [self xL_containPointHandle:point];
    
    return [super hitTest:point withEvent:event];
}

@end
