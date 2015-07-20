//
//  needsSelecteViewController.m
//  HDCInvestigate
//
//  Created by TsaoLipeng on 15/7/17.
//  Copyright (c) 2015年 TsaoLipeng. All rights reserved.
//

#import "needsSelecteViewController.h"
#import "Defines.h"
#import "ShareInstances.h"
#import "UIView+XD.h"
#import "Answer.h"
#import <DKFilterView/DKFilterView.h>
#import "DetailNeedsAnswerViewController.h"

@interface needsSelecteViewController()<DKFilterViewDelegate, UIAlertViewDelegate>

@end

@implementation needsSelecteViewController{
    DKFilterView *filterView;
    DKFilterModel *model;
    NSArray *filterData;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initialize];
}

-(void)initialize{
    [self.view setBackgroundColor:NORMAL_BACKGROUND_COLOR];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, STATU_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [ShareInstances addLabel:@"农产品需求" withFrame:CGRectMake(0, STATU_BAR_HEIGHT, topView.width, NAVIGATION_BAR_HEIGHT) withSuperView:topView withTextColor:NORMAL_TEXT_COLOR withAlignment:NSTextAlignmentCenter withTextSize:TEXTSIZE_BIG];
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
    [answerView setContentSize:CGSizeMake(answerView.width, 674)];
    
    filterView = [[DKFilterView alloc] initWithFrame:self.view.frame];
    filterView.delegate = self;
    NSString *modelTitle = @"";
    switch (_mode) {
        case 1:
            filterData = @[@"茼蒿",
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
                           @"其他优质蔬菜"];
            modelTitle = @"您的餐厅平时会采购的蔬菜包括:";
            break;
        case 2:
            filterData = @[@"洋葱",
                           @"香菜",
                           @"韭菜",
                           @"韭黄",
                           @"大葱",
                           @"香葱",
                           @"大蒜",
                           @"生姜",
                           @"香芹",
                           @"调味品",
                           @"其他配料"];
            modelTitle = @"您的餐厅平时会采购的配料包括：";
            break;
        case 3:
            filterData = @[@"香菇",
                           @"平菇",
                           @"牛肝菌",
                           @"金针菜",
                           @"茶树菇",
                           @"金针菇",
                           @"猴头菇",
                           @"竹荪",
                           @"鸡腿菇",
                           @"杏鲍菇",
                           @"其他优质菌菇"];
            modelTitle = @"您的餐厅平时会采购的菌菇包括：";
            break;
        case 4:
            filterData = @[@"葡萄",
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
                           @"其他优质鲜果"];
            modelTitle = @"您的餐厅平时会采购的水果包括：";
            break;
        case 5:
            filterData = @[@"土鸡（蛋）",
                           @"土鸭（蛋）",
                           @"鹅（蛋）",
                           @"鸽子（蛋）",
                           @"火鸡",
                           @"鸽子",
                           @"鸵鸟",
                           @"鹌鹑",
                           @"其他禽蛋产品"];
            modelTitle = @"您的餐厅平时会采购的禽蛋包括：";
            break;
        case 6:
            filterData = @[@"猪肉",
                           @"牛肉",
                           @"羊肉",
                           @"羊羔肉",
                           @"兔肉",
                           @"鸡肉",
                           @"鸭肉",
                           @"火鸡肉",
                           @"青蛙",
                           @"其他优质肉品"];
            modelTitle = @"您的餐厅平时会采购的肉类包括：";
            break;
        case 7:
            filterData = @[@"面粉",
                           @"大米",
                           @"大豆油",
                           @"棉油",
                           @"菜油",
                           @"米糠油",
                           @"玉米油",
                           @"其他优质粮油"];
            modelTitle = @"您的餐厅平时会采购的粮油包括：";
            break;
        case 8:
            filterData = @[@"八角",
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
                           @"其他优质干货"];
            modelTitle = @"您的餐厅平时会采购的干货包括：";
            break;
        default:
            break;
    }
    model = [[DKFilterModel alloc] initElement:filterData ofType:DK_SELECTION_MULTIPLE];
    
    model.title = modelTitle;
    
    [filterView setFilterModels:@[model]];
    
    [answerView addSubview:filterView];
    
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height - 44, self.view.width, 44)];
    [nextButton setBackgroundColor:[UIColor orangeColor]];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
}

-(void)fillDataAndJump{
    Answer *curAnswer = [ShareInstances getCurAnswer];
    NSMutableArray *mutableFpArray = [NSMutableArray arrayWithArray:curAnswer.favoriteProducts];
    
    NSArray *selectedArray = [model getFilterResult];
    
    for (NSString *str in selectedArray) {
        NSInteger index = [filterData indexOfObject:str] + 1;
        NSInteger fullIndex = (_mode - 1) * 100 + index;
        [mutableFpArray addObject:[NSNumber numberWithInteger:fullIndex]];
    }
    
    curAnswer.favoriteProducts = mutableFpArray;
    if (_mode < 8) {//为8时跳转到详情页
        needsSelecteViewController *nsVC = [[needsSelecteViewController alloc] init];
        nsVC.mode = _mode + 1;
        [self.navigationController pushViewController:nsVC animated:YES];
    }else{
        DetailNeedsAnswerViewController *dnaVC = [[DetailNeedsAnswerViewController alloc] init];
        [self.navigationController pushViewController:dnaVC animated:YES];
    }
}

-(void)cancelButtonClick{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认要放弃吗？" message:@"若现在放弃，当前问卷已填写的部分将会丢失，请确认。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定放弃", nil];
    alertView.tag = 1;
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if (alertView.tag == 0) {
            [self fillDataAndJump];
        } else if (alertView.tag == 1) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}


-(void)nextButtonClick{
    NSArray *selectedArray = [model getFilterResult];
    if (selectedArray.count == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请注意" message:@"您没有选中任何选项，是否确认继续？" delegate:self cancelButtonTitle:@"返回选择" otherButtonTitles:@"确定", nil];
        alertView.tag = 0;
        [alertView show];
    }else{
        [self fillDataAndJump];
    }
}

@end
