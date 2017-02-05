//
//  UpDownScrollView.h
//  UZLottery
//
//  Created by tsunamier on 17/1/17.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"


typedef NS_ENUM(NSUInteger,UPDownScrollViewContentLabelTextType) {
    
    UPDownScrollViewContentLabelTextTypeNormalString,//普通字符串 @"234234234" default type
    UPDownScrollViewContentLabelTextTypeAttributedString,//富文本类型
    
};


@interface UpDownScrollView : UIView


- (instancetype)initWithContents:(id)acontents
                           frame:(CGRect)frame;


- (instancetype)initWithContents:(id)acontents
                           frame:(CGRect)frame
                         options:(UPDownScrollViewContentLabelTextType)options;

- (void)refreshContents:(id)acontents;

- (void)begainAnimation;

@end




