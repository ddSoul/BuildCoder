//
//  RootTabBarController.m
//  WeChat
//
//  Created by zhengwenming on 16/6/5.
//  Copyright © 2016年 zhengwenming. All rights reserved.
//

#import "RootTabBarController.h"
#import "CoderHomeViewController.h"
#import "CoderMineViewController.h"
#import "XLNavgationController.h"


#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"
@interface RootTabBarController ()
{
    NSInteger oldIndex;
}
@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"CoderHomeViewController",
                                   kTitleKey  : @"首页",
                                   kImgKey    : @"home_tabbar",
                                   kSelImgKey : @"home_tabbar_s"},
                                 
                                 @{kClassKey  : @"CoderMineViewController",
                                   kTitleKey  : @"视频",
                                   kImgKey    : @"video_tabbar",
                                   kSelImgKey : @"video_tabbar_s"},
                                 
                                 @{kClassKey  : @"CoderHomeViewController",
                                   kTitleKey  : @"关注",
                                   kImgKey    : @"newcare_tabbar",
                                   kSelImgKey : @"newcare_tabbar_s"},
                                 
                                 @{kClassKey  : @"CoderMineViewController",
                                   kTitleKey  : @"我的",
                                   kImgKey    : @"mine_tabbar",
                                   kSelImgKey : @"mine_tabbar_s"}
//
                                 ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        XLNavgationController *nav = [[XLNavgationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateSelected];
        [self addChildViewController:nav];
    }];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger selectIndex = [tabBar.items indexOfObject:item];
    if (selectIndex != oldIndex) {
        [self animationWithIndex:selectIndex];
    }
}

- (void)animationWithIndex:(NSInteger)index {    
    
    // Image动画
    NSMutableArray *animationArrayM = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            for (UIImageView *imageV in tabBarButton.subviews) {
                if ([imageV isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                    [animationArrayM addObject:imageV];
                }
            }
        }
    }
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.calculationMode = kCAAnimationCubic;
    // 添加动画
    [[animationArrayM[index] layer] addAnimation:animation forKey:nil];
    
    oldIndex = index;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
