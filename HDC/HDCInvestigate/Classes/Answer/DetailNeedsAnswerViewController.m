//
//  DetailNeedsAnswerViewController.m
//  HDCInvestigate
//
//  Created by TsaoLipeng on 15/7/17.
//  Copyright (c) 2015年 TsaoLipeng. All rights reserved.
//

#import "DetailNeedsAnswerViewController.h"
#import "Defines.h"
#import "ShareInstances.h"
#import "UIView+XD.h"
#import "Answer.h"
#import <DKFilterView/DKFilterView.h>
#import "DetailNeedTableViewCell.h"
#import "DetailNeeds.h"
#import "DetailNeedInputViewController.h"
#import "SVProgressHUD.h"

@interface DetailNeedsAnswerViewController()<UITableViewDataSource, UITableViewDelegate, DetailNeedInputViewControllerDelegate, UIAlertViewDelegate>

@end

@implementation DetailNeedsAnswerViewController{
    NSArray *productArray;
    NSMutableArray *detailNeedsArray;
    UITableView *needsTableView;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initialize];
}

-(void)initialize{
    [self.view setBackgroundColor:NORMAL_BACKGROUND_COLOR];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, STATU_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [ShareInstances addLabel:@"具体需求量" withFrame:CGRectMake(0, STATU_BAR_HEIGHT, topView.width, NAVIGATION_BAR_HEIGHT) withSuperView:topView withTextColor:NORMAL_TEXT_COLOR withAlignment:NSTextAlignmentCenter withTextSize:TEXTSIZE_BIG];
    [ShareInstances addBottomBorderOnView:topView];
    [self.view addSubview:topView];
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, STATU_BAR_HEIGHT, 100, 44)];
    [cancelButton setBackgroundColor:[UIColor clearColor]];
    [cancelButton setTitleColor:LIGHT_TEXT_COLOR forState:UIControlStateNormal];
    [cancelButton setTitle:@"放弃" forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:TEXTSIZE_TITLE]];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancelButton];
    
    UIScrollView *answerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topView.bottom, self.view.width, self.view.height - topView.bottom - 44)];
    [answerView setBackgroundColor:NORMAL_BACKGROUND_COLOR];
    [self.view addSubview:answerView];
    
    productArray = [[NSArray alloc] initWithObjects:
                    [NSArray arrayWithObjects:@"茼蒿",
                                               @"木耳菜",
                                               @"油麦菜",
                                               @"空心菜",
                                               @"飘儿白",
                                               @"红薯叶",
                                               @"菠菜",
                                               @"生菜",
                                               @"娃娃菜",
                                               @"大白菜",
                                               @"小白菜",
                                               @"紫甘蓝",
                                               @"圆白菜",
                                               @"西兰花",
                                               @"花椰菜",
                                               @"苋菜",
                                               @"莲藕",
                                               @"茭白",
                                               @"白萝卜",
                                               @"胡萝卜",
                                               @"红薯",
                                               @"土豆",
                                               @"芋头",
                                               @"竹笋",
                                               @"山药",
                                               @"凉薯",
                                               @"四季豆",
                                               @"扁豆",
                                               @"豆角",
                                               @"黄豆",
                                               @"刀豆",
                                               @"荷兰豆",
                                               @"毛豆",
                                               @"豌豆",
                                               @"冬瓜",
                                               @"南瓜",
                                               @"青皮南瓜",
                                               @"黄瓜",
                                               @"瓠瓜",
                                               @"丝瓜",
                                               @"苦瓜",
                                               @"西葫芦",
                                               @"青瓜",
                                               @"节瓜",
                                               @"紫茄",
                                               @"绿茄",
                                               @"番茄",
                                               @"彩椒",
                                               @"尖椒",
                                               @"青椒",
                                               @"小米椒",
                                               @"柿子椒",
                                               @"其他优质蔬菜",
                     nil],
                    [NSArray arrayWithObjects:@"洋葱",
                           @"香菜",
                           @"韭菜",
                           @"韭黄",
                           @"大葱",
                           @"香葱",
                           @"大蒜",
                           @"生姜",
                           @"香芹",
                           @"调味品",
                           @"其他配料", nil],
                    [NSArray arrayWithObjects:@"香菇",
                           @"平菇",
                           @"牛肝菌",
                           @"金针菜",
                           @"茶树菇",
                           @"金针菇",
                           @"猴头菇",
                           @"竹荪",
                           @"鸡腿菇",
                           @"杏鲍菇",
                           @"其他优质菌菇", nil],
                    [NSArray arrayWithObjects:@"葡萄",
                           @"西瓜",
                           @"苹果",
                           @"芒果",
                           @"杏",
                           @"桃",
                           @"李",
                           @"木瓜",
                           @"哈密瓜",
                           @"提子",
                           @"山竹",
                           @"香蕉",
                           @"火龙果",
                           @"菠萝",
                           @"其他优质鲜果", nil],
                    [NSArray arrayWithObjects:@"土鸡（蛋）",
                           @"土鸭（蛋）",
                           @"鹅（蛋）",
                           @"鸽子（蛋）",
                           @"火鸡",
                           @"鸽子",
                           @"鸵鸟",
                           @"鹌鹑",
                           @"其他禽蛋产品", nil],
                    [NSArray arrayWithObjects:@"猪肉",
                           @"牛肉",
                           @"羊肉",
                           @"羊羔肉",
                           @"兔肉",
                           @"鸡肉",
                           @"鸭肉",
                           @"火鸡肉",
                           @"青蛙",
                           @"其他优质肉品", nil],
                    [NSArray arrayWithObjects:@"面粉",
                           @"大米",
                           @"大豆油",
                           @"棉油",
                           @"菜油",
                           @"米糠油",
                           @"玉米油",
                           @"其他优质粮油", nil],
                    [NSArray arrayWithObjects:@"八角",
                           @"黄花菜",
                           @"银耳",
                           @"木耳",
                           @"紫菜",
                           @"香菇",
                           @"红枣",
                           @"桂皮",
                           @"辣椒",
                           @"花椒",
                           @"茴香",
                           @"胡椒",
                           @"枸杞",
                           @"桂圆",
                           @"花生",
                     @"其他优质干货", nil], nil];
    
    [self initDetailNeeds];

    needsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, answerView.width, answerView.height)];
    needsTableView.delegate = self;
    needsTableView.dataSource = self;
    needsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [answerView addSubview:needsTableView];
    
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height - 44, self.view.width, 44)];
    [nextButton setBackgroundColor:[UIColor orangeColor]];
    [nextButton setTitle:@"完成提交" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
}

-(void)initDetailNeeds{
    detailNeedsArray = [[NSMutableArray alloc] init];
    Answer *curAnswer = [ShareInstances getCurAnswer];
    for (NSNumber *productIndex in curAnswer.favoriteProducts) {
        DetailNeeds *needs = [DetailNeeds object];
        NSInteger firstIndex = [productIndex integerValue] / 100;
        NSInteger secondIndex = [productIndex integerValue] % 100 - 1;
        NSString *productName = [[productArray objectAtIndex:firstIndex] objectAtIndex:secondIndex];
        needs.productName = productName;
        needs.productNo = productIndex;
        [detailNeedsArray addObject:needs];
    }
}

-(void)cancelButtonClick{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认要放弃吗？" message:@"若现在放弃，当前问卷已填写的部分将会丢失，请确认。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定放弃", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(void)nextButtonClick{
    Answer *curAnswer = [ShareInstances getCurAnswer];
    AVRelation *relation = [curAnswer relationforKey:@"detailNeeds"];
    for (DetailNeeds *needs in detailNeedsArray) {
        [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"正在上传“%@”产品的需求数据", needs.productName]];
        [needs save];
        [relation addObject:needs];
    }
    
    [SVProgressHUD showWithStatus:@"正在上传问卷主体"];
    [curAnswer saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [SVProgressHUD dismissWithSuccess:@"上传成功" afterDelay:2];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [SVProgressHUD dismissWithError:@"上传失败，请检查网络后重试" afterDelay:2];
        }
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Answer *answer = [ShareInstances getCurAnswer];
    return [answer.favoriteProducts count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kDetailNeedsCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *vCellIdentify = @"detailNeedsCell";
    DetailNeedTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vCellIdentify];
    if (vCell == nil) {
        vCell = [[DetailNeedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vCellIdentify];
        
        vCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    DetailNeeds *needs = [detailNeedsArray objectAtIndex:indexPath.row];
    [vCell setDetailNeeds:needs];
    
    return vCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailNeeds *needs = [detailNeedsArray objectAtIndex:indexPath.row];
    DetailNeedInputViewController *dniVC = [[DetailNeedInputViewController alloc] init];
    dniVC.detailNeeds = needs;
    dniVC.rowIndex = indexPath.row;
    dniVC.delegate = self;
    [self.navigationController pushViewController:dniVC animated:YES];
}

-(void)detailNeedsChanged:(NSInteger)rowIndex{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:0];
    [needsTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
}

@end
