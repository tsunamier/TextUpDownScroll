//
//  ViewController.m
//  updowndemo
//
//  Created by tsunamier on 17/1/17.
//  Copyright © 2017年 tsunamier. All rights reserved.
//

#import "ViewController.h"
#import "UpDownScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor grayColor]];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(15, 100, self.view.bounds.size.width - 30, 30)];
    [self.view addSubview:view];
//    [view mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.view.mas_top).with.offset(100);
//        make.left.equalTo(self.view.mas_left).with.offset(15);
//        make.right.equalTo(self.view.mas_right).with.offset(-15);
//        make.height.mas_equalTo(@30);
//    }];
    
    [view setBackgroundColor:[UIColor whiteColor]];
    
    
    NSMutableArray *contents = [NSMutableArray arrayWithObjects:
                                @"<font color=\"#333333\">&nbsp;&nbsp;喜讯:g*****喜中</font><font color=\"#fa6547\" font-weight=\"bold\">竞彩足球混合过关&nbsp;</font><font color=\"#fa6547\">4104539555.01</font><font color=\"#333333\">元&nbsp;&nbsp;</font>",
//                                @"<font color=\"#333333\">&nbsp;&nbsp;喜讯:g*****喜中</font><font color=\"#fa6547\" font-weight=\"bold\">竞彩足球混合过关&nbsp;</font><font color=\"#fa6547\">1199530262.02</font><font color=\"#333333\">元&nbsp;&nbsp;</font>",
//                                @"<font color=\"#333333\">&nbsp;&nbsp;喜讯:g*****喜中</font><font color=\"#fa6547\" font-weight=\"bold\">竞彩足球混合过关&nbsp;</font><font color=\"#fa6547\">1199530262.03</font><font color=\"#333333\">元&nbsp;&nbsp;</font>",
//                                @"<font color=\"#333333\">&nbsp;&nbsp;喜讯:t********喜中</font><font color=\"#fa6547\" font-weight=\"bold\">超级大乐透&nbsp;</font><font color=\"#fa6547\">37868700.04</font><font color=\"#333333\">元&nbsp;&nbsp;</font>",
//                                @"<font color=\"#333333\">&nbsp;&nbsp;喜讯:g*****喜中</font><font color=\"#fa6547\" font-weight=\"bold\">超级大乐透&nbsp;</font><font color=\"#fa6547\">36184960.05</font><font color=\"#333333\">元&nbsp;&nbsp;</font>",
//                                @"<font color=\"#333333\">&nbsp;&nbsp;喜讯:g*****喜中</font><font color=\"#fa6547\" font-weight=\"bold\">超级大乐透&nbsp;</font><font color=\"#fa6547\">20160000.06</font><font color=\"#333333\">元&nbsp;&nbsp;</font>",
//                                @"<font color=\"#333333\">&nbsp;&nbsp;喜讯:g*****喜中</font><font color=\"#fa6547\" font-weight=\"bold\">七星彩&nbsp;</font><font color=\"#fa6547\">12166120.07</font><font color=\"#333333\">元&nbsp;&nbsp;</font>",
//                                @"<font color=\"#333333\">&nbsp;&nbsp;喜讯:g*****喜中</font><font color=\"#fa6547\" font-weight=\"bold\">竞彩足球混合过关&nbsp;</font><font color=\"#fa6547\">9717085.08</font><font color=\"#333333\">元&nbsp;&nbsp;</font>",
                                nil];
    
    
    
    
    NSMutableArray *attrStrs = [[NSMutableArray alloc]initWithCapacity:0];
    for (NSUInteger i = 0 ; i < contents.count ; i++) {
        
        NSString *content = [contents objectAtIndex:i];
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        [attrStrs addObject:attrStr];
        
    }

    UpDownScrollView *upDownScrollView = [[UpDownScrollView alloc]initWithContents:attrStrs
                                                                             frame:CGRectMake(0, 0, view.bounds.size.width, 30)
                                                                           options:UPDownScrollViewContentLabelTextTypeAttributedString];
    
    [view addSubview:upDownScrollView];
    
   
    
    
    [upDownScrollView begainAnimation];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
