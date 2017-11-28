//
//  BigImageCell.h
//  Coder_oc
//
//  Created by ddSoul on 17/1/6.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class News;

#import "CellFooterViews.h"

@interface BigImageCell : UITableViewCell

@property (nonatomic, strong) News *model;
@property (nonatomic, strong) CellFooterViews *footerViews;

@end
