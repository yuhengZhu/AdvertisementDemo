//
//  ViewController.m
//  AdvertisementDemo
//
//  Created by Yh.Zhu on 2018/7/14.
//  Copyright © 2018年 pokongyinfeng. All rights reserved.
//

#import "ViewController.h"
#import "AdvertiseCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
// 广告全图中需要显示的部分视图
@property (nonatomic, strong) UIImage *cropImage;

@property (nonatomic, strong) UITableView *tableView;

@end

// 普通cell高度
static const CGFloat cellH = 120;
// 广告cell高度
static const CGFloat advCellH = 200;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialization];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
}


/**
 数据初始化
 */
- (void)initialization {
    
    // 编写假数据
    self.dataArray = [NSMutableArray array];
    
    // 其中1代表正常数据, 2代表广告数据,可根据实际情况填写,主要用于区分广告数据和正常数据
    [self.dataArray addObject:@(1)];
    [self.dataArray addObject:@(1)];
    [self.dataArray addObject:@(1)];
    [self.dataArray addObject:@(1)];
    [self.dataArray addObject:@(1)];
    [self.dataArray addObject:@(1)];
    [self.dataArray addObject:@(2)];
    [self.dataArray addObject:@(1)];
    [self.dataArray addObject:@(1)];
    [self.dataArray addObject:@(1)];
    [self.dataArray addObject:@(1)];
    [self.dataArray addObject:@(1)];
    [self.dataArray addObject:@(1)];
    [self.dataArray addObject:@(1)];
    [self.dataArray addObject:@(1)];
}

- (void)setupUI {
    
    self.title = @"模仿界面新闻广告效果";
    
    CGFloat width = UIScreen.mainScreen.bounds.size.width;
    CGFloat height = self.view.frame.size.height;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height - 64)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    [self.view addSubview:tableView];
    
    // 背景视图(广告全图)
    UIImage *image = [UIImage imageNamed:@"backgroundImage3"];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:image];
    bgView.frame = tableView.bounds;
    
    // 裁剪广告部分(将广告全图中的部分视图作为Cell中显示的广告视图)
    CGSize s = CGSizeMake(bgView.frame.size.width, advCellH);
    UIGraphicsBeginImageContextWithOptions(s, NO, 1.0);
    [bgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *cropImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 存储
    self.cropImage = cropImage;
    
    // 设置广告全图为tableView的背景视图
    tableView.backgroundView = bgView;
    _tableView = tableView;
    
    [tableView reloadData];
}


#pragma mark -UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 用于区分正常数据和广告数据的一种方式,可根据实际情况进行区分
    NSNumber *number = self.dataArray[indexPath.row];
    
    NSInteger value = [number integerValue];
    
    if (1 == value) {
        // 正常使用cell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        
        cell.textLabel.text = @"正式内容";
        
        return cell;
        
    } else {
        
        // 广告cell
        AdvertiseCell *cell = [AdvertiseCell cellWithTableView:tableView];
        // 设置广告的图片
        [cell setImage:self.cropImage];
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSNumber *number = self.dataArray[indexPath.row];
    
    NSInteger value = [number integerValue];
    
    if (1 == value) {
        
        return cellH;
        
    } else {
        
        return advCellH;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 获取广告的位置,坐标转化(根据实际业务场景获取位置,这里使用了偷懒的办法)
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
    
    CGRect rectInTableView = [_tableView rectForRowAtIndexPath: indexPath];
    
    CGRect rectInSuperview = [_tableView convertRect:rectInTableView toView:[_tableView superview]];
    
    AdvertiseCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    // 判断广告是否将要移除屏幕;将要移除屏幕的时候设置广告cell的内容为裁剪图片的内容,否则设置广告图片隐藏, 显示底部视图
    if (rectInSuperview.origin.y < self.tableView.frame.origin.y) {
        
        [cell setImageHide:NO];
        
    } else {
        
        [cell setImageHide:YES];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
