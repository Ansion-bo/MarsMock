//
//  HomeViewController.m
//  Mars
//
//  Created by Wayde C. on 1/1/16.
//  Copyright © 2016 Wayde C. All rights reserved.
//

#import "HomeViewController.h"
#import "MessageViewController.h"

@implementation HomeViewController
- (IBAction)action:(UIButton *)sender {

    [self.navigationController pushViewController:[[MessageViewController alloc] init] animated:YES];
}

@end
