//
//  UIView+frame.m
//  XLRefresh
//
//  Created by 邓西亮 on 16/10/21.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "UIView+frame.h"
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)


@implementation UIView (frame)

//h
- (void)setH:(float)h {
    CGRect frm = self.frame;
    frm.size.height = h;
    self.frame = frm;
}

- (float)h {
    return self.frame.size.height;
}



//w
- (void)setW:(float)w {
    CGRect frm = self.frame;
    frm.size.width = w;
    self.frame = frm;
}

- (float)w {
    return self.frame.size.width;
}


//x
- (void)setX:(float)x {
    CGRect frm = self.frame;
    frm.origin.x = x;
    self.frame = frm;
    
}


- (float)x {
    return self.frame.origin.x;
}



//y
- (void)setY:(float)y {
    CGRect frm = self.frame;
    frm.origin.y = y;
    self.frame = frm;
}


- (float)y {
    return self.frame.origin.y;
}


- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}



@end
