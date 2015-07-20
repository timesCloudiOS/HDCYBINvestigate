//
//  CooperativeAnswerViewController.m
//  HDCInvestigate
//
//  Created by TsaoLipeng on 15/7/17.
//  Copyright (c) 2015年 TsaoLipeng. All rights reserved.
//

#import "CooperativeAnswerViewController.h"
#import "Defines.h"
#import "ShareInstances.h"
#import "UIView+XD.h"
#import "Answer.h"
#import <DKFilterView/DKFilterView.h>
#import "needsSelecteViewController.h"

@interface CooperativeAnswerViewController()<DKFilterViewDelegate, UIAlertViewDelegate>

@end

@implementation CooperativeAnswerViewController{
    DKFilterView *filterView;
    DKFilterModel *model4_1, *model4_2, *model4_3, *model4_4, *model4_5;
    NSArray *filterData4_1;
    NSArray *filterData4_2;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initialize];
}

-(void)initialize{
    [self.view setBackgroundColor:NORMAL_BACKGROUND_COLOR];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, STATU_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [ShareInstances addLabel:@"合作意向" withFrame:CGRectMake(0, STATU_BAR_HEIGHT, topView.width, NAVIGATION_BAR_HEIGHT) withSuperView:topView withTextColor:NORMAL_TEXT_COLOR withAlignment:NSTextAlignmentCenter withTextSize:TEXTSIZE_BIG];
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
    
    filterView = [[DKFilterView alloc] initWithFrame:self.view.frame];
    filterView.delegate = self;
    filterData4_1 = @[@"早4点~7点",@"早7点~9点",@"早9点~11点",@"其它"];
    filterData4_2 = @[@"非常乐意",@"可以考虑",@"不感兴趣"];
    model4_1 = [[DKFilterModel alloc] initElement:filterData4_1 ofType:DK_SELECTION_SINGLE];
    model4_2 = [[DKFilterModel alloc] initElement:filterData4_2 ofType:DK_SELECTION_SINGLE];
    model4_3 = [[DKFilterModel alloc] initElement:filterData4_2 ofType:DK_SELECTION_SINGLE];
    model4_4 = [[DKFilterModel alloc] initElement:filterData4_2 ofType:DK_SELECTION_SINGLE];
    model4_5 = [[DKFilterModel alloc] initElement:filterData4_2 ofType:DK_SELECTION_SINGLE];

    model4_1.title = @"如果在平台订购农产品，您希望的送货时间是？";
    model4_2.title = @"菜价若优惠5%，您使用平台的意愿是？";
    model4_3.title = @"菜价若优惠10%，您使用平台的意愿是？";
    model4_4.title = @"菜价若优惠15%，您使用平台的意愿是？";
    model4_5.title = @"菜价若优惠20%，您使用平台的意愿是？";
    
    [filterView setFilterModels:@[model4_1, model4_2]];
    
    [answerView addSubview:filterView];
    
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height - 44, self.view.width, 44)];
    [nextButton setBackgroundColor:[UIColor orangeColor]];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
}

- (void)didClickAtModel:(DKFilterModel *)data{
    Answer *curAnswer = [ShareInstances getCurAnswer];
    if (data == model4_1) {
        NSString *selected4_1String = data.clickedButtonText;
        NSInteger selected4_1Index = [filterData4_1 indexOfObject:selected4_1String] + 1;//文档定义的索引值从1开始
        curAnswer.answer4_1 = [NSNumber numberWithInteger:selected4_1Index];
    } else if (data == model4_2){
        NSString *selectedString = data.clickedButtonText;
        NSInteger selectedIndex = [filterData4_2 indexOfObject:selectedString] + 1;
        curAnswer.answer4_2 = [NSNumber numberWithInteger:selectedIndex];
        
        if (selectedIndex > 1) {//选择的不是“非常乐意”，则需要显示下一题
            [filterView setFilterModels:@[model4_1, model4_2, model4_3]];
        }else{
            [filterView setFilterModels:@[model4_1, model4_2]];
        }
    } else if (data == model4_3){
        NSString *selectedString = data.clickedButtonText;
        NSInteger selectedIndex = [filterData4_2 indexOfObject:selectedString] + 1;
        curAnswer.answer4_3 = [NSNumber numberWithInteger:selectedIndex];
        
        if (selectedIndex > 1) {//选择的不是“非常乐意”，则需要显示下一题
            [filterView setFilterModels:@[model4_1, model4_2, model4_3, model4_4]];
        }else{
            [filterView setFilterModels:@[model4_1, model4_2, model4_3]];
        }
    } else if (data == model4_4){
        NSString *selectedString = data.clickedButtonText;
        NSInteger selectedIndex = [filterData4_2 indexOfObject:selectedString] + 1;
        curAnswer.answer4_4 = [NSNumber numberWithInteger:selectedIndex];
        
        if (selectedIndex > 1) {//选择的不是“非常乐意”，则需要显示下一题
            [filterView setFilterModels:@[model4_1, model4_2, model4_3, model4_4, model4_5]];
        }else{
            [filterView setFilterModels:@[model4_1, model4_2, model4_3, model4_4]];
        }
    } else if (data == model4_5){
        NSString *selectedString = data.clickedButtonText;
        NSInteger selectedIndex = [filterData4_2 indexOfObject:selectedString] + 1;
        curAnswer.answer4_5 = [NSNumber numberWithInteger:selectedIndex];
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
    if (curAnswer.answer4_1 == nil || curAnswer.answer4_2 == nil || ([curAnswer.answer4_2 integerValue] > 1 && curAnswer.answer4_3 == nil) || ([curAnswer.answer4_3 integerValue] > 1 && curAnswer.answer4_4 == nil) || ([curAnswer.answer4_4 integerValue] > 1 && curAnswer.answer4_5 == nil)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请将所有题目填写完整" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        needsSelecteViewController *nsVC = [[needsSelecteViewController alloc] init];
        nsVC.mode = 1;
        [self.navigationController pushViewController:nsVC animated:YES];
    }
}

@end
