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
#import "HomeTableView.h"
#import "TopicDetailTableViewController.h"
#import "NSString+fitToURL.h"

@interface HomeViewController () <HomeTableViewDelegate>

@property (strong, nonatomic)  NSMutableArray *topics;
@property (strong, nonatomic)  NSMutableArray *bizareInfo;
@property (strong, nonatomic)  NSMutableArray *storeInfo;
@property (weak, nonatomic) IBOutlet HomeTableView *homeTableView;

@end

@implementation HomeViewController
//150 182 132
- (void)viewDidLoad {
    [super viewDidLoad];

//
//    [self.homeTableView selectRowWithBlockHandler:^(HomeTableView * _Nullable homeTableView, NSIndexPath * _Nullable indexPath) {
//
//         [self.navigationController pushViewController:[[TopicDetailTableViewController alloc] init] animated:YES];
//    }];
    self.homeTableView.homeDelegate = self;
    [self loadData];
    [self _loadBizareInfo];
}

#pragma mark - HomeTableViewDelegate
- (void)homeTableView:(HomeTableView *)homeTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

     [self.navigationController pushViewController:[[TopicDetailTableViewController alloc] init] animated:YES];
}

#pragma mark - 
- (NSMutableArray *)topics {
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (NSMutableArray *)bizareInfo {
    if (!_bizareInfo) {
        _bizareInfo = [NSMutableArray array];
    }
    return _bizareInfo;
}

- (NSMutableArray *)storeInfo {
    if (!_storeInfo) {
        _storeInfo = [NSMutableArray array];
    }
    return _storeInfo;
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
            [self.topics addObject:model];
        }
    } failed:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)_loadBizareInfo {
//pp_version=1.3.1&city_id=5175&client_secret=cdaf9fc3dd97fd18d7ac280f58b039b8&client_type=iphone&is_auth=0&lang=zh&latitude=30.323466&limit=20&longitude=120.351833&os_version=9.3.1&page=1&screen_size=320x568&session_code=011e5c16e94fe2757ff2f8f87e4f0439&show_comments=0&type=0&v=1

    NSDictionary *parameters = @{
                                 @"client_secret": @"cdaf9fc3dd97fd18d7ac280f58b039b8" ,
                                 @"latitude": @"30.323466",
                                 @"longitude": @"120.351833",
                                 @"city_id": @"5175",
                                 @"limit": @"20",
                                 @"page": @"1",
                                 @"is_auth": @"0",
                                 @"show_comments": @"0",
                                 @"type": @"0",
                                 @"session_code": @"011e5c16e94fe2757ff2f8f87e4f0439"
                                 };

    [HTTPServer requestWithURL:@"bizarea/bizareas/index" parameters:parameters fileData:nil HTTPMethod:@"POST" completed:^(NSURLSessionDataTask * _Nullable task, id  _Nonnull result) {

        NSDictionary *data = result[@"data"];
        NSArray *list1 = data[@"list_1"];
        NSArray *list2 = data[@"list_2"];

        for (NSDictionary *bizare in list1) {

            BizareModel *model = [BizareModel yy_modelWithDictionary:bizare];
            [self.bizareInfo addObject:model];
        }

        for (NSDictionary *bizare in list2) {

            BizareModel *model = [BizareModel yy_modelWithDictionary:bizare];
            [self.bizareInfo addObject:model];
        }
        self.homeTableView.bizares = _bizareInfo;
        [self.homeTableView reloadData];
    } failed:^(NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

@end
