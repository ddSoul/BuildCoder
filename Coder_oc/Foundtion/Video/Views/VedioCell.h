//
//  VedioCell.h
//  Coder_oc
//
//  Created by ddSoul on 17/1/9.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VedioCell : UITableViewCell

//开始播放视频按钮点击
@property (nonatomic, copy) void (^vedioPlay)();

@end
