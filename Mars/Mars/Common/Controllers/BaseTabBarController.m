//
//  BaseTabBarController.m
//  Mars
//
//  Created by Wayde C. on 1/1/16.
//  Copyright © 2016 Wayde C. All rights reserved.
//

#import "BaseTabBarController.h"

static const NSInteger numberOfButtons = 5;

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addViewControllers];
    [self customizeTabBarButtons];
}

- (void)addViewControllers {

    NSArray *nameOfControllers = @[
                                   @"Home",
                                   @"Discoveries",
                                   @"Timeline",
                                   @"Messages",
                                   @"Me"
                                   ];
    NSMutableArray *controllers = [NSMutableArray array];
    for (NSString *controllerName in nameOfControllers) {

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:controllerName bundle:nil];
        UIViewController *controller = [storyboard instantiateInitialViewController];
        [controllers addObject:controller];
    }

    self.viewControllers = controllers;
}

- (void)customizeTabBarButtons {

    [self removeOriginalBarButtons];

    CGFloat buttonWidth = kScreenWidth / numberOfButtons;

    for (NSInteger i = 0; i < 5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(buttonWidth * i, 0, buttonWidth, 49);
        button.backgroundColor = [UIColor colorWithRed:i / 5.0 green:i / 5.0 blue:0.4 alpha:1];
        button.tag = 1000 + i;
        [self.tabBar addSubview:button];
    }

}

- (void)removeOriginalBarButtons {

    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
    }
}

#pragma mark - tasks
- (void)buttonAction:(UIButton *)button {

    self.selectedIndex = button.tag - 1000;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
