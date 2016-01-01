//
//  HomeViewController.m
//  Mars
//
//  Created by Wayde C. on 1/1/16.
//  Copyright © 2016 Wayde C. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchViewController.h"
#import "HTTPServer.h"
#import "HomeModel.h"

#import "TopicDetailTableViewController.h"

@interface HomeViewController ()

@property (strong, nonatomic)  NSMutableArray *topics;

@end

@implementation HomeViewController
//150 182 132
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"World");

    [self loadData];
}

#pragma mark - 
- (NSMutableArray *)topics {
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

#pragma mark -
- (void)loadData {

    NSDictionary *parameters = @{
                                 @"client_secret": @"799d4570b89403b150667f253a197b01" ,
                                 @"latitude": @"30.323466",
                                 @"longitude": @"120.351833",
                                 @"city_id": @"5175",    
                                 @"limit": @"6",
                                 @"page": @"1",
                                 @"rand": @"1",
                                 @"session_code": @"011e5c16e94fe2757ff2f8f87e4f0439"
                                 };

    [HTTPServer requestWithURL:@"topic/topics/topiclist" parameters:parameters fileData:nil HTTPMethod:@"POST" completed:^(NSURLSessionDataTask * _Nullable task, id  _Nonnull result) {

        NSDictionary *data = result[@"data"];
        NSArray *list = data[@"list"];
        
        for (NSDictionary *city in list) {

            TopicModel *model = [TopicModel yy_modelWithDictionary:city];
            NSLog(@"%li", model.topic_id);
            [self.topics addObject:model];
        }


    } failed:^(NSError * _Nonnull error) {

        NSLog(@"%@", error);
    }];
}


#pragma mark - tasks
- (IBAction)test:(UIButton *)sender {

    [self.navigationController pushViewController:[[TopicDetailTableViewController alloc] init] animated:YES];
}

@end
