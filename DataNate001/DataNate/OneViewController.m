//
//  OneViewController.m
//  DataNate
//
//  Created by 老李 on 15-10-27.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import "OneViewController.h"
#import "TwoViewController.h"
@interface OneViewController ()

@end

@implementation OneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    UIButton * Btn = [[UIButton alloc]initWithFrame:CGRectMake(110, 150, 100, 50)];
    Btn.backgroundColor = [UIColor orangeColor];
    Btn.layer.cornerRadius = 10;
    [Btn setTitle:@"写日志" forState:UIControlStateNormal];
    [Btn setTitle:@"" forState:UIControlStateHighlighted];
    [Btn addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn];
    
    
    
    
}

-(void)BtnClick
{
    TwoViewController * twoVC = [[TwoViewController alloc]init];
    [self presentViewController:twoVC animated:YES completion:nil];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
