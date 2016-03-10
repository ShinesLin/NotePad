//
//  noteDetailViewController.m
//  备忘录。
//
//  Created by apple on 15/4/30.
//  Copyright (c) 2015年 Lin. All rights reserved.
//

#import "noteDetailViewController.h"
#import "rootViewController.h"

@interface noteDetailViewController ()<UIAlertViewDelegate>

@property UITextView *mytextView;

@end

@implementation noteDetailViewController
//程序包，是一个目录包含可执行文件和会用到的所有资源文件
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //调用父类实现初始化
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mytextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, 310, 320)];
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    NSString *oldtext = [array objectAtIndex:self.index];
    self.mytextView.text = oldtext;
    
    UIBarButtonItem *savebtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveclicked)];
    
    UIBarButtonItem *delbtn = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteclicked)];
    
    NSArray *bararray = [NSArray arrayWithObjects:delbtn,savebtn, nil];
    self.navigationItem.rightBarButtonItems = bararray;
    [self.view addSubview:self.mytextView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)saveclicked
{
    
    NSArray *tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    NSMutableArray *mutableArray = [tempArray mutableCopy];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init ];
    
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    
    NSDate *now = [NSDate date];
    NSString *datestring = [dateFormatter stringFromDate:now];
    NSString *textstring = [self.mytextView text];
    
    [mutableArray removeObjectAtIndex:self.index];
    [mutableArray insertObject:textstring atIndex:0];
    
    [[NSUserDefaults standardUserDefaults] setObject:mutableArray forKey:@"note"];
    
    rootViewController *rootctrl = [[rootViewController alloc]init];
    rootctrl.noteArray = mutableArray;
    
    NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
    
    [mutableDateArray removeObjectAtIndex:self.index];
    [mutableDateArray insertObject:datestring atIndex:0 ];
    
    rootctrl.dateArray = mutableDateArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
    
    [self.mytextView resignFirstResponder];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"保存成功!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)deleteclicked
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"确定删除？" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0)
    {
        NSArray *tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
        NSMutableArray *mutableArray = [tempArray mutableCopy];
        
        [mutableArray removeObjectAtIndex:self.index];
        [[NSUserDefaults standardUserDefaults] setObject:mutableArray forKey:@"note"];
        
        rootViewController *rootctrl = [[rootViewController alloc]init];
        rootctrl.noteArray = mutableArray;
        
        NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
        NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
        
        [mutableDateArray removeObjectAtIndex:self.index];
        [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
        rootctrl.dateArray = mutableDateArray;
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (buttonIndex == 1) return;
}

@end
