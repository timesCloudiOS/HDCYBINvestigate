//
//  TypeNStyleAnswerViewController.m
//  HDCInvestigate
//
//  Created by TsaoLipeng on 15/7/17.
//  Copyright (c) 2015年 TsaoLipeng. All rights reserved.
//

#import "TypeNStyleAnswerViewController.h"
#import "Defines.h"
#import "ShareInstances.h"
#import "UIView+XD.h"
#import "Answer.h"
#import <DKFilterView/DKFilterView.h>
#import "CooperativeAnswerViewController.h"

@interface TypeNStyleAnswerViewController()<DKFilterViewDelegate, UIAlertViewDelegate>

@end

@implementation TypeNStyleAnswerViewController{
    DKFilterView *filterView;
    DKFilterModel *typeModel;
    DKFilterModel *styleModel;
    NSArray *typeFilterData;
    NSArray *styleFilterData;
    NSInteger lastTypeIndex;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    Answer *curAnswer = [ShareInstances getCurAnswer];
    curAnswer.restaurantType = [NSNumber numberWithInteger:-1];
    curAnswer.styleOfCooking = [NSNumber numberWithInteger:-1];
    [self initialize];
}

-(void)initialize{
    [self.view setBackgroundColor:NORMAL_BACKGROUND_COLOR];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, STATU_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [ShareInstances addLabel:@"餐厅类型" withFrame:CGRectMake(0, STATU_BAR_HEIGHT, topView.width, NAVIGATION_BAR_HEIGHT) withSuperView:topView withTextColor:NORMAL_TEXT_COLOR withAlignment:NSTextAlignmentCenter withTextSize:TEXTSIZE_BIG];
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
    typeFilterData = @[@"中餐",@"火锅",@"大排档",@"烧烤",@"亚洲餐",@"西餐",@"夜场"];
    typeModel = [[DKFilterModel alloc] initElement:typeFilterData ofType:DK_SELECTION_SINGLE];
    typeModel.title = @"餐厅类型";
    typeModel.style = DKFilterViewDefault;
    lastTypeIndex = -1;
    
    [filterView setFilterModels:@[typeModel]];
    
    [answerView addSubview:filterView];
    
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height - 44, self.view.width, 44)];
    [nextButton setBackgroundColor:[UIColor orangeColor]];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
}

- (void)didClickAtModel:(DKFilterModel *)data{
    Answer *curAnswer = [ShareInstances getCurAnswer];
    if (data == typeModel) {
        NSString *selectedTypeString = data.clickedButtonText;
        NSInteger selectedTypeIndex = [typeFilterData indexOfObject:selectedTypeString] + 1;//文档定义的索引值从1开始
        curAnswer.restaurantType = [NSNumber numberWithInteger:selectedTypeIndex];
        if (lastTypeIndex != selectedTypeIndex) {//如果这次选中的和上次选中的类型不同，则清空菜系
            curAnswer.styleOfCooking = [NSNumber numberWithInteger:-1];
        }
        lastTypeIndex = selectedTypeIndex;
        switch (selectedTypeIndex) {
            case 1:
                styleFilterData = @[@"川菜",@"粤菜",@"西北菜",@"北方菜",@"其它"];
                break;
            case 2:
                styleFilterData = @[@"川味火锅",@"海底捞",@"鸡煲",@"其它"];
                break;
            case 3:
                styleFilterData = @[@"大排档"];
                break;
            case 4:
                styleFilterData = @[@"烧烤"];
                break;
            case 5:
                styleFilterData = @[@"泰餐",@"日本餐厅",@"韩国餐厅",@"其它"];
                break;
            case 6:
                styleFilterData = @[@"西餐"];
                break;
            case 7:
                styleFilterData = @[@"酒吧",@"KTV",@"其它"];
                break;
            default:
                break;
        }
        styleModel = [[DKFilterModel alloc] initElement:styleFilterData ofType:DK_SELECTION_SINGLE];
        styleModel.title = @"菜系";
        styleModel.style = DKFilterViewDefault;
        [filterView setFilterModels:@[typeModel, styleModel]];
    } else if (data == styleModel){
        NSString *selectedStyleString = data.clickedButtonText;
        NSInteger selectedStyleIndex = [styleFilterData indexOfObject:selectedStyleString] + 1;//文档定义的索引值从1开始
        NSInteger styleFullIndex = ([curAnswer.restaurantType integerValue] - 1) * 10 + selectedStyleIndex;
        curAnswer.styleOfCooking = [NSNumber numberWithInteger:styleFullIndex];
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
    if ([curAnswer.restaurantType integerValue] == -1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择餐厅类型" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    } else if ([curAnswer.styleOfCooking integerValue] == -1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择菜系" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
    } else{
        CooperativeAnswerViewController *caVC = [[CooperativeAnswerViewController alloc] init];
        [self.navigationController pushViewController:caVC animated:YES];
    }
}

@end
