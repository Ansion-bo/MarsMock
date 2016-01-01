//
//  HomebizareaInfoCell.m
//  Mars
//
//  Created by Wayde C. on 5/27/16.
//  Copyright © 2016 Wayde C. All rights reserved.
//

#import "HomebizareaInfoCell.h"
#import "NSString+fitToURL.h"
#import "UIButton+WebCache.h"

@interface HomebizareaInfoCell ()

@property (weak, nonatomic) IBOutlet UIButton *coverButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *centerButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (weak, nonatomic) IBOutlet UIButton *centerLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *heartButton;
@property (weak, nonatomic) IBOutlet UIButton *centerRightButton;


@end

@implementation HomebizareaInfoCell

#pragma mark - HomebizareInfoCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(BizareModel *)model {
    _model = model;

    NSString *coverURL = [model.headpic fitToHeaderPicURL];
    NSLog(@"%@", coverURL);
    [self.coverButton sd_setImageWithURL:[NSURL URLWithString:coverURL] forState:UIControlStateNormal];

    PicInfoModel *picModel = [PicInfoModel yy_modelWithDictionary:model.stores[0][@"pics"][0]];
    NSString *subURL = [picModel.url fitToSubPicURL];
    NSLog(@"----------%@,", subURL);
    [self.centerLeftButton sd_setImageWithURL:[NSURL URLWithString:subURL] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
