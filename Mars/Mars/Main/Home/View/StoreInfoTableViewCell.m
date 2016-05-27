//
//  StoreInfoTableViewCell.m
//  Mars
//
//  Created by Wayde C. on 1/1/16.
//  Copyright © 2016 Wayde C. All rights reserved.
//

#import "StoreInfoTableViewCell.h"
#import "HomeModel.h"

@interface StoreInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *coverButton;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;

@end

@implementation StoreInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setStoreInfoModel:(StoreInfoModel *)storeInfoModel {
    _storeInfoModel = storeInfoModel;
    NSLog(@"%@", storeInfoModel.headpic);
    self.storeNameLabel.text = storeInfoModel.store_english_name;
    self.storeNameLabel.font = [UIFont fontWithName:@"ITC Bookman Demi" size:25];
}

#pragma mark - tasks
- (IBAction)toStoreInfo:(UIButton *)sender {
}


#pragma mark - others
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
