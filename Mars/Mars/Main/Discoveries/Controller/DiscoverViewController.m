//
//  DiscoverViewController.m
//  Mars
//
//  Created by Wayde C. on 1/1/16.
//  Copyright © 2016 Wayde C. All rights reserved.
//

#import "DiscoverViewController.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "NSString+fitToURL.h"

@interface DiscoverViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_mainV;
    UIColor *_backC;
    UIButton *_commentBtn;
    
    //判断scrollview上下滑动用
    CGFloat _oldoffsetY;
    CGFloat _newoffsetY;
    
    //数据
    NSArray *_topData;
    NSDictionary *_topic;//专题
    NSArray *_bussinessHubs;//商quan
    NSDictionary *_line;//线路
    NSInteger _lineNum;
    
}

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _backC = rgb(69, 92, 57);
    
    [self request];
    _mainV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _mainV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainV.backgroundColor = _backC;
    _mainV.dataSource = self;
    _mainV.delegate = self;
    [self.view addSubview:_mainV];
    
    CGFloat btnW = 45;
    _commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 20 - btnW, kScreenHeight - 50 - btnW, btnW, btnW)];
    [_commentBtn setTitle:@"+" forState:UIControlStateNormal];
    _commentBtn.titleLabel.font = [UIFont systemFontOfSize:30];
//    _commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    _commentBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7];
    _commentBtn.layer.cornerRadius = btnW / 2;
    [self.view addSubview:_commentBtn];
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDataSource & delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger h = 44;
    if (indexPath.row == 0) {
        h = ((kScreenWidth -30 - 20) / 5) * 2 + 40;
    } else if (indexPath.row == 1) {
        h = 150;
    } else if (indexPath.row == 2) {
        h = kScreenWidth + 40;
    } else if (indexPath.row == 3) {
        if (_lineNum > 0) {
            h = 140 * _lineNum;
        } else {
            h = 0;
        }
    } else if (indexPath.row == 4) {
        h = 200;
    }
    return h;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *titles = @[@"餐厅",@"洋食",@"咖啡",@"茗茶",@"购物名所",@"糕点面包",@"夜蒲",@"展览艺术",@"酒店住宿",@"更多"];
    
    CGFloat btnW = (kScreenWidth -30 - 20) / 5;
//    CGFloat space = 5;
    CGFloat btnH = btnW;
    if (indexPath.row == 0) {
        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 2 ; j++) {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15 + (btnW + 5) * i, 15 + (btnH + 15) * j, btnW, btnH)];
//                btn.backgroundColor = [UIColor redColor];
                [cell.contentView addSubview:btn];
                btn.tag = 100 + i * 5 + j;
                [btn setTitle:titles[j * 5 + i] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:13];
                btn.titleEdgeInsets = UIEdgeInsetsMake(btnW / 2 + 10 , 0, 0, 0);
                btn.imageView.transform = CGAffineTransformScale(btn.imageView.transform, .5, .5);
                NSDictionary *btnDict = [NSDictionary dictionary];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                if (_topData.count > 0 && ((j * 5 + i) != 9)) {
                    btnDict = (NSDictionary *)_topData[j * 5 + i];
                    [btn sd_setImageWithURL:[NSURL URLWithString:[btnDict[@"icon"] cutToFitAURL]] forState:UIControlStateNormal];
                    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 20, 10);
                    btn.titleEdgeInsets = UIEdgeInsetsMake(btnW / 2 + 10, -btnW * 2 + 30, 0, 0);
                    NSString *icon = btnDict[@"icon"];
                }
            }
        }
    } else if (indexPath.row == 1) {
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 15, 40, 20)];
        titleLbl.text = @"专题";
        titleLbl.textAlignment = NSTextAlignmentLeft;
        titleLbl.textColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = rgb(69, 92, 57);
        [cell.contentView addSubview:titleLbl];
        
        //
        UIScrollView *v = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleLbl.frame.size.height + 20, kScreenWidth, 100)];
        CGFloat imgVWidth = kScreenWidth * 0.56;
        v.contentSize = CGSizeMake(imgVWidth * 4 + 5 * 5, v.frame.size.height);
        v.showsHorizontalScrollIndicator = NO;
        for (int i = 0; i < 4; i++) {
            UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(5 + (imgVWidth + 5) * i, 0, imgVWidth, v.frame.size.height)];
            [v addSubview:imgV];
            imgV.backgroundColor = [UIColor redColor];
            if (_topic) {
                NSDictionary *data = _topic[@"data"];
                NSArray *list = data[@"list"];
                NSDictionary *topic = list[i];
                [imgV sd_setImageWithURL:[NSURL URLWithString:[topic[@"cover" ] cutToFitAURL]]];
            }
        }
//        v.backgroundColor = [UIColor orangeColor];
        
        [cell.contentView addSubview:v];
    } else if (indexPath.row == 2) {
        CGFloat space = 10;
        CGFloat imgVWidth = (kScreenWidth - space * 4) / 3;
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(7, 10, 40, 20)];
        titleLbl.text = @"商圈";
        titleLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:titleLbl];
        
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3 ; j++) {
                UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(space + (imgVWidth + space) * i, 35 + (imgVWidth + space) * j, imgVWidth, imgVWidth)];
//                imgV.backgroundColor = [UIColor blueColor];
                [cell.contentView addSubview:imgV];
                if (_bussinessHubs.count > 0) {
                    NSDictionary *bussinessHub = _bussinessHubs[i * 3 + j];
                    [imgV sd_setImageWithURL:[NSURL URLWithString:[bussinessHub[@"headpic"] cutToFitAURL]]];
                }
            }
        }
        
        UIView *bottomV = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenWidth + 25, kScreenWidth, 15)];
        bottomV.backgroundColor = _backC;
        [cell.contentView addSubview:bottomV];
    } else if (indexPath.row == 3) {
        if (_lineNum > 0) {
            UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(7, 10, 40, 20)];
            titleLbl.text = @"线路";
            titleLbl.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:titleLbl];
            
            for (int i = 0; i < _lineNum; i++) {
                UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40 + 126 * i, kScreenWidth, 120)];
//                imgV.backgroundColor = [UIColor greenColor];
                [cell.contentView addSubview:imgV];
                NSDictionary *data = _line[@"data"];
                NSArray *list = data[@"list"];
                NSDictionary *line = list[i];
                
                [imgV sd_setImageWithURL:[NSURL URLWithString:[line[@"line_pic"] cutToFitAURL]]];
                
                UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 20)];
                lbl.text = line[@"title"];
                lbl.textColor = [UIColor whiteColor];
                lbl.font = [UIFont systemFontOfSize:17];
                [imgV addSubview:lbl];
            }
        }
        
    } else if (indexPath.row == 4) {
        cell.contentView.backgroundColor = _backC;
    }
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _oldoffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _newoffsetY = scrollView.contentOffset.y;
    if (scrollView == _mainV) {
        if (_newoffsetY > _oldoffsetY) {
            //上滑 _commentBtn隐藏
            CGFloat btnW = 45;
            [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                CGRect newF = CGRectMake(kScreenWidth - 20 - btnW, kScreenHeight - 50 - btnW, btnW, btnW);
                _commentBtn.frame = newF;
            } completion:nil];
        } else {
            //下滑显示
            CGFloat btnW = 45;
            [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                CGRect newF = CGRectMake(kScreenWidth - 20 - btnW, kScreenHeight - 125 - btnW, btnW, btnW);
                _commentBtn.frame = newF;
            } completion:nil];

        }
    }
    _oldoffsetY = _newoffsetY;
}

- (void)moveCommentBtnWithOffseY:(CGFloat)y {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)request {
    [HTTPServer requestWithURL:[NSURL URLWithString:@"http://www.yohomars.com/api/v1/store/store/category?app_version=1.3.1&client_secret=5e5bb019dcd095979bc9a6885c34574d&client_type=iphone&lang=zh&latitude=30.323466&longitude=120.351833&os_version=9.3.1&screen_size=320x568&session_code=011e5c16e94fe2757ff2f8f87e4f0439&v=1"] parameters:nil fileData:nil HTTPMethod:@"get" completed:^(NSURLSessionDataTask * _Nullable task, id  _Nonnull result) {
        _topData = result[@"data"];
        [_mainV reloadData];
    } failed:^(NSError * _Nonnull error) {
        assert(NO);
    }];
    [HTTPServer requestWithURL:[NSURL URLWithString:@"http://www.yohomars.com/api/v1/topic/topics/topiclist?app_version=1.3.1&city_id=5175&client_secret=799d4570b89403b150667f253a197b01&client_type=iphone&lang=zh&latitude=30.323466&limit=6&longitude=120.351833&os_version=9.3.1&page=1&rand=1&screen_size=320x568&session_code=011e5c16e94fe2757ff2f8f87e4f0439&v=1"] parameters:nil fileData:nil HTTPMethod:@"get" completed:^(NSURLSessionDataTask * _Nullable task, id  _Nonnull result) {
        _topic = (NSDictionary  *)result;
        NSIndexPath *indexPatn = [NSIndexPath indexPathForRow:1 inSection:0];
        [_mainV reloadRowsAtIndexPaths:@[indexPatn] withRowAnimation:UITableViewRowAnimationNone];
    } failed:^(NSError * _Nonnull error) {
        assert(NO);
    }];
    [HTTPServer requestWithURL:[NSURL URLWithString:@"http://www.yohomars.com/api/v1/bizarea/bizareas/bizlist?app_version=1.3.1&city_id=5175&client_secret=23cf1545feb096952d0ee73f5fa12bec&client_type=iphone&lang=zh&latitude=30.323466&limit_1=9&limit_2=10&longitude=120.351833&os_version=9.3.1&page=1&screen_size=320x568&session_code=011e5c16e94fe2757ff2f8f87e4f0439&show_stores=0&v=1"] parameters:nil fileData:nil HTTPMethod:@"get" completed:^(NSURLSessionDataTask * _Nullable task, id  _Nonnull result) {
        NSDictionary *data = result[@"data"];
        _bussinessHubs = data[@"list"];
        NSIndexPath *indexPatn = [NSIndexPath indexPathForRow:2 inSection:0];
        [_mainV reloadRowsAtIndexPaths:@[indexPatn] withRowAnimation:UITableViewRowAnimationNone];
    } failed:^(NSError * _Nonnull error) {
        assert(NO);
    }];
    [HTTPServer requestWithURL:[NSURL URLWithString:@"http://www.yohomars.com/api/v1/line/lines/linelist?app_version=1.3.1&city_id=5175&client_secret=4696cdee18ba2370b1798e730057ce9c&client_type=iphone&lang=zh&latitude=30.323466&limit=20&longitude=120.351833&os_version=9.3.1&page=1&screen_size=320x568&session_code=011e5c16e94fe2757ff2f8f87e4f0439&v=1"] parameters:nil fileData:nil HTTPMethod:@"get" completed:^(NSURLSessionDataTask * _Nullable task, id  _Nonnull result) {
        _line = result;
        NSDictionary *data = result[@"data"];
        _lineNum = [data[@"total"] integerValue];
        NSIndexPath *indexPatn = [NSIndexPath indexPathForRow:3 inSection:0];
        [_mainV reloadRowsAtIndexPaths:@[indexPatn] withRowAnimation:UITableViewRowAnimationNone];
    } failed:^(NSError * _Nonnull error) {
        assert(NO);
    }];

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
