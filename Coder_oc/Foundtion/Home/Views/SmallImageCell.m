//
//  SmallImageCell.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/6.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "SmallImageCell.h"
#import "CellFooterViews.h"
#import "News.h"

@interface SmallImageCell ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) CellFooterViews *footerViews;
@property (nonatomic, strong) UIImageView *leftImage;
@property (nonatomic, strong) UIImageView *centerImage;
@property (nonatomic, strong) UIImageView *rightImage;

@end

@implementation SmallImageCell

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
    self.label.numberOfLines = 5;
    self.label.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.label];
    
    self.label.preferredMaxLayoutWidth = ScreenWidth - 10;
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.top.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];
    
    self.leftImage = [[UIImageView alloc] init];
    self.leftImage.image = [UIImage imageNamed:@"zhanwei_home"];
    [self.contentView addSubview:self.leftImage];
    
    [self.leftImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(5);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo((ScreenWidth-20)/3);
        make.top.mas_equalTo(_label.mas_bottom).offset(3);
    }];
    
    self.centerImage = [[UIImageView alloc] init];
    self.centerImage.image = [UIImage imageNamed:@"zhanwei_home"];
    [self.contentView addSubview:self.centerImage];
    
    [self.centerImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(_leftImage.mas_right).offset(5);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo((ScreenWidth-20)/3);
        make.top.mas_equalTo(_label.mas_bottom).offset(3);
    }];
    
    self.rightImage = [[UIImageView alloc] init];
    self.rightImage.image = [UIImage imageNamed:@"zhanwei_home"];
    [self.contentView addSubview:self.rightImage];
    
    [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(_centerImage.mas_right).offset(5);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo((ScreenWidth-20)/3);
        make.top.mas_equalTo(_label.mas_bottom).offset(3);
    }];
    
    self.footerViews = [[CellFooterViews alloc] init];
    self.footerViews.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.footerViews];
    
    
    [self.footerViews mas_makeConstraints:^(MASConstraintMaker *make){

        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(_leftImage.mas_bottom).offset(0);

    }];

}

- (void)setModel:(News *)model {
    self.label.text = model.title;
    [self.leftImage sd_setImageWithURL:[NSURL URLWithString:model.imageArray[0]]];
    [self.centerImage sd_setImageWithURL:[NSURL URLWithString:model.imageArray[1]]];
    [self.rightImage sd_setImageWithURL:[NSURL URLWithString:model.imageArray[2]]];
    self.footerViews.fmodel = model.typeinfo;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
