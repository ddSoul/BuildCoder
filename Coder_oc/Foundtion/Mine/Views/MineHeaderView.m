//
//  MineHeaderView.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/4.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "MineHeaderView.h"

@implementation MineHeaderView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.frame = frame;
        [self createControls];
    }
    return self;
}

/**
 * 创建控件
 */
- (void)createControls
{
    self.avtorImageView_b = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.frame.size.height)];
    self.avtorImageView_b.image = [UIImage imageNamed:@"login_b"];
    [self addSubview:self.avtorImageView_b];
    
    self.avtorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.avtorImageView.backgroundColor = [UIColor redColor];
    [self addSubview:self.avtorImageView];
    
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.userNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.userNameLabel];
}


@end
