//
//  HomeViewController.m
//  Mars
//
//  Created by Wayde C. on 1/1/16.
//  Copyright © 2016 Wayde C. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchViewController.h"

@implementation HomeViewController
//150 182 132
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"World");

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];
}

- (void)push {

    [self.navigationController pushViewController:[[SearchViewController alloc] init] animated:YES];
}
@end
