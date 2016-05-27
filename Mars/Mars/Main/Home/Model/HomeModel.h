//
//  HomeModel.h
//  Mars
//
//  Created by Wayde C. on 1/1/16.
//  Copyright © 2016 Wayde C. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

#pragma mark - interface of HomeModel
@interface HomeModel : NSObject
@property (copy, nonatomic) NSString *message;
@property (copy, nonatomic) NSString *md5;
@end

#pragma mark - interface of TopicModel
@interface TopicModel : NSObject

@property (copy, nonatomic) NSString *cover;
@property (copy, nonatomic) NSString *topic_description;
@property (assign, nonatomic) NSInteger topic_id;
@property (copy, nonatomic) NSString *title;
@end

#pragma mark - interface of TopicDetailModel
@interface TopicDetailModel : TopicModel

@property (assign, nonatomic) NSInteger publish_time;
@property (copy, nonatomic) NSString *publish_time_str;
@property (strong, nonatomic) NSArray *stores;
@end

@interface StoreInfoModel : NSObject

@property (copy, nonatomic) NSString *store_name;
@property (copy, nonatomic) NSString *store_english_name;
@property (copy, nonatomic) NSString *store_sub_title;
@property (copy, nonatomic) NSString *website;
@property (assign, nonatomic) float longitude;
@property (assign, nonatomic) float latitude;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *store_description;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *headpic;
@property (assign, nonatomic) NSInteger score;
@property (assign, nonatomic) NSInteger assessment_user;
@property (assign, nonatomic) NSInteger consumption;
@property (strong, nonatomic) NSDictionary *opening_time;
@property (assign, nonatomic) NSInteger city;
@property (copy, nonatomic) NSString *address;

@end