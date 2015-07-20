//
//  BaseInfoAnswerViewController.m
//  HDCInvestigate
//
//  Created by TsaoLipeng on 15/7/16.
//  Copyright (c) 2015年 TsaoLipeng. All rights reserved.
//

#import "BaseInfoAnswerViewController.h"
#import "Defines.h"
#import "ShareInstances.h"
#import "UIView+XD.h"
#import "Answer.h"
#import "TypeNStyleAnswerViewController.h"

@interface BaseInfoAnswerViewController()<UIAlertViewDelegate>

@end

@implementation BaseInfoAnswerViewController{
    UITextField *topic2_1TextFiled;
    UITextField *topic2_2TextFiled;
    UITextField *topic2_3TextFiled;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initialize];
}

-(void)initialize{
    [self.view setBackgroundColor:NORMAL_BACKGROUND_COLOR];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, STATU_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [ShareInstances addLabel:@"餐厅基本情况" withFrame:CGRectMake(0, STATU_BAR_HEIGHT, topView.width, NAVIGATION_BAR_HEIGHT) withSuperView:topView withTextColor:NORMAL_TEXT_COLOR withAlignment:NSTextAlignmentCenter withTextSize:TEXTSIZE_BIG];
    [ShareInstances addBottomBorderOnView:topView];
    [self.view addSubview:topView];
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, STATU_BAR_HEIGHT, 100, 44)];
    [cancelButton setBackgroundColor:[UIColor clearColor]];
    [cancelButton setTitleColor:LIGHT_TEXT_COLOR forState:UIControlStateNormal];
    [cancelButton setTitle:@"放弃" forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:TEXTSIZE_TITLE]];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancelButton];
    
    UIView *topic1View = [[UIView alloc] initWithFrame:CGRectMake(MARGIN_WIDE, topView.bottom + MARGIN_WIDE, self.view.width - MARGIN_WIDE * 2, TEXTSIZE_BIG + MARGIN_NARROW * 3 + 32)];
    [topic1View setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:topic1View];
    
    UILabel *topicTitle1 = [ShareInstances addLabel:@"您的餐厅名称是？" withFrame:CGRectMake(MARGIN_NARROW, MARGIN_NARROW, topic1View.width - MARGIN_NARROW * 2, TEXTSIZE_BIG) withSuperView:topic1View withTextColor:NORMAL_TEXT_COLOR withAlignment:NSTextAlignmentLeft withTextSize:TEXTSIZE_BIG];
    
    topic2_1TextFiled = [[UITextField alloc] initWithFrame:CGRectMake(MARGIN_NARROW, topicTitle1.bottom + MARGIN_NARROW, topic1View.width - MARGIN_NARROW * 2, 32)];
    [topic2_1TextFiled setBackgroundColor:[UIColor colorWithRed:0.2 green:0.9 blue:0.5 alpha:0.3]];
    [ShareInstances addTopBorderOnView:topic2_1TextFiled];
    [topic1View addSubview:topic2_1TextFiled];
    
    UIView *topic2View = [[UIView alloc] initWithFrame:CGRectMake(MARGIN_WIDE, topic1View.bottom + MARGIN_WIDE, self.view.width - MARGIN_WIDE * 2, TEXTSIZE_BIG + MARGIN_NARROW * 3 + 32)];
    [topic2View setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:topic2View];
    
    UILabel *topicTitle2 = [ShareInstances addLabel:@"您的餐厅台数是多少？" withFrame:CGRectMake(MARGIN_NARROW, MARGIN_NARROW, topic2View.width - MARGIN_WIDE * 2, TEXTSIZE_BIG) withSuperView:topic2View withTextColor:NORMAL_TEXT_COLOR withAlignment:NSTextAlignmentLeft withTextSize:TEXTSIZE_BIG];
    
    topic2_2TextFiled = [[UITextField alloc] initWithFrame:CGRectMake(MARGIN_NARROW, topicTitle2.bottom + MARGIN_NARROW, topic2View.width - MARGIN_NARROW * 2, 32)];
    [topic2_2TextFiled setBackgroundColor:[UIColor colorWithRed:0.2 green:0.9 blue:0.5 alpha:0.3]];
    [ShareInstances addTopBorderOnView:topic2_2TextFiled];
    topic2_2TextFiled.keyboardType = UIKeyboardTypeNumberPad;
    [topic2View addSubview:topic2_2TextFiled];
    
    UIView *topic3View = [[UIView alloc] initWithFrame:CGRectMake(MARGIN_WIDE, topic2View.bottom + MARGIN_WIDE, self.view.width - MARGIN_WIDE * 2, TEXTSIZE_BIG + MARGIN_NARROW * 3 + 32)];
    [topic3View setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:topic3View];
    
    UILabel *topicTitle3 = [ShareInstances addLabel:@"您的餐厅所在地址为？" withFrame:CGRectMake(MARGIN_NARROW, MARGIN_NARROW, topic3View.width - MARGIN_WIDE * 2, TEXTSIZE_BIG) withSuperView:topic3View withTextColor:NORMAL_TEXT_COLOR withAlignment:NSTextAlignmentLeft withTextSize:TEXTSIZE_BIG];
    
    topic2_3TextFiled = [[UITextField alloc] initWithFrame:CGRectMake(MARGIN_NARROW, topicTitle3.bottom + MARGIN_NARROW, topic3View.width - MARGIN_NARROW * 2, 32)];
    [topic2_2TextFiled setBackgroundColor:[UIColor colorWithRed:0.2 green:0.9 blue:0.5 alpha:0.3]];
    [ShareInstances addTopBorderOnView:topic2_3TextFiled];
    [topic2_3TextFiled setEnabled:NO];
    [topic2_3TextFiled setText:@"正在获取"];
    [topic2_3TextFiled setFont:[UIFont systemFontOfSize:TEXTSIZE_TITLE]];
    [topic3View addSubview:topic2_3TextFiled];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLocationUpdated:) name:KNOTIFICATION_LOCATIONUPDATED object:nil];
    
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap:)];
    [self.view addGestureRecognizer:gr];
    
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height - 44, self.view.width, 44)];
    [nextButton setBackgroundColor:[UIColor orangeColor]];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
}

- (void)onLocationUpdated:(NSNotification *)notification
{
    topic2_3TextFiled.text = [ShareInstances getLastAddress];
}

- (void) backgroundTap:(id)sender
{
    [topic2_1TextFiled resignFirstResponder];
    [topic2_2TextFiled resignFirstResponder];
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
    [topic2_1TextFiled setBackgroundColor:[UIColor colorWithRed:0.2 green:0.9 blue:0.5 alpha:0.3]];
    [topic2_2TextFiled setBackgroundColor:[UIColor colorWithRed:0.2 green:0.9 blue:0.5 alpha:0.3]];
    
    if ([topic2_1TextFiled.text isEqual: @""]) {
        [topic2_1TextFiled setBackgroundColor:[UIColor yellowColor]];
        [topic2_1TextFiled becomeFirstResponder];
    }else if([topic2_2TextFiled.text isEqual: @""]){
        [topic2_2TextFiled setBackgroundColor:[UIColor yellowColor]];
        [topic2_2TextFiled becomeFirstResponder];
    }else{
        Answer *answer = [ShareInstances getCurAnswer];
        answer.restaurantName = topic2_1TextFiled.text;
        answer.tableCount = [NSNumber numberWithInteger:[topic2_2TextFiled.text integerValue]];
        
        TypeNStyleAnswerViewController *tsaVC = [[TypeNStyleAnswerViewController alloc] init];
        [self.navigationController pushViewController:tsaVC animated:YES];
    }
}

@end
