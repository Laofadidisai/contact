//
//  TwoViewController.h
//  DataNate
//
//  Created by 老李 on 15-10-27.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoViewController : UIViewController
{
    //输入视图
    UITextView * textView;
    //记录输入视图内容的可变数组
    NSMutableArray * tototeArray;
    //创建文件的路径
    NSString * filepathArray;
    //已创建的文件的路径
    NSString * arrayFilePath;
}

@property(nonatomic,retain)UITextView * textView;
@end
