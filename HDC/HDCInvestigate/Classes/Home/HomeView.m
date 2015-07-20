//
//  HomeView.m
//  eTong
//
//  Created by TsaoLipeng on 15/6/13.
//  Copyright (c) 2015年 TsaoLipeng. All rights reserved.
//

#import "HomeView.h"
#import "UIView+XD.h"
#import "Defines.h"
#import "ShareInstances.h"
#import "Answer.h"
#import "MJRefresh.h"
#import "AnswerTableViewCell.h"
#import "CustomLocationManager.h"
#import "BaseInfoAnswerViewController.h"

#define COUNT_PER_LOADING 20

NSString *const TableViewCellIdentifier = @"AnswerCell";

@interface HomeView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) UIViewController *rootViewController;

@end

@implementation HomeView{
    NSInteger _loadedCount;
    NSMutableArray *headLinesArray;
    NSMutableArray *answerArray;
    UILabel *countLabel;
}

- (id)initWithFrame:(CGRect)frame withController:(UIViewController *)controller{
    self = [super initWithFrame:frame];
    _rootViewController = controller;
    [self initialize];
    return self;
}

-(void)initialize{
    _loadedCount = 0;
    answerArray = [[NSMutableArray alloc] init];
    
    countLabel = [ShareInstances addLabel:@"" withFrame:CGRectMake(MARGIN_NARROW, MARGIN_NARROW, self.width, TEXTSIZE_BIG) withSuperView:self withTextColor:[UIColor blueColor] withAlignment:NSTextAlignmentLeft withTextSize:TEXTSIZE_BIG];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, countLabel.bottom + MARGIN_NARROW, self.width, self.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    [_tableView registerClass:[AnswerTableViewCell class] forCellReuseIdentifier:TableViewCellIdentifier];
    [self setupRefresh];
    
    UIButton *newAnswerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height - 44, self.width, 44)];
    [newAnswerButton setBackgroundColor:[UIColor orangeColor]];
    [newAnswerButton setTitle:@"新建答卷" forState:UIControlStateNormal];
    [newAnswerButton addTarget:self action:@selector(AnswerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:newAnswerButton];
}

-(void)AnswerButtonClick{
    Answer *newAnswer = [Answer object];
    newAnswer.date = [NSDate date];
    newAnswer.interviewer = [AVUser currentUser];
    newAnswer.interviewerPhoneNo = [[AVUser currentUser] mobilePhoneNumber];
    [[CustomeLocationManager defaultManager] updateLocation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLocationUpdated:) name:KNOTIFICATION_LOCATIONUPDATED object:nil];
    
    [ShareInstances setCurAnswer:newAnswer];
    
    BaseInfoAnswerViewController *baseInfoAnswerVC = [[BaseInfoAnswerViewController alloc] init];
    [self.rootViewController.navigationController pushViewController:baseInfoAnswerVC animated:YES];
}

- (void)onLocationUpdated:(NSNotification *)notification
{
    Answer *curAnswer = [ShareInstances getCurAnswer];
    if (curAnswer != nil){
        curAnswer.location = [ShareInstances getLastGeoPoint];
        curAnswer.address = [ShareInstances getLastAddress];
    }
}

- (void)setupRefresh
{
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    _tableView.header.autoChangeAlpha = YES;
    
    //下拉刷新
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataByClearAll:YES withComplete:^{
            [_tableView.header endRefreshing];
            [_tableView reloadData];
        }];
    }];
    
    // 上拉刷新
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadDataByClearAll:NO withComplete:^{
            [_tableView.footer endRefreshing];
            [_tableView reloadData];
        }];
    }];
    
    [_tableView.header beginRefreshing];
}

//从AVCloud查询数据并刷新界面
- (void)loadDataByClearAll:(BOOL)needClearAll withComplete:(void(^)())complete{
    AVQuery *query = [Answer query];
    [query whereKey:@"interviewer" equalTo:[AVUser currentUser]];
    [query orderByDescending:@"date"];
    query.limit = COUNT_PER_LOADING;
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    query.maxCacheAge = 3600*24*7;//缓存一周时间
    if (!needClearAll)
        query.skip = self->_loadedCount;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            if (needClearAll){
                self->_loadedCount = objects.count;
                [answerArray removeAllObjects];
            }else{
                self->_loadedCount += objects.count;
            }
            
            for (Answer *answer in objects) {
                [answerArray addObject:answer];
            }
            
            if (complete) {
                complete(objects.count);
            }
        }
    }];
    
    [self queryCount];
}

-(void)queryCount{
    AVQuery *query = [Answer query];
    [query whereKey:@"interviewer" equalTo:[AVUser currentUser]];
    [query countObjectsInBackgroundWithBlock:^(NSInteger number, NSError *error) {
        if (!error) {
            countLabel.text = [NSString stringWithFormat:@"您已完成的餐厅问卷已有 %ld 份", (long)number];
        }
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [answerArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kAnswerCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *vCellIdentify = @"AnswerCell";
    AnswerTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vCellIdentify];
    if (vCell == nil) {
        vCell = [[AnswerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vCellIdentify];
    }

    [vCell setAnswer:[answerArray objectAtIndex:indexPath.row]];
    
    return vCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MJTestViewController *test = [[MJTestViewController alloc] init];
//    [self.navigationController pushViewController:test animated:YES];
}

@end
