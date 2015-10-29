//
//  ViewController.h
//  Contact
//
//  Created by 老李 on 15-10-28.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactPeople.h"
@interface ViewController : UIViewController<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView * myTableView;
    NSMutableArray * contactArray;
    ContactPeople * people;
}


@end
