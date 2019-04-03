//
//  NewsCell.h
//  MPUlseSample2
//
//  Created by Anish Kumar on 3/5/19.
//  Copyright © 2019 Akamai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticlesModelArray.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsSourceLabel;

- (void)populateModel:(ArticlesModelArray*)model;

@end

NS_ASSUME_NONNULL_END
