//
//  addNoteViewController.m
//  备忘录。
//
//  Created by apple on 15/4/30.
//  Copyright (c) 2015年 Lin. All rights reserved.
//

#import "addNoteViewController.h"
#import "rootViewController.h"

@interface addNoteViewController ()

@property UITextView *mytextView;

@end

@implementation addNoteViewController
//程序包，是一个目录包含可执行文件和会用到的所有资源文件
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mytextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, 310, 320)];
    [self.view addSubview:self.mytextView];
    [self.mytextView becomeFirstResponder];
    UIBarButtonItem *savebtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveclicked)];
    self.navigationItem.rightBarButtonItem = savebtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveclicked
{
    //对相同的Key赋值约等于一次覆盖，要保证每一个Key的唯一性
    //NSUserDefaults返回的值是不可改变的，即便是存储的时候使用的是可变的值
    //    //如果要存储一个NSMutableArray对象,必须先创建一个不可变数组NSArray再将它存入NSUserDefaults中去
//        NSMutableArray *mutableArray = [NSMutableArray arrayWithObjects:@"123",@"234", nil];
//        NSArray * array = [NSArray arrayWithArray:mutableArray];
//    
//       NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    [user setObject:array forKey:@"记住存放的一定是不可变的"];
    
    //取出数据是一样,想要用NSUserDefaults中的数据给可变数组赋值
      //  NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //
    //    //可以用alloc 方法代替
       // NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:[user objectForKey:@"记住存放的一定是不可变的"]];
    
    //存
    //NSString *passWord = @"1234567";
    //NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //[user setObject:passWord forKey:@"userPassWord"];
    // 取密码
    //    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    //    NSString *passWord = [ user objectForKey:@"userPassWord"];
    NSMutableArray *initNoteArray = [[NSMutableArray alloc]init];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"note"]==nil)
    {
        [[NSUserDefaults standardUserDefaults] setObject:initNoteArray forKey:@"note"];
    }
    
    NSArray *tempNoteArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    NSMutableArray *mutableNoteArray = [tempNoteArray mutableCopy];
    NSString *textstring = [self.mytextView text];
    
    [mutableNoteArray insertObject:textstring atIndex:0 ];
    
    rootViewController *rootctrl = [[rootViewController alloc]init];
    rootctrl.noteArray = mutableNoteArray;
    //存储一个笔记
    [[NSUserDefaults standardUserDefaults] setObject:mutableNoteArray forKey:@"note"];
    
    NSMutableArray *initDateArray = [[NSMutableArray alloc]init];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"date"]==nil)
    {
        [[NSUserDefaults standardUserDefaults] setObject:initDateArray forKey:@"date"];
    }
    
    NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init ];
    
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    
    NSDate *now = [NSDate date];
    NSString *datestring = [dateFormatter stringFromDate:now];
    
    [mutableDateArray insertObject:datestring atIndex:0 ];
    rootctrl.dateArray = mutableDateArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
    
    
    [self.mytextView resignFirstResponder];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"添加成功!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
