//
//  TextCell.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/6.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "TextCell.h"
#import "CellFooterViews.h"
#import "News.h"

@interface TextCell ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) CellFooterViews *footerViews;

@end

@implementation TextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self createControls];
    }
    return self;
}
/**
 *  创建控件
 */
- (void)createControls
{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.label = [[UILabel alloc] init];
    self.label.numberOfLines = 0;
    self.label.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.label];
    
    self.label.preferredMaxLayoutWidth = ScreenWidth - 10;
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.top.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];
    
    self.footerViews = [[CellFooterViews alloc] init];
    self.footerViews.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.footerViews];
//
//
    [self.footerViews mas_makeConstraints:^(MASConstraintMaker *make){

        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(_label.mas_bottom).offset(0);

    }];

}

- (void)setModel:(News *)model {
    self.label.text = model.title;
    self.footerViews.fmodel = model.typeinfo;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
