//
//  VedioCell.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/9.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "VedioCell.h"
#import "VedioNews.h"

@interface VedioCell ()
@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *writerImageView;
@property (strong, nonatomic) IBOutlet UILabel *writerLabel;
@property (strong, nonatomic) IBOutlet UIButton *vedioPlayButton;
@property (nonatomic, copy) NSString *vedioUrlString;

@end

@implementation VedioCell



- (IBAction)StarVedioButton:(UIButton *)sender {
    
    if (self.vedioPlay) {
        self.vedioPlay(self.vedioUrlString);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.writerLabel.text = @"hello";
    self.vedioPlayButton.tag = 0;
    // Initialization code
}

- (void)setModel:(VedioNews *)model
{
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    self.vedioUrlString = model.mp4_url;
    self.writerLabel.text = model.writer;
    self.titleLabel.text = model.topic;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
