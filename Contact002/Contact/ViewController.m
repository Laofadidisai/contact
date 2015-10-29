//
//  ViewController.m
//  Contact
//
//  Created by 老李 on 15-10-28.
//  Copyright (c) 2015年 Alibaba. All rights reserved.
//

#import "ViewController.h"
#import "ContactPeople.h"
@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//试图加载完成
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#pragma mark 读取联系人的方法
    //假如本地存在联系人文件信息
    if ([[NSFileManager defaultManager]fileExistsAtPath:[self getFilePath]])
    {
        //反序列
        //从本地取出文件
        NSData * data = [[NSData alloc]initWithContentsOfFile:[self getFilePath]];
        //通过反序列化器，将文件解码
        NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        //解码后的数据付给数组
        contactArray = [unarchiver decodeObject];
        [unarchiver finishDecoding];
        
        //提取数据
        
    }
    else
    {
        contactArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    

    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, 320, 400)];
    myTableView.backgroundColor = [UIColor whiteColor];
    //设置代理
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.rowHeight = 50;
    [self.view addSubview:myTableView];
    
    NSLog(@"%@",NSHomeDirectory());
    
    //注册一个通知，在程序进入后台自动保存
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(baocun) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(250, 420, 50, 50);
    [btn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(30, 420, 50, 50)];
    [btn1 setTitle:@"保存" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor colorWithRed:42/255.0 green:133/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn1 setTitle:@"" forState:UIControlStateHighlighted];
    [btn1 addTarget:self action:@selector(baocun) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    btn2.frame = CGRectMake(135, 420, 50, 50);
    [btn2 addTarget:self action:@selector(removeAData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
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
    [contactArray removeObjectAtIndex:indexPath.row];
    //[contactArray writeToFile:[self getFilePath] atomically:YES];
    [myTableView reloadData];
    
    
}
#pragma mark 移动按钮
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    NSString * str = [contactArray objectAtIndex:sourceIndexPath.row];
    
    [contactArray removeObject:str];
    
    [contactArray insertObject:str atIndex:destinationIndexPath.row];
    
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
    
    return contactArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellid];
    }
    
    //单元格显示
    //首先，根据单元格索引，取得数组中对应的联系人对象
    ContactPeople * temppeople = [contactArray objectAtIndex:indexPath.row];
    //然后显示联系人属性
    cell.textLabel.text = temppeople.name;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lld",temppeople.phoneNumber];
    
    return cell;
    
}
# pragma mark 表的代理协议
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
   
    
}

//获取文件在Documents目录路径
-(NSString*)getFilePath
{
    //找到Documents目录的路径
    NSString* docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    //然后在其内部，创建文件路径
    NSString * filePath = [docPath stringByAppendingPathComponent:@"contact.plist"];
    
    return filePath;
    
    
}

// 创建文件
//-(void)saveTofile
//{
//    //现根据文件路径 创建文件
//    [[NSFileManager defaultManager] createFileAtPath:[self getFilePath] contents:nil attributes:nil];
//    
//}

//序列化方法
-(void)encodeMethod
{
    NSMutableData * data = [[NSMutableData alloc]init];
    NSKeyedArchiver * archier = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archier encodeRootObject:contactArray];
    [archier finishEncoding];
    [data writeToFile:[self getFilePath] atomically:YES];
}
        //-(void)savetoFile
        //{
        //    NSString * filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"contact.plist"];
        //    
        //    [[NSFileManager defaultManager]createFileAtPath:filePath contents:nil attributes:nil];
        //    
        //}
//保存联系人
-(void)baocun
{
    
    //[self saveTofile];
    [self encodeMethod];
    NSLog(@"保存成功");
    
}

//添加联系人
-(void)addClick
{
    //创建提示框
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"增加联系人?" message:@"请输入联系人姓名和联系方式" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    //设置提示框风格
    //    UIAlertViewStyleDefault = 0,
    //    UIAlertViewStyleSecureTextInput,
    //    UIAlertViewStylePlainTextInput,
    //    UIAlertViewStyleLoginAndPasswordInput
    alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    //对提示框输入框属性修改
    [[alertView textFieldAtIndex:0]setPlaceholder:@"请输入联系人姓名"];
    
    [[alertView textFieldAtIndex:1]setPlaceholder:@"请输入联系人号码"];
    
    [[alertView textFieldAtIndex:1]setSecureTextEntry:NO];//不再以保护形式显示
    
    [[alertView textFieldAtIndex:1]setKeyboardType:UIKeyboardTypeNumberPad];//设置数字键盘格式

    //提示框显示
    [alertView show];
}
#pragma mark 提示框协议方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //做不为空的判断，以免存入空数据
    if (buttonIndex == 1)
    {
        if ([alertView textFieldAtIndex:0].text.length != 0 && [alertView textFieldAtIndex:1].text.length != 0)
        {
            //获取第一个输入框中的数据:取出 提示框 里面 联系人 信息
            NSString * name = [alertView textFieldAtIndex:0].text;
            
            long long phoneNumber = [[alertView textFieldAtIndex:1].text longLongValue];
            
            //保存成一个联系人对象
            
            people = [[ContactPeople alloc]init];
            people.name = name;
            people.phoneNumber = phoneNumber;
            //将联系人放进联系人数组中
            [contactArray addObject:people];
            //刷新tableview
            [myTableView reloadData];

        }
        
        
       //  只有第二个按钮能获取
       //  获取第一个输入框中的数据
        UITextField * login = [alertView textFieldAtIndex:0];
        NSLog(@"%@",login.text);
        
        //获取第二个输入框中的数据
        UITextField * password = [alertView textFieldAtIndex:1];
        NSLog(@"%@",password.text);
        
    }
    
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
