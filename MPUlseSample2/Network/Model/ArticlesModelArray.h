//
//  JSONModel+ArticlesModel.h
//  MPUlseSample2
//
//  Created by Anish Kumar on 3/4/19.
//  Copyright © 2019 Akamai. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ArticlesModelArray
@end

@interface ArticlesModelArray : JSONModel

@property (nonatomic) NSString <Optional>*title;
@property (nonatomic) NSString <Optional>*desc;
@property (nonatomic) NSString <Optional>*website;
@property (nonatomic) NSString <Optional>*source;
@property (nonatomic) NSString <Optional>*data;
@property (nonatomic) NSString <Optional>*image;
@property (nonatomic) NSString <Optional>*link;
@end
