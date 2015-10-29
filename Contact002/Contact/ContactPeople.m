//
//  ContactPeople.m
//  Contact
//
//  Created by 老李 on 15-10-28.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import "ContactPeople.h"

@implementation ContactPeople
@synthesize name,phoneNumber;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //对对象的属性编码
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:[NSNumber numberWithLongLong:self.phoneNumber] forKey:@"phoneNumber"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    //对对象的属性进行解码
    self = [super init];
    if (self)
    {
        //解完码后别忘记赋值
       self.name = [aDecoder decodeObjectForKey:@"name"];
       self.phoneNumber = [[aDecoder decodeObjectForKey:@"phoneNumber"] longLongValue];
        
    }
    return self;
    
}
@end
