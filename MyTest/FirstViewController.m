//
//  FirstViewController.m
//  MyTest
//
//  Created by MacMini on 15/12/10.
//  Copyright © 2015年 PowerAll. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_tableData;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //初始化数据
    [self initData];
    
    //创建一个分组样式的UITableView
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    //设置数据源，注意必须实现对应的UITableViewDataSource协议
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 加载数据
-(void)initData{
    _tableData=[[NSMutableArray alloc]init];
    
    NSString *sectionName = @"section0";
    
    NSMutableArray *secArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 1000; i++) {
        if (i%5 == 0) {
            sectionName = [[NSString alloc]initWithFormat:@"section%d",i/5];
            [secArray addObject:sectionName];
        }
        NSString *title = [[NSString alloc]initWithFormat:@"titile%d",i];
        NSString *content = [[NSString alloc]initWithFormat:@"content%d",i];
        [secArray addObject:[[NSArray alloc]initWithObjects:title,content, nil]];
        if (i%5 == 4) {
            [_tableData addObject:[secArray copy]];
            [secArray removeAllObjects];
        }
    }
}

#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"计算分组数");
    return _tableData.count;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"计算每组(组%i)行数",section);
    NSMutableArray *group=_tableData[section];
    return group.count - 1;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    NSLog(@"生成单元格(组：%i,行%i)",indexPath.section,indexPath.row);
    NSMutableArray *group=_tableData[indexPath.section];
    NSMutableArray *data=group[indexPath.row + 1];
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text=data[0];
    cell.detailTextLabel.text=data[1];
    return cell;
}

#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSLog(@"生成组（组%i）名称",section);
    NSMutableArray *group=_tableData[section];
    return group[0];
}


@end
