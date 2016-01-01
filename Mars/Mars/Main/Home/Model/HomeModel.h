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