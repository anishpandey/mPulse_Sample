//
//  DetailVC.m
//  MPUlseSample2
//
//  Created by Anish Kumar on 3/5/19.
//  Copyright © 2019 Akamai. All rights reserved.
//

#import "DetailVC.h"
#import <WebKit/WebKit.h>
#import <MPulse/MPulse.h>

@interface DetailVC () <WKNavigationDelegate>

@property (strong, nonatomic)  WKWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSString *mPulsetimerID;

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    [self.view addSubview:_webView];
    //_webView = [[WKWebView alloc] initWithFrame: [[self view] bounds]];
    _webView.navigationDelegate = self;
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.color = [UIColor redColor];
    _activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:_activityIndicator];
    [_activityIndicator startAnimating];
    
    NSURL *nsurl=[NSURL URLWithString:_modelArray.link];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [_webView loadRequest:nsrequest];
    
    _mPulsetimerID = [[MPulse sharedInstance] startTimer:@"WKWebView_Start"];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect viewBounds = self.view.bounds;
    _activityIndicator.center = CGPointMake(CGRectGetMidX(viewBounds), CGRectGetMidY(viewBounds));
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->_activityIndicator stopAnimating];
        [[MPulse sharedInstance] stopTimer:self->_mPulsetimerID];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[MPulse sharedInstance] stopAction];
        });
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
