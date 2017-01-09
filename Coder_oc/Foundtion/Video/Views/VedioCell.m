//
//  VedioCell.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/9.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "VedioCell.h"

@interface VedioCell ()
@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *writerImageView;
@property (strong, nonatomic) IBOutlet UILabel *writerLabel;
@property (strong, nonatomic) IBOutlet UIButton *vedioPlayButton;

@end

@implementation VedioCell



- (IBAction)StarVedioButton:(UIButton *)sender {
    
    if (self.vedioPlay) {
        self.vedioPlay();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.writerLabel.text = @"hello";
    self.vedioPlayButton.tag = 0;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
