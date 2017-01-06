//
//  UITextField+tool.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/6.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "UITextField+tool.h"
#import <objc/runtime.h>


@implementation UITextField (tool)

- (void)setLeftDistance:(CGFloat)leftDistance
{
    //区别在这里，区别在这里
    NSValue *value = [NSValue value:&leftDistance withObjCType:@encode(CGFloat)];
    objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_ASSIGN);
    
    CGRect frame = [self frame];
    frame.size.width = leftDistance;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
}

- (CGFloat)leftDistance
{
    CGFloat cValue = {0};
    NSValue *value = objc_getAssociatedObject(self, @selector(setLeftDistance:));
    [value getValue:&cValue];
    return cValue;
}

//- (void)setLeftImageView:(UIImageView *)leftImageView
//{
//    objc_setAssociatedObject(self, _cmd, leftImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    
//    [self addSubview:leftImageView];
//}
//
//- (UIImageView *)leftImageView
//{
//    return objc_getAssociatedObject(self, _cmd);
//}

- (void)addleftImageView
{
    UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 3, 30, self.frame.size.height - 6)];
    leftImage.image = [UIImage imageNamed:@"home_search"];
    [self addSubview:leftImage];
}


@end
