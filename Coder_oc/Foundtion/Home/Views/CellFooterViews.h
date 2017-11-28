//
//  CellFooterViews.h
//  Coder_oc
//
//  Created by ddSoul on 17/1/6.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ShareButton) (UIButton *button);

@class FootModel;

@interface CellFooterViews : UIView

@property (nonatomic, strong) FootModel *fmodel;
@property (nonatomic, copy) ShareButton shareButtonClick;

@end
