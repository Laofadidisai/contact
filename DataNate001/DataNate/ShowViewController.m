//
//  ShowViewController.m
//  DataNate
//
//  Created by 老李 on 15-10-27.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import "ShowViewController.h"
#import "TwoViewController.h"
@interface ShowViewController ()

@end

@implementation ShowViewController

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
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    myTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, 320, 385)];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.rowHeight = 50;
    [self.view addSubview:myTableView];
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(130, 20, 60, 20)];
    lab.text = @"通讯录";
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = 1;
    [self.view addSubview:lab];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(260, 440, 30, 30);
    [btn addTarget:self action:@selector(addAData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //文件管理器
    NSFileManager * fileManger2 = [NSFileManager defaultManager];
    arrayFilePath = [self getFilePath:@"array.txt"];
    //判断文件是否存在
    if ([fileManger2 fileExistsAtPath:arrayFilePath])
    {
        //文件存在
       tototeArray = [NSMutableArray arrayWithContentsOfFile:arrayFilePath];
        
       NSLog(@"readArray:%@ ",tototeArray);
        
    }
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    button.frame = CGRectMake(30, 440, 30, 30);
    [button addTarget:self action:@selector(removeAData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    view = [[UIView alloc]initWithFrame:CGRectMake(10, 60, 300, 400)];
    view.layer.cornerRadius = 10;
    view.clipsToBounds = YES;//clipsToBounds:裁剪
    [self.view addSubview:view];
    
    textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 300, 360)];
    textView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    textView.font = [UIFont systemFontOfSize:18.0];
    //textView.layer.cornerRadius = 10;
    [view addSubview:textView];
    
    UIButton * btnm = [[UIButton alloc]initWithFrame:CGRectMake(0, 360, 300, 40)];
    btnm.backgroundColor = [UIColor purpleColor];
    [btnm setTitle:@"确定" forState:UIControlStateNormal];
    [btnm setTitle:@"" forState:UIControlStateHighlighted];
    [btnm addTarget:self action:@selector(btnm) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnm];
    
    view.alpha = 0.0;

    
}
-(void)btnm
{
    [UIView animateWithDuration:1.0 animations:^{
        view.alpha = 0.0;
    }];
    
}
#pragma mark 删除移动按钮编辑状态 : 按钮绑定方法
-(void)removeAData
{
    //改变表的进入可编辑状态
    [myTableView setEditing:!myTableView.editing animated:YES];
    
    
}
#pragma mark 改变编辑状态下，删除确认按钮的标题
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return @"你动吧";
    
}
#pragma mark 删除按钮
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除处理
    [tototeArray removeObjectAtIndex:indexPath.row];
    [tototeArray writeToFile:arrayFilePath atomically:YES];
    [myTableView reloadData];
    
    
}
#pragma mark 移动按钮
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    NSString * str = [tototeArray objectAtIndex:sourceIndexPath.row];
    
    [tototeArray removeObject:str];
    
    [tototeArray insertObject:str atIndex:destinationIndexPath.row];
    
    [myTableView reloadData];
    
    
    
    
}
#pragma mark 编辑按钮的风格
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete;
    
    
}

# pragma mark 表的数据源结构
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return tototeArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *  cellId = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
   
    cell.textLabel.text = [tototeArray objectAtIndex:indexPath.row];
    
    return cell;
    
}
# pragma mark 表的代理协议
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [UIView animateWithDuration:1.0 animations:^{
        view.alpha = 1.0;
    }];
    textView.text = [tototeArray objectAtIndex:indexPath.row];
}
#pragma mark 添加数据 按钮绑定方法
-(void)addAData
{
    
    
    //[self.array addObject:self.str];

    //直接刷新
    [myTableView reloadData];
    
    TwoViewController * twoVC = [[TwoViewController alloc]init];
    [self presentViewController:twoVC  animated:YES completion:nil];

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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
