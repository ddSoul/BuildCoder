//
//  UILabel+XLAtrtributeTextTap.m
//  DDTool
//
//  Created by ddSoul on 17/2/9.
//  Copyright © 2017年 邓西亮. All rights reserved.
//

#import "UILabel+XLAtrtributeTextTap.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger ,XLTapStringLocationType){
    XLTapStringLocationWithEquleLine,
    XLTapStringLocationWithDifferentLines,
};

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
    self.tapString   = string;
    
    if (self.handle != handle) {
        self.handle  = handle;
    }
}

/** 对tapPoint进行对比判断 */
- (void)xL_containPointHandle:(CGPoint)point
{
    if (!self.isTapAction) {
        return;
    }
    
    BOOL isResponse;
    
    if ([self isLocateEqualLineWithTapString:self.tapString]) {
        isResponse =  [self isContainsPoint:point
                               locationType:XLTapStringLocationWithEquleLine];
    }else{
        isResponse = [self isContainsPoint:point
                              locationType:XLTapStringLocationWithDifferentLines];
    }
    
    if (isResponse) {
        self.handle();
    }
}

//** 判断所要点击的文字是否在一行*/
- (BOOL)isLocateEqualLineWithTapString:(NSString *)string
{
    NSString *firstAtString    = [string substringToIndex:1];
    NSString *beforeString     = [[self xl_componentsSeparatedByString:self.tapString] objectAtIndex:0];
    NSString *splStringWithf   = [NSString stringWithFormat:@"%@%@",beforeString,firstAtString];
    NSString *splStringWithA   = [NSString stringWithFormat:@"%@%@",beforeString,string];
    CGFloat  splStringWithAFH  = [self getSizeHeightWithLabelString:splStringWithf
                                                               font:[UIFont systemFontOfSize:self.font.pointSize]];
    CGFloat  splStringWithAH   = [self getSizeHeightWithLabelString:splStringWithA
                                                               font:[UIFont systemFontOfSize:self.font.pointSize]];
    if (splStringWithAFH == splStringWithAH) {
        return YES;
    }
    return NO;
}

//** 点击字符串判断包含关系*/
- (BOOL)isContainsPoint:(CGPoint)point locationType:(XLTapStringLocationType)locationType
{
    if (locationType == XLTapStringLocationWithEquleLine) {
        
        UIFont *font               = [UIFont systemFontOfSize:self.font.pointSize];
        
        NSString *beforeString     = [[self xl_componentsSeparatedByString:self.tapString] objectAtIndex:0];
        
        CGFloat beforeSizeW        = [self getSizeWidthWithLabelString:beforeString
                                                                  font:font];
        
        CGFloat sizeW              = [self getSizeWidthWithLabelString:self.tapString
                                                                  font:font];
        
        CGFloat sizeH              = [self getSizeHeightWithLabelString:self.text
                                                                   font:font];
        
        CGFloat beforeStringH      = [self getSizeHeightWithLabelString:beforeString
                                                                   font:[UIFont systemFontOfSize:self.font.pointSize]];
        CGRect rect;
        //说明在同一行，并且不定头
        int width = (int)beforeSizeW % (int)ScreenWidth;
        if (width < self.frame.size.width - self.font.pointSize) {
            self.marginTop         = (self.frame.size.height - sizeH)/2 + beforeStringH - font.lineHeight;
            rect = CGRectMake(width, self.marginTop, sizeW, font.lineHeight);
        }else{
            self.marginTop         = (self.frame.size.height - sizeH)/2 + beforeStringH;
            rect = CGRectMake(0, self.marginTop, sizeW, font.lineHeight);
        }
        
        
        
        
        return CGRectContainsPoint(rect, point);
    }
    
    for(int i = 1; i<self.tapString.length; i++){
        
        NSString *tempString       = [self.tapString substringFromIndex:i];
        
        NSString *beforeString     = [[self xl_componentsSeparatedByString:self.tapString] objectAtIndex:0];
        
        NSString *splString        = [NSString stringWithFormat:@"%@%@",beforeString,tempString];
        
        NSString *mergeString      = [NSString stringWithFormat:@"%@%@",beforeString,self.tapString];
        
        CGFloat mergeStringH       = [self getSizeHeightWithLabelString:mergeString
                                                                   font:[UIFont systemFontOfSize:self.font.pointSize]];
        
        CGFloat splStringH         = [self getSizeHeightWithLabelString:splString
                                                                   font:[UIFont systemFontOfSize:self.font.pointSize]];
        
        CGFloat beforeStringW      = [self getSizeWidthWithLabelString:beforeString
                                                                  font:[UIFont systemFontOfSize:self.font.pointSize]];
        
        CGFloat tempStringW        = [self getSizeWidthWithLabelString:tempString
                                                                  font:[UIFont systemFontOfSize:self.font.pointSize]];
        
        CGFloat sizeH              = [self getSizeHeightWithLabelString:self.text
                                                                   font:[UIFont systemFontOfSize:self.font.pointSize]];
        
        CGFloat beforeStringH      = [self getSizeHeightWithLabelString:beforeString
                                                                   font:[UIFont systemFontOfSize:self.font.pointSize]];
        
        if (mergeStringH != splStringH) {
            
            self.marginTop         = (self.frame.size.height - sizeH)/2 + beforeStringH - self.font.lineHeight;
            
            CGRect rect1 = CGRectMake(beforeStringW, self.marginTop, tempStringW, self.font.lineHeight);
            
            NSString *nextLineString = [self.tapString stringByReplacingOccurrencesOfString:tempString withString:@""];
            CGFloat nextStringW    = [self getSizeWidthWithLabelString:nextLineString
                                                                  font:[UIFont systemFontOfSize:self.font.pointSize]];
            
            self.marginTop         = (self.frame.size.height - sizeH)/2 + beforeStringH;
            
            CGRect rect2 = CGRectMake(0, self.marginTop, nextStringW, self.font.lineHeight);
            
            return CGRectContainsPoint(rect1, point) || CGRectContainsPoint(rect2, point);
        }
    }
    
    return NO;
}
//** 点击字符串不在一行判断*/
- (BOOL)isContainsRectOndifferentLines
{
    return YES;
}

//** 字符串截取*/
- (NSArray *)xl_componentsSeparatedByString:(NSString *)string
{
    NSArray *array;
    array = [self.text componentsSeparatedByString:string];
    return array;
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

//** 重写系统HitTest:Event方法*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    [self xL_containPointHandle:point];
    
    return [super hitTest:point withEvent:event];
}

@end
