//
//  rootViewController.m
//  备忘录。
//
//  Created by apple on 15/4/30.
//  Copyright (c) 2015年 Lin. All rights reserved.
//

#import "rootViewController.h"
#import "addNoteViewController.h"
#import "noteDetailViewController.h"

@interface rootViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate>

@property NSMutableArray *filteredNoteArray;
@property UISearchBar *bar;
@property UISearchDisplayController *searchDispCtrl;//为UITableView搜索封装的一个类

@end

@implementation rootViewController
@synthesize noteArray,dateArray,filteredNoteArray,bar,searchDispCtrl;

- (id)initWithStyle:(UITableViewStyle)style//指定初始化，UITableViewStyle决定UITableView对象的风格
{
    //调用父类实现初始化
    self = [super initWithStyle:style];
    if (self)
    {
        self.view.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];//用于数据的永久保存，需要键值对来完成
    self.noteArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];//取
    self.dateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    [self.tableView reloadData]; // to reload selected cell
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *addbtn = [[UIBarButtonItem alloc]initWithTitle:@"新建" style:UIBarButtonItemStylePlain target:self action:@selector(addnote)];
    
    self.navigationItem.rightBarButtonItem = addbtn;
    self.navigationItem.title = @"备忘录";
    
    bar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 44)];
    searchDispCtrl = [[UISearchDisplayController alloc]initWithSearchBar:bar contentsController:self];
    searchDispCtrl.delegate = self;
    searchDispCtrl.searchResultsDataSource = self;
    searchDispCtrl.searchResultsDelegate = self;
    self.tableView.tableHeaderView = bar;
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source数据源方法决定多少组
//UITableView视图，要有数据源才可以工作，它的对象会向数据源查询要显示的行，表格，凡是遵守UITableViewDataSourec协议的OC对象都可以成为UITableView对象的数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView//有符号整数
{
    return 1;//分组
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section//行
{//UITableView可以分段显示数据，每个表格段（section）包含一组独立的行
    
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [filteredNoteArray count];
    }
    else return [noteArray count];
}
//设置数据

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath//各行所需视图
{
    static NSString *CellIdentifier = @"Cell";//表视图每一行都是一个独立的视图，都是UITableViewCell的对象
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    //当用户滚动UITable对象时，部分UITableViewCell对象会移窗口，放入UITableViewCell对象池，数据源可以先查看对象池，如果有未使用的cell对象，就可以用新的数据配置UITableViewCell对象，然后返回给UITableView对象，避免创建新的对象
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];//reuseIdentifier:当数据源向UITableView对象获取可用的UITableViewCell对象时，可以传入一个字符串并且要求UITableView对象返回相应的UITableViewCell对象，这些对象的reuseIdentifier的属性必须和传入的字符串相同
    }
    //每行显示的数据
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *note  = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        note = [filteredNoteArray objectAtIndex:indexPath.row];
    }
    
    else if(tableView == self.tableView)
    {
        note = [noteArray objectAtIndex:indexPath.row];
    };
    
    NSString *date = [dateArray objectAtIndex:indexPath.row];
    NSUInteger charnum = [note length];
    //无符号整数
    if (charnum < 22)
    {
        cell.textLabel.text = note;
    }
    else{
        cell.textLabel.text = [[note substringToIndex:18] stringByAppendingString:@"..."];
    }
    cell.detailTextLabel.text = date;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    noteDetailViewController *modifyCtrl = [[noteDetailViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:modifyCtrl animated:NO];
    NSInteger row = [indexPath row];
    modifyCtrl.index = row;
}

- (void)addnote
{
    addNoteViewController *detailViewCtrl = [[addNoteViewController alloc]
                                             initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:detailViewCtrl animated:YES];
    
}

#pragma mark uisearchdisplaydelegate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [filteredNoteArray removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchString];
    NSArray *tempArray = [noteArray filteredArrayUsingPredicate:predicate];
    filteredNoteArray = [NSMutableArray arrayWithArray:tempArray];
    
    return YES;
}

@end
