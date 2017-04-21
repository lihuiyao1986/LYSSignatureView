//
//  LYSSignatureView.h
//  LYSSignatureView
//
//  Created by jk on 2017/4/21.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYSSignatureView : UIView

#pragma mark - 提示
@property(nonatomic,copy)NSString *placeHolder;

#pragma mark - 线条宽度
@property(nonatomic,assign)CGFloat lineW;

#pragma mark - 线的边框颜色
@property(nonatomic,strong)UIColor *lineBorderColor;

#pragma mark - 提示视图的高度
@property(nonatomic,assign)CGFloat placeholderVH;

#pragma mark - 线条颜色
@property(nonatomic,strong)UIColor *lineColor;

#pragma mark - 提示文字字体
@property(nonatomic,strong)UIFont *placeholderFont;

#pragma mark - 提示文字的颜色
@property(nonatomic,strong)UIColor *placeholderTextColor;

#pragma mark - 获取签名图片
- (UIImage *)getImage;

#pragma mark - 清除画布
- (void)clear;

@end
