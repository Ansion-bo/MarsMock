//
//  GuideTableViewController.m
//  Mars
//
//  Created by Wayde C. on 1/1/16.
//  Copyright © 2016 Wayde C. All rights reserved.
//

#import "GuideTableViewController.h"
#import "HTTPServer.h"
#import "GuideModel.h"
#import "GuideTableViewCell.h"
#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "HomeViewController.h"


static NSString *const reuseIdentifier = @"guideCell";
static const CGFloat cellHeight = 120.0;

@interface GuideTableViewController ()

@property (strong, nonatomic) NSMutableArray *cities;

@end

@implementation GuideTableViewController

#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];


    [self loadData];


    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GuideTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
}

- (NSMutableArray *)cities {

    if (!_cities) {
        _cities = [NSMutableArray array];
    }
    return _cities;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)loadData {

    NSDictionary *parameters = @{
                                 @"client_secret": @"5e5bb019dcd095979bc9a6885c34574d" ,
                                 @"latitude": @"30.323466",
                                 @"longitude": @"120.351833",
                                 @"session_code": @"011e5c16e94fe2757ff2f8f87e4f0439"
                                 };

    [HTTPServer requestWithURL:@"system/area/citylist" parameters:parameters fileData:nil HTTPMethod:@"POST" completed:^(NSURLSessionDataTask * _Nullable task, id  _Nonnull result) {

        NSArray *cities = result[@"data"];

        for (NSDictionary *city in cities) {

            GuideModel *model = [GuideModel yy_modelWithDictionary:city];
            [self.cities addObject:model];
        }

        //数据加载完后需要重新加载tableView
        [self.tableView reloadData];
    } failed:^(NSError * _Nonnull error) {

        NSLog(@"%@", error);
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GuideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"guideCell" forIndexPath:indexPath];
    
    cell.guideModel = self.cities[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return cellHeight;
}


#pragma mark - UITableViewDelegate 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;

    [UIView transitionWithView:appDelegate.window duration:.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];

        BaseTabBarController *tabBarCV = [[BaseTabBarController alloc] init];
        [appDelegate.window setRootViewController:tabBarCV];

        [UIView setAnimationsEnabled:oldState];
    } completion:NULL];
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
