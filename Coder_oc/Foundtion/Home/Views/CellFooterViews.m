//
//  CellFooterViews.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/6.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "CellFooterViews.h"
#import "FootModel.h"

@interface CellFooterViews ()

//新闻类型标签
@property (nonatomic, strong) UILabel *newsTypeLabel;

@property (nonatomic, strong) UILabel *writer;

@property (nonatomic, strong) UILabel *commentCount;

@property (nonatomic, strong) UILabel *time;

@end

@implementation CellFooterViews


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
    _newsTypeLabel = [[UILabel alloc] init];
    _newsTypeLabel.text = @"英雄联盟";
    _newsTypeLabel.font = [UIFont systemFontOfSize:12];
    _newsTypeLabel.textColor = [UIColor redColor];
    [self addSubview:_newsTypeLabel];
    
    [_newsTypeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-2);
    }];
    
    _writer = [[UILabel alloc] init];
    _writer.text = @"ddsoul";
    _writer.font = [UIFont systemFontOfSize:12];
    _writer.textColor = [UIColor redColor];
    [self addSubview:_writer];
    
    [_writer mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(_newsTypeLabel.mas_right).offset(10);
        make.bottom.mas_equalTo(-2);
    }];

    _commentCount = [[UILabel alloc] init];
    _commentCount.text = @"666万评论";
    _commentCount.textColor = [UIColor redColor];
    _commentCount.font = [UIFont systemFontOfSize:12];
    [self addSubview:_commentCount];
    
    [_commentCount mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(_writer.mas_right).offset(10);
        make.bottom.mas_equalTo(-2);
    }];

    _time = [[UILabel alloc] init];
    _time.text = @"2017-01-06";
    _time.textColor = [UIColor redColor];
    _time.font = [UIFont systemFontOfSize:12];
    [self addSubview:_time];
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(_commentCount.mas_right).offset(10);
        make.bottom.mas_equalTo(-2);

    }];

}

- (void)setFmodel:(FootModel *)fmodel
{
    self.newsTypeLabel.text = fmodel.newstype;
    self.writer.text = fmodel.writer;
    self.commentCount.text = fmodel.commentcount;
    self.time.text = fmodel.time;
}

@end
