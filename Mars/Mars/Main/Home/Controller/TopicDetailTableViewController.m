//
//  TopicDetailTableViewController.m
//  Mars
//
//  Created by Wayde C. on 1/1/16.
//  Copyright © 2016 Wayde C. All rights reserved.
//

#import "TopicDetailTableViewController.h"
#import "HTTPServer.h"
#import "HomeModel.h"
#import "StoreInfoTableViewCell.h"

static NSString *const reuseIdentifier = @"storeInfo";
static const NSInteger cellHeight = 200;

@interface TopicDetailTableViewController ()

@property (strong, nonatomic) NSMutableArray *stores;

@end

@implementation TopicDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];
}

- (NSMutableArray *)stores {
    if (!_stores) {
        _stores = [NSMutableArray array];
    }
    return _stores;
}

#pragma mark -
- (void)loadData {

    [self.tableView registerNib:[UINib nibWithNibName:@"StoreInfoTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];

    NSDictionary *parameters = @{
                                 @"client_secret": @"a2d2bde1e5699dfa166c2dcdf71e8c7b" ,
                                 @"latitude": @"30.323466",
                                 @"longitude": @"120.351833",
                                 @"id": @"159"
//                                 @"session_code": @"011e5c16e94fe2757ff2f8f87e4f0439"
                                 };

    [HTTPServer requestWithURL:@"topic/topic/info" parameters:parameters fileData:nil HTTPMethod:@"POST" completed:^(NSURLSessionDataTask * _Nullable task, id  _Nonnull result) {

        HomeModel *model = [HomeModel yy_modelWithDictionary:result];

        NSLog(@"-------------%@", model.message);
        NSDictionary *data = result[@"data"];
        TopicDetailModel *dataModel = [TopicDetailModel yy_modelWithJSON:data];
        NSLog(@"-------------%@", dataModel.topic_description);

        for (NSDictionary *store in data[@"stores"]) {

            StoreInfoModel *model = [StoreInfoModel yy_modelWithJSON:store];
            NSLog(@"++++++++%@", model.store_english_name);
            [self.stores addObject:model];
        }
        //数据加载完后需要重新加载tableView
        [self.tableView reloadData];
    } failed:^(NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _stores.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoreInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.storeInfoModel = _stores[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return cellHeight;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
