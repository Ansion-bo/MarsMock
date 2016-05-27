//
//  SotreInfoModel.m
//  Mars
//
//  Created by Wayde C. on 5/27/16.
//  Copyright © 2016 Wayde C. All rights reserved.
//

#import "SotreInfoModel.h"

@implementation SotreInfoModel

+ (NSDictionary *)modelCustomPropertyMapper {

    return @{
             @"store_id" : @"id",
             @"store_description": @"description"
             };
}

@end
