//
//  NetworkFactory.h
//  MPUlseSample2
//
//  Created by Anish Kumar on 3/4/19.
//  Copyright © 2019 Akamai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticlesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkFactory : NSObject

@property (nonatomic, strong) dispatch_queue_t queue;

+ (NetworkFactory *)networkingSharedmanager;
- (void)fetchtJSON:(NSString*)category data:(void (^)(ArticlesModel *data))success failure:(void (^)(NSDictionary *errorDict))failure;

@end

NS_ASSUME_NONNULL_END
