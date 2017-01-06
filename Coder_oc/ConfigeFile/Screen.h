//
//  Screen.h
//  Coder_oc
//
//  Created by ddSoul on 17/1/4.
//  Copyright © 2017年 dxl. All rights reserved.
//

#ifndef Screen_h
#define Screen_h

#define iOS7  ([[UIDevice currentDevice].systemVersion floatValue]>=7.0)
#define iOS8  ([[UIDevice currentDevice].systemVersion floatValue]>=8.0)
#define iOS9  ([[UIDevice currentDevice].systemVersion floatValue]>=9.0)
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define MyScreenWith (self.frame.size.width)
#define MyScreenHeight (self.frame.size.height)

#define view_scal (ScreenWidth/1242)

//判断iphone6+
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iphone6
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//判断iPhone4
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define KHomeLabelsHeight 50

#define KNavgationItemHeight 64

#define KTabbarItemHeight 49

#endif /* Screen_h */
