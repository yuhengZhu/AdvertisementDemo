//
//  AdvertiseCell.m
//  TestProject
//
//  Created by Yh.Zhu on 2018/7/11.
//  Copyright © 2018年 yuheng. All rights reserved.
//

#import "AdvertiseCell.h"

@interface AdvertiseCell ()
// 广告按钮
@property (nonatomic, strong) UIButton *advertiseBtn;
// 广告视图
@property (nonatomic, strong) UIImageView *customImageView;

@end

@implementation AdvertiseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *identityfier = @"AdvertiseCell";
    
    AdvertiseCell *cell = [tableView dequeueReusableCellWithIdentifier:identityfier];
    
    if (cell == nil) {
        
        cell = [[AdvertiseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identityfier];
        // 设置透明用于显示tableView背景视图
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setupUI];
    }
    
    return cell;
    
}

- (void)setupUI {
    
    self.contentView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 200);
 
    // 广告图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:imageView];
    _customImageView = imageView;
     
    // 广告标识按钮
    CGFloat adBtnW = 40;
    CGFloat adBtnH = 20;
    CGFloat adBtnY = self.contentView.frame.size.height - adBtnH - 10;
    CGFloat adBtnX = self.contentView.frame.size.width - adBtnW - 10;
    UIButton *adBtn = [[UIButton alloc] initWithFrame:CGRectMake(adBtnX, adBtnY, adBtnW, adBtnH)];
    [self.contentView addSubview:adBtn];
    [adBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [adBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [adBtn setTitle:@"广告" forState:UIControlStateNormal];
    [adBtn setTitle:@"广告" forState:UIControlStateHighlighted];
    adBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    adBtn.layer.borderColor = [UIColor grayColor].CGColor;
    adBtn.layer.borderWidth = 0.5f;
}

/**
 设置广告视图

 @param image <#image description#>
 */
- (void)setImage:(UIImage *)image {
    
    self.customImageView.image = image;
}


/**
 设置广告图片是否隐藏

 @param hide <#hide description#>
 */
- (void)setImageHide:(BOOL)hide {
    
    if (hide) {
        
        self.backgroundColor = [UIColor clearColor];

    } else {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    self.customImageView.hidden = hide;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
