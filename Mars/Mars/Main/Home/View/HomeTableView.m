//
//  HomeTableView.m
//  Mars
//
//  Created by Wayde C. on 5/27/16.
//  Copyright © 2016 Wayde C. All rights reserved.
//

#import "HomeTableView.h"
#import "HomebizareaInfoCell.h"
#import "HomeViewController.h"

static NSString *const reuseIdentifier = @"bizarrea";

@implementation HomeTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;

        [self registerNib:[UINib nibWithNibName:@"HomebizareaInfoCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.dataSource = self;
    self.delegate = self;

     [self registerNib:[UINib nibWithNibName:@"HomebizareaInfoCell" bundle:nil] forCellReuseIdentifier:reuseIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _bizares.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomebizareaInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model = _bizares[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 335;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

//    self.currentIndexPath = indexPath;

    
    [self.homeDelegate homeTableView:self didSelectRowAtIndexPath:indexPath];
}

//- (void)selectRowWithBlockHandler:(void (^)(HomeTableView * _Nullable, NSIndexPath * _Nullable))handle {
//
//    handle(self, _currentIndexPath);
//}

@end
