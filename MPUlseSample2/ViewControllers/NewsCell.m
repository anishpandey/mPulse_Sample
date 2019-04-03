//
//  NewsCell.m
//  MPUlseSample2
//
//  Created by Anish Kumar on 3/5/19.
//  Copyright © 2019 Akamai. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+WebCache.h"

@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)populateModel:(ArticlesModelArray*)model
{
    _newsTitleLabel.text = model.title;
    _newsSourceLabel.text = model.source;
    [_newsImageView sd_setImageWithURL:[NSURL URLWithString:model.image]
                       placeholderImage:[UIImage imageNamed:@"NewsDefault"]];
}

@end
