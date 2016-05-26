//
//  BaseNavigationController.m
//  Mars
//
//  Created by Wayde C. on 1/1/16.
//  Copyright © 2016 Wayde C. All rights reserved.
//

#import "BaseNavigationController.h"
#import "SearchViewController.h"
#import "UIViewExt.h"

@interface BaseNavigationController () <UIGestureRecognizerDelegate, UITextFieldDelegate> {
    UIGestureRecognizer *gesture;
}

@end

@implementation BaseNavigationController

#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationBar.translucent = NO;

    [self customizeNavigationBar];

    [self customPopGesture];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];

    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(0, 0, 24, 42);
    [leftButton setImage:[UIImage imageNamed:@"IQButtonBarArrowLeft"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    viewController.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

/**
 *  利用Runtime机制 给导航栏 pop 添加 pan gesture
 */
-(void)customPopGesture
{
    //关闭 UINavigationController pop 默认的交互手势
    gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    //NSLog(@"%@", gesture);

    //添加一个新的pan手势到 gesture.view 里面
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gesture.view addGestureRecognizer:popRecognizer];

    //获取手势唯一的接收对象（打印gesture）
    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
    id gestureRecognizerTarget = [_targets firstObject];
    //获取target
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    //获取action
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    //设置pan手势事件响应
    [popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];
}

//有两个条件不允许手势执行，1、当前控制器为根控制器；2、push、pop动画正在执行
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {

    return self.viewControllers.count > 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

#pragma mark - 
- (void)customizeNavigationBar {
    UIImage *navImage = [UIImage imageNamed:@"nav_textField"];
    [navImage stretchableImageWithLeftCapWidth:20 topCapHeight:2];
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(kScreenWidth * 0.28, 5, kScreenWidth * 0.7, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor blackColor];
    NSAttributedString *placeholder = [[NSAttributedString alloc]
                                       initWithString:@"mars"
                                       attributes:@{
                                                    NSFontAttributeName:  [UIFont fontWithName:@"ITC Bookman Demi" size:22],
                                                    NSForegroundColorAttributeName: [UIColor whiteColor],
                                                    NSBaselineOffsetAttributeName: @3,

                                                    }];
//    textField.attributedPlaceholder = placeholder;
    textField.delegate = self;

    UILabel *placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(textField.width * 0.3, 5, textField.width * 0.4, textField.height)];
    placeHolderLabel.attributedText = placeholder;
    placeHolderLabel.textAlignment = NSTextAlignmentCenter;
    [textField addSubview:placeHolderLabel];
    
    UIImageView *placeHolderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    placeHolderImageView.image = [UIImage imageNamed:@"search_ic"];
    [textField addSubview:placeHolderImageView];
    [self.navigationBar addSubview:textField];

//    UIView *editView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(placeHolderImageView.frame) + 8, 0, textField.width * 0.4, 30)];
//    editView.backgroundColor = [UIColor clearColor];
//    textField.inputView = editView;

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * 0.06, 5, 24, 30)];
    imageView.image = [UIImage imageNamed:@"nav_location_icon"];
    [self.navigationBar addSubview:imageView];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 8, 5, 0.14 * kScreenWidth, 30)];

    label.font = [UIFont systemFontOfSize:22.0];
    NSLog(@"%@", [UIFont familyNames]);

//    这里传参
    label.text = @"香港";
    [self.navigationBar addSubview:label];
}

#pragma mark - UITextFieldDelegate 
- (void)textFieldDidBeginEditing:(UITextField *)textField {

    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    [self pushViewController:searchViewController animated:YES];
}

#pragma mark - tasks
- (void)popAction {

    [self popViewControllerAnimated:YES];
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
