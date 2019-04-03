//
//  ViewController.m
//  MPUlseSample2
//
//  Created by Anish Kumar on 2/4/19.
//  Copyright © 2019 Akamai. All rights reserved.
//

#import "ViewController.h"
#import "NetworkFactory.h"
#import "ArticlesModel.h"
#import "ArticlesModelArray.h"
#import "NewsCell.h"
#import "DetailVC.h"
#import <MPulse/MPulse.h>
#define MP_DEBUG YES

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ArticlesModel *articlesModel;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSString *mPulsetimerID;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.color = [UIColor redColor];
    _activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:_activityIndicator];
    [_activityIndicator startAnimating];
    _tableView.backgroundView = _activityIndicator;
    
    //Action start with 4 minutes
    // Timeout in milliseconds
    MPulseSettings* settings;
    [settings setActionTimeout:[NSNumber numberWithInt:240000]]; //4 minutes
    // Maximum number of resources on an Action's Waterfall
    [settings setMaxActionResources:200];
    // Wait mode
    //[settings waitForStop];
    //Timeout
    [settings timeoutToStop];
    // Update the Global defaults
    //[[MPulse sharedInstance] updateSettings:settings];
    //Start Action
    [[MPulse sharedInstance] startActionWithSettings:settings];
    
    //
    //        [[MPulse sharedInstance] setDimension:@"AppVersion" value:@"1.0.0"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getNews:@"technology"];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getNews:@"world"];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getNews:@"sports"];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getNews:@"music"];
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(12.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getNews:@"economy"];
    });
    
}

-(void)getNews:(NSString*)category
{
    MPulseMetricTimerOptions* options;
    // include on the Action beacon (instead of sending a separate beacon)
    options.duringAction = MPulseDataDuringActionIncludeOnActionBeacon;
    
    _mPulsetimerID = [[MPulse sharedInstance] startTimer:@"Network_Start" withOptions:options] ;
    NSLog(@"Start Request");
    
    [[NetworkFactory networkingSharedmanager] fetchtJSON:category data:^(ArticlesModel * _Nonnull data)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Got  Response");
            [self->_activityIndicator stopAnimating];
            self->_articlesModel = data;
            [self->_tableView reloadData];
            
            [[MPulse sharedInstance] stopTimer:self->_mPulsetimerID];
        });
       
    } failure:^(NSDictionary * _Nonnull errorDict) {
         NSLog(@"failure = %@", errorDict);
    }];
}

#pragma mark -
#pragma mark - UItableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_articlesModel.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsCellId";
    
    NewsCell *cell = (NewsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    ArticlesModelArray *model = [_articlesModel.articles objectAtIndex:[indexPath row]];
    [cell populateModel: model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //ArticlesModelArray *model = [_articlesModel.articles objectAtIndex:[indexPath row]];
    
    //options
    MPulseMetricTimerOptions* options;
    // include on the Action beacon (instead of sending a separate beacon)
    options.duringAction = MPulseDataDuringActionIncludeOnActionBeacon;
    
    [[MPulse sharedInstance] sendMetric:@"NewsSelected" value:[NSNumber numberWithLong:indexPath.row] withOptions:options];
    
    [self performSegueWithIdentifier:@"showDetail" sender:self];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    ArticlesModelArray *model = [_articlesModel.articles objectAtIndex:[path row]];
    
    DetailVC *destinationViewController = segue.destinationViewController;
    [destinationViewController setModelArray:model];
    [self.tableView deselectRowAtIndexPath:path animated:NO];
}

@end
