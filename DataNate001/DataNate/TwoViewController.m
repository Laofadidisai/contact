//
//  TwoViewController.m
//  DataNate
//
//  Created by 老李 on 15-10-27.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import "TwoViewController.h"
#import "OneViewController.h"
#import "ShowViewController.h"
@interface TwoViewController ()

@end

@implementation TwoViewController
@synthesize textView;

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
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 60, 300, 400)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.font = [UIFont systemFontOfSize:18.0];
    textView.layer.cornerRadius = 10;
    
    [self.view addSubview:textView];
    
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(260, 20, 50, 40)];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitle:@"" forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnBaoCun) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 50, 40)];
    [btn2 setTitle:@"编辑" forState:UIControlStateNormal];
    [btn2 setTitle:@"" forState:UIControlStateHighlighted];
    [btn2 addTarget:self action:@selector(btnBianJi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(140, 20, 40, 40)];
    lab.text = @"文本";
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = 1;
    [self.view addSubview:lab];
    
    //文件管理器
    NSFileManager * fileManger = [NSFileManager defaultManager];
    //创建文件路径
    filepathArray = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"array.txt"];
    //判断文件是否存在
    if ([fileManger fileExistsAtPath:filepathArray])
    {
        tototeArray = [NSMutableArray arrayWithContentsOfFile:filepathArray];
        NSLog(@"文件存在，继续");

    }
    else
    {
        tototeArray = [[NSMutableArray alloc]initWithCapacity:0];
        NSLog(@"文件不存在，创建");
    }
    
}
-(void)btnBianJi
{
    //字符串读取
    NSFileManager * fileManger = [NSFileManager defaultManager];
    
    NSString * textFilePath = [self getFilePath:@"Text.txt"];
    //判断字符串是否存在
    if ([fileManger fileExistsAtPath:textFilePath])
    {
        NSString * readText = [NSString stringWithContentsOfFile:textFilePath encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"readText:%@",readText);
        textView.text = readText;
    }
    

}
-(void)btnBaoCun
{
    NSLog(@"路径：%@",NSHomeDirectory());

    //字符串写入
    NSString * textString = textView.text;
    
    NSString * textFilePath = [self getFilePath:@"Text.txt"];
    
    BOOL isTextOK = [textString writeToFile:textFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",isTextOK?@"成功":@"失败");
    
    //数组写入
    [tototeArray addObject:textView.text];
    arrayFilePath = [self getFilePath:@"array.txt"];
    BOOL isArrayOK = [tototeArray writeToFile:arrayFilePath atomically:YES];
    NSLog(@"数组写入：%@",isArrayOK? @"成功":@"失败");
    
    ShowViewController * oneVC = [[ShowViewController alloc] init];
    [self presentViewController:oneVC animated:YES completion:nil];

    
}
//获取文件在Documents目录路径
-(NSString*)getFilePath:(NSString*)tmfilepath
{
    NSString * filePath = [[self getDocPath]stringByAppendingPathComponent:tmfilepath];
    return filePath;
    
    
}
//获取Documents目录路径
-(NSString*)getDocPath
{
    NSString* docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    return docPath;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
