//
//  HomeLabelViews.h
//  Coder_oc
//
//  Created by ddSoul on 17/1/6.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ManageButtonClickDelegte <NSObject>

- (void)managerButtonClick:(UIButton *)button;

@end

@interface HomeLabelViews : UIView

@property (nonatomic, assign) id<ManageButtonClickDelegte> delegate;

@end
