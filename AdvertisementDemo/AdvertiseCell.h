//
//  AdvertiseCell.h
//  TestProject
//
//  Created by Yh.Zhu on 2018/7/11.
//  Copyright © 2018年 yuheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertiseCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 设置广告图片是否隐藏
 
 @param hide <#hide description#>
 */
- (void)setImageHide:(BOOL)hide;

/**
 设置广告视图
 
 @param image <#image description#>
 */
- (void)setImage:(UIImage *)image;

@end
