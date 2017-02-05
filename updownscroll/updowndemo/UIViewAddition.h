//
//  ViewUtility.h
//  UZLottery
//
//  Created by tsunamier on 17/1/17.
//  Copyright © 2017年 kevin. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (Utility)

// 设置UIView的X
- (void)setViewX:(CGFloat)newX;

// 设置UIView的Y
- (void)setViewY:(CGFloat)newY;

// 设置UIView的Origin
- (void)setViewOrigin:(CGPoint)newOrigin;

// 设置UIView的width
- (void)setViewWidth:(CGFloat)newWidth;

// 设置UIView的height
- (void)setViewHeight:(CGFloat)newHeight;

// 设置UIView的Size
- (void)setViewSize:(CGSize)newSize;

// 获取自身UIView的中心店
- (CGPoint)getViewCurrentCenter;


@end
