//
//  UpDownScrollView.m
//  UZLottery
//
//  Created by tsunamier on 17/1/17.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "UpDownScrollView.h"
#import "UIViewAddition.h"


//static  const  CGFloat  kTopOffest0 = 0.0f;
//static  const  CGFloat  kTopOffest_30 = -30.0f;
//static  const  CGFloat  kTopOffest30 = 30.0f;


static  const  NSTimeInterval  kRefreshPositonTime = 5;
static  const  NSTimeInterval  kAnimationTime = 0.7;


typedef NS_ENUM(NSUInteger,UPDownScrollViewContentLabelPosition) {

    UPDownScrollViewContentLabelPositionTopOffset0,//top偏移量0
    UPDownScrollViewContentLabelPositionTopOffset_30,//top偏移量-30
    UPDownScrollViewContentLabelPositionTopOffset30,//top偏移量30
};




@interface  ContentLabel:UILabel

@property (nonatomic, assign)UPDownScrollViewContentLabelPosition contentLabelPosition;

@end

@implementation ContentLabel

@end

@interface UpDownScrollView ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *contents;
@property (nonatomic, strong) ContentLabel *label1;
@property (nonatomic, strong) ContentLabel *label2;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) CGSize viewSize;
@property (nonatomic, assign) UPDownScrollViewContentLabelTextType contentLabelTextType;

@end

@implementation UpDownScrollView

- (instancetype)initWithContents:(id)acontents frame:(CGRect)frame{

    return [self initWithContents:acontents
                            frame:frame
                          options:UPDownScrollViewContentLabelTextTypeNormalString];

}


- (instancetype)initWithContents:(id)acontents
                           frame:(CGRect)frame
                         options:(UPDownScrollViewContentLabelTextType)options{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        _contents = [[NSMutableArray alloc]initWithArray:acontents];
        _contentLabelTextType = options;
        _viewSize = self.bounds.size;
        
        
        _label1 = [[ContentLabel alloc]initWithFrame:CGRectMake(0, 0, _viewSize.width, _viewSize.height)];
        _label2 = [[ContentLabel alloc]initWithFrame:CGRectMake(0, _viewSize.height/*kTopOffest30*/, _viewSize.width, _viewSize.height)];
        [self addSubview:_label1];
        [self addSubview:_label2];
        
//        [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
//          
//            make.top.equalTo(self.mas_top).with.offset(0);
//            make.left.equalTo(self.mas_left).with.offset(0);
//            make.right.equalTo(self.mas_right).with.offset(0);
//            make.height.mas_equalTo(@30);
//            
//        }];
//        
//        
//        [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
//           
//            make.top.equalTo(_label1.mas_bottom).with.offset(0);
//            make.left.equalTo(self.mas_left).with.offset(0);
//            make.right.equalTo(self.mas_right).with.offset(0);
//            make.height.mas_equalTo(@30);
//
//        }];
        
        [self reSetContentLabelsPosition];
       
    }
    return self;
}

- (void)refreshContents:(id)acontents{
    
    [_contents removeAllObjects];
    [_contents addObjectsFromArray:acontents];
    [self reSetContentLabelsPosition];
    [self begainAnimation];
    
}


- (void)reSetContentLabelsPosition{

    _label1.contentLabelPosition = UPDownScrollViewContentLabelPositionTopOffset0;
    _label2.contentLabelPosition = UPDownScrollViewContentLabelPositionTopOffset30;
    [_label1 setViewY:0];
    [_label2 setViewY:_viewSize.height];

}


- (void)begainAnimation{
    
    if ([_contents isEqual:[NSNull null]] || !_contents || !_contents.count ) {
        
        return;
    }

    
    [self setLabe1ContentText];
//    //如果只有一条数据不滚动
//    if (_contents.count == 1) {
//        
//        return;
//    }
    //每隔5秒滚动一次，将timer添加早当前runloop中指定runloopmode为NSRunLoopCommonModes，确保主页面有其他UItacking的时候不会暂停滚动
    
    if (_timer) {
        
        [_timer invalidate];
        _timer = nil;
    }
    
    _timer = [NSTimer timerWithTimeInterval:kRefreshPositonTime target:self selector:@selector(animation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    
}




- (void)setLabe1ContentText{

    switch (_contentLabelTextType) {
        
        case UPDownScrollViewContentLabelTextTypeNormalString:
        {
            NSString *normalString1 = [_contents objectAtIndex:_index];
            _label1.text = normalString1;

        }
            break;
            
        case UPDownScrollViewContentLabelTextTypeAttributedString:
        {
            NSMutableAttributedString *attributedString1 = [_contents objectAtIndex:_index];
            _label1.attributedText = attributedString1;

        }
            break;
    }
    
}

- (void)setContentLabelText{

    _index++;
    if (_index == _contents.count) {
        
        _index = 0;
    }
    
    switch (_contentLabelTextType) {
            
        case UPDownScrollViewContentLabelTextTypeNormalString:
        {
            NSString *normalString2 = [_contents objectAtIndex:_index];
            
            if (_label1.contentLabelPosition == UPDownScrollViewContentLabelPositionTopOffset0)_label2.text = normalString2;
            
            if (_label2.contentLabelPosition == UPDownScrollViewContentLabelPositionTopOffset0)_label1.text = normalString2;
            
        }
            break;
            
        case UPDownScrollViewContentLabelTextTypeAttributedString:
        {
            NSMutableAttributedString *attributedString2 = [_contents objectAtIndex:_index];
            
            if (_label1.contentLabelPosition == UPDownScrollViewContentLabelPositionTopOffset0)_label2.attributedText = attributedString2;
            
            if (_label2.contentLabelPosition == UPDownScrollViewContentLabelPositionTopOffset0)_label1.attributedText = attributedString2;
            
        }
            break;
    }
    
    
}


- (void)animation{

    
    [self setContentLabelText];
    [UIView animateWithDuration:kAnimationTime animations:^{
      
        switch (_label1.contentLabelPosition) {
            case UPDownScrollViewContentLabelPositionTopOffset0:
            {
                [_label1 setViewY:-_viewSize.height];
//                [_label1 mas_updateConstraints:^(MASConstraintMaker *make) {
//                    
//                    make.top.equalTo(self.mas_top).with.offset(-30);
//                }];
//                [_label1.superview layoutIfNeeded];
            
            }
                break;
              case UPDownScrollViewContentLabelPositionTopOffset_30:
                break;
            case UPDownScrollViewContentLabelPositionTopOffset30:
            {
                [_label1 setViewY:0];
//                [_label1 mas_updateConstraints:^(MASConstraintMaker *make) {
//                    
//                    make.top.equalTo(self.mas_top).with.offset(0);
//                }];
//                [_label1.superview layoutIfNeeded];
                
            }
                break;
        }
        switch (_label2.contentLabelPosition) {
            case UPDownScrollViewContentLabelPositionTopOffset0:
            {
                [_label2  setViewY:-_viewSize.height];
                
//                [_label2 mas_updateConstraints:^(MASConstraintMaker *make) {
//                    
//                    make.top.equalTo(self.mas_top).with.offset(-30);
//                }];
//                [_label2.superview layoutIfNeeded];
            }
                break;
            case UPDownScrollViewContentLabelPositionTopOffset_30:
                break;
            case UPDownScrollViewContentLabelPositionTopOffset30:
            {
                [_label2  setViewY:0];
//                [_label2 mas_updateConstraints:^(MASConstraintMaker *make) {
//                    
//                    make.top.equalTo(self.mas_top).with.offset(0);
//                }];
//                
//                [_label2.superview layoutIfNeeded];
                
            }
                break;
        }
        
    }completion:^(BOOL finished) {
        
        
        switch (_label1.contentLabelPosition) {
                
            case UPDownScrollViewContentLabelPositionTopOffset0:
            {
                _label1.contentLabelPosition = UPDownScrollViewContentLabelPositionTopOffset30;
                [_label1 setViewY:_viewSize.height];
//                [_label1 mas_updateConstraints:^(MASConstraintMaker *make) {
//                    
//                    make.top.equalTo(self.mas_top).with.offset(30);
//                }];
//                [_label1.superview layoutIfNeeded];
                
            }
                break;
                
            case UPDownScrollViewContentLabelPositionTopOffset_30:
                break;
            case UPDownScrollViewContentLabelPositionTopOffset30:
            {
                _label1.contentLabelPosition = UPDownScrollViewContentLabelPositionTopOffset0;

            }
                break;
        }
        
        switch (_label2.contentLabelPosition) {
            case UPDownScrollViewContentLabelPositionTopOffset0:
            {
                _label2.contentLabelPosition = UPDownScrollViewContentLabelPositionTopOffset30;
                [_label2 setViewY:_viewSize.height];
//                [_label2 mas_updateConstraints:^(MASConstraintMaker *make) {
//                    
//                    make.top.equalTo(self.mas_top).with.offset(30);
//                }];
//                [_label2.superview layoutIfNeeded];
                
            }

                break;
            case UPDownScrollViewContentLabelPositionTopOffset_30:
                break;
            case UPDownScrollViewContentLabelPositionTopOffset30:
            {
                
            _label2.contentLabelPosition = UPDownScrollViewContentLabelPositionTopOffset0;
            
            }
                break;
        }
    }];
}


@end
