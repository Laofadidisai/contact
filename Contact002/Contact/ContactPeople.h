//
//  ContactPeople.h
//  Contact
//
//  Created by 老李 on 15-10-28.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactPeople : NSObject<NSCoding>
@property(nonatomic,copy)NSString * name;
@property(nonatomic,assign)long long  phoneNumber;
@end
