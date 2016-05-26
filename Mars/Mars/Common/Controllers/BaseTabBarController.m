//
//  BaseTabBarController.m
//  Mars
//
//  Created by Wayde C. on 1/1/16.
//  Copyright © 2016 Wayde C. All rights reserved.
//

#import "BaseTabBarController.h"
#import "UIViewExt.h"

static const NSInteger numberOfButtons = 5;
static const CGFloat heightOfTabBar = 49;

@interface BaseTabBarController () {

    NSInteger _previousSelectedIndex;
}

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *image = [UIImage imageNamed:@"tabbar"];
    [image stretchableImageWithLeftCapWidth:100 topCapHeight:20];
    [self.tabBar setBackgroundImage:image];

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
    NSArray *buttonNames = @[
                             @"首页",
                             @"发现",
                             @"动态",
                             @"消息",
                             @"我的"
                             ];
    NSArray *buttonImageNames = @[
                                  @"tb_home_",
                                  @"tb_found_",
                                  @"tb_eye_",
                                  @"tb_message_",
                                  @"tb_mine_"
                                  ];

    for (NSInteger i = 0; i < numberOfButtons; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@n", buttonImageNames[i]]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@h", buttonImageNames[i]]] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@h", buttonImageNames[i]]] forState:UIControlStateSelected];
        button.tag = 1000 + i;

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, heightOfTabBar - 3 - 16, buttonWidth, 16)];
        label.tag = 10 + i;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:12];
        label.text = buttonNames[i];

        switch (i) {
            case 0:
                button.frame = CGRectMake((buttonWidth - 19) / 2.0, 5, 19, 26);
                break;
            case 1:
                button.frame = CGRectMake((buttonWidth - 30) / 2.0, 8, 30, 18);
                break;
            case 2:
                button.frame = CGRectMake((buttonWidth - 36) / 2.0, 9, 36, 17);
                break;
            case 3:
                button.frame = CGRectMake((buttonWidth - 30) / 2.0, 7, 30, 20);
                break;
            case 4:
                button.frame = CGRectMake((buttonWidth - 23) / 2.0, 3, 23, 27);
                break;
            default:
                break;
        }

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(buttonWidth * i, 0, buttonWidth, 49)];
        view.tag = 100 + i;
        [view addSubview:button];
        [view addSubview:label];
        [self.tabBar addSubview:view];
    }
}

//138 178 119
- (void)removeOriginalBarButtons {

    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
    }
}

#pragma mark - tasks
- (void)buttonAction:(UIButton *)button {

    NSInteger selectedIndex = button.tag - 1000;

    UIView *previousView = [self.tabBar viewWithTag:_previousSelectedIndex + 100];
    UILabel *previousLabel = [previousView viewWithTag:_previousSelectedIndex + 10];
    previousLabel.textColor = [UIColor whiteColor];
    UIButton *previousButton = [previousView viewWithTag:_previousSelectedIndex + 1000];
    previousButton.selected = NO;

    self.selectedIndex = selectedIndex;

    button.selected = !button.selected;

    UIView *view = [self.tabBar viewWithTag:selectedIndex + 100];
    UILabel *label = [view viewWithTag:selectedIndex + 10];
    label.textColor = [UIColor colorWithRed:138 / 155.0 green:178 / 155.0 blue:119 / 155.0 alpha:1];

    _previousSelectedIndex = selectedIndex;
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
