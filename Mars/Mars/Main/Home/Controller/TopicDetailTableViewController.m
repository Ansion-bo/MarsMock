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
#import "StoreInfoViewController.h"
#import "UIImageView+WebCache.h"

static NSString *const reuseIdentifier = @"storeInfo";
static NSString *const reuseIdentifierNomal = @"topicDscrpt";
static const float cellHeight = 400.0;
static float headLabelHeight = 0.0;

@interface TopicDetailTableViewController () <StoreInfoTableViewCellDelegate>

@property (strong, nonatomic) NSMutableArray *stores;

@end

@implementation TopicDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];

    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.tableView.separatorInset = UIEdgeInsetsMake(50, 50, 0, 0);

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

        NSDictionary *data = result[@"data"];
        TopicModel *topicModel = [TopicModel yy_modelWithDictionary:data];
        [self.stores addObject:topicModel];
        for (NSDictionary *store in data[@"stores"]) {

            StoreInfoModel *model = [StoreInfoModel yy_modelWithJSON:store];

            [self.stores addObject:model];
            [self setTableViewHeaderView];
        }

        [self.tableView reloadData];
    } failed:^(NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTableViewHeaderView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    TopicModel *topicModel = _stores[0];
    NSString *string = topicModel.cover;
    NSRange range =  [string rangeOfString:@"?"];
    NSString *imageURL = [string substringWithRange: NSMakeRange(0, range.location)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];

    self.tableView.tableHeaderView = imageView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _stores.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierNomal];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifierNomal];
            UILabel *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 8, kScreenWidth - 44, headLabelHeight)];
            TopicModel *topicModel = _stores[0];
            cellLabel.text = topicModel.topic_description;
            cellLabel.font = [UIFont systemFontOfSize:16];
            cellLabel.numberOfLines = 0;
            cellLabel.textAlignment = NSTextAlignmentLeft;

            [cell.contentView addSubview:cellLabel];
        }
        return cell;
    } else {
        StoreInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        cell.storeInfoModel = _stores[indexPath.row];
        cell.delegeate = self;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        TopicModel *topicModel = _stores[0];
        headLabelHeight = [topicModel.topic_description boundingRectWithSize:CGSizeMake(kScreenWidth - 44, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]} context:nil].size.height;
        return headLabelHeight + 16;
    } else {
        return cellHeight;
    }
}

#pragma mark - StoreInfoTableViewCellDelegate
- (void)tableViewCellDidSelecteButton {

    [self.navigationController pushViewController:[[StoreInfoViewController alloc] init] animated:YES];
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
