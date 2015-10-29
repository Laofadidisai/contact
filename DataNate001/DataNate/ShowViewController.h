//
//  ShowViewController.h
//  DataNate
//
//  Created by 老李 on 15-10-27.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * myTableView;
    //接受文件内容的数组
    NSMutableArray * tototeArray;
    //创建文件的路径
    NSString * filepathArray;
    //已创建文件的路径
    NSString * arrayFilePath;
    
    UIView * view;
    
    UITextView * textView;
}

@end
