//
//  NetworkFactory.m
//  MPUlseSample2
//
//  Created by Anish Kumar on 3/4/19.
//  Copyright © 2019 Akamai. All rights reserved.
//

#import "NetworkFactory.h"
#import "ArticlesModel.h"

@implementation NetworkFactory

+ (NetworkFactory *)networkingSharedmanager
{
    static NetworkFactory *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
        sharedAccountManagerInstance->_queue = dispatch_queue_create("com.akamai.mpulse2", DISPATCH_QUEUE_CONCURRENT);
        
    });
    return sharedAccountManagerInstance;
}

- (void)fetchtJSON:(NSString*)category data:(void (^)(ArticlesModel *data))success failure:(void (^)(NSDictionary *errorDict))failure
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *dataUrl =  [NSString stringWithFormat:@"https://gnews.io/api/v2/?q=%@&token=4def75e1e153968b4e66b8ab020146af", category];
    NSURL *urlString = [NSURL URLWithString:dataUrl];
    NSLog(@"urlString URL = %@", urlString);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlString
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                                      int responseStatusCode = (int)[httpResponse statusCode];
                                      
                                      if (responseStatusCode == 200 )
                                      {
                                          [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
                                              
                                              //if (data)
                                              {
                                                  NSError *error = nil;
                                                  NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                  
                                                  if (jsonDict != nil && [jsonDict isKindOfClass:[NSDictionary class]])
                                                  {
                                                      //NSLog(@"%@",jsonDict);
                                                      
                                                      NSError *error = nil;
                                         
                                                      ArticlesModel *articlesModel = [[ArticlesModel alloc] initWithDictionary:jsonDict error:&error];

                                                      success(articlesModel);
                                                  }
                                              }
                                          }];
                                      }
                                      else
                                      {
                                          if (responseStatusCode == 0)
                                          {
                                              NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"No Connection! Please try again.", @"message", nil];
                                              failure(dict);
                                          }
                                          else if (data) {
                                              NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                              failure(dict);
                                          }
                                      }
                                  }];
    [task resume];
}
@end
