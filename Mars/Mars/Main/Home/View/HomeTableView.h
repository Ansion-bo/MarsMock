//
//  HomeTableView.h
//  Mars
//
//  Created by Wayde C. on 5/27/16.
//  Copyright © 2016 Wayde C. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeTableView;
@protocol HomeTableViewDelegate <NSObject>

- (void)homeTableView:(HomeTableView *_Nullable)homeTableView didSelectRowAtIndexPath:(NSIndexPath *_Nullable)indexPath;

@end

@interface HomeTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *_Nullable bizares;

@property (weak, nonatomic) id <HomeTableViewDelegate> _Nullable homeDelegate;
//@property (strong, nonatomic) NSIndexPath * _Nullable currentIndexPath;

//- (void)selectRowWithBlockHandler:(nullable void (^)(HomeTableView *_Nullable homeTableView, NSIndexPath *_Nullable indexPath))handle;

@end

