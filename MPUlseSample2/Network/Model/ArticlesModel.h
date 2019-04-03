//
//  ArticlesModel.h
//  MPUlseSample2
//
//  Created by Anish Kumar on 3/4/19.
//  Copyright © 2019 Akamai. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ArticlesModelArray.h"


@interface ArticlesModel : JSONModel

@property (nonatomic) NSString <Optional>*timestamp;
@property (nonatomic) int count_results;
@property (nonatomic) NSArray <ArticlesModelArray, Optional> *articles;

@end


