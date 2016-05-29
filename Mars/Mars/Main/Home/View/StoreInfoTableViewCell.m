//
//  StoreInfoTableViewCell.m
//  Mars
//
//  Created by Wayde C. on 1/1/16.
//  Copyright © 2016 Wayde C. All rights reserved.
//

#import "StoreInfoTableViewCell.h"
#import "HomeModel.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "NSString+fitToURL.h"

@interface StoreInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *coverButton;
@property (weak, nonatomic) IBOutlet UIButton *iconButton;

@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewLeft;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCenter;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewRight;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@end

@implementation StoreInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setStoreInfoModel:(StoreInfoModel *)storeInfoModel {
    _storeInfoModel = storeInfoModel;

    self.storeNameLabel.text = storeInfoModel.store_english_name;
    self.storeNameLabel.font = [UIFont fontWithName:@"ITC Bookman Demi" size:25];

    NSString *string = storeInfoModel.store_description;
    NSRange range =  [string rangeOfString:@"。"];
    NSString *text = [string substringWithRange: NSMakeRange(0, range.location + 1)];
    self.descriptionLabel.text = text;

    string = storeInfoModel.headpic;
    NSString *imageURL = [string cutToFitAURL];
    [self.coverButton sd_setImageWithURL:[NSURL URLWithString:imageURL] forState:UIControlStateNormal];

    string = storeInfoModel.icon;
    imageURL =  [string cutToFitAURL];
    [self.iconButton sd_setImageWithURL:[NSURL URLWithString:imageURL] forState:UIControlStateNormal];

    string = storeInfoModel.pics[0][@"url"];
    imageURL =  [string cutToFitAURL];
    [self.imageViewLeft sd_setImageWithURL:[NSURL URLWithString:imageURL]];

    string = storeInfoModel.pics[1][@"url"];
    imageURL =  [string cutToFitAURL];
    [self.imageViewCenter sd_setImageWithURL:[NSURL URLWithString:imageURL]];

    string = storeInfoModel.pics[2][@"url"];
    imageURL =  [string cutToFitAURL];
    [self.imageViewRight sd_setImageWithURL:[NSURL URLWithString:imageURL]];
}

#pragma mark - tasks
- (IBAction)toStoreInfo:(UIButton *)sender {

    [self.delegeate tableViewCellDidSelecteButton];
}


#pragma mark - others
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
