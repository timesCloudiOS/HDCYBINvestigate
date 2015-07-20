//
//  DetailNeedInputViewController.m
//  HDCInvestigate
//
//  Created by TsaoLipeng on 15/7/18.
//  Copyright (c) 2015年 TsaoLipeng. All rights reserved.
//

#import "DetailNeedInputViewController.h"
#import "Defines.h"
#import "ShareInstances.h"
#import "UIView+XD.h"
#import "Answer.h"
#import "DetailNeeds.h"
#import "needsSelecteViewController.h"

@interface DetailNeedInputViewController()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *needPerDayTextField;
@property (nonatomic, strong) UITextField *needPerMonthTextField;
@property (nonatomic, strong) UITextField *remarkTextField;

@end


@implementation DetailNeedInputViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self initialize];
}

-(void)initialize{
    [self.view setBackgroundColor:NORMAL_BACKGROUND_COLOR];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, STATU_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [ShareInstances addLabel:_detailNeeds.productName withFrame:CGRectMake(0, STATU_BAR_HEIGHT, topView.width, NAVIGATION_BAR_HEIGHT) withSuperView:topView withTextColor:NORMAL_TEXT_COLOR withAlignment:NSTextAlignmentCenter withTextSize:TEXTSIZE_BIG];
    [ShareInstances addBottomBorderOnView:topView];
    [self.view addSubview:topView];
    
    UIScrollView *answerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topView.bottom, self.view.width, self.view.height - topView.bottom)];
    [answerView setBackgroundColor:NORMAL_BACKGROUND_COLOR];
    [self.view addSubview:answerView];
    
    [ShareInstances addSubTitleLabel:@"每日平均的采购数量" withFrame:CGRectMake(MARGIN_WIDE, MARGIN_NARROW, answerView.width, TEXTSIZE_SUBTITLE) withSuperView:answerView];
    _needPerDayTextField = [[UITextField alloc] initWithFrame:CGRectMake(MARGIN_WIDE, TEXTSIZE_SUBTITLE + MARGIN_NARROW * 2, answerView.width - MARGIN_WIDE * 2, 32)];
    [_needPerDayTextField setBackgroundColor:[UIColor colorWithRed:0.2 green:0.9 blue:0.5 alpha:0.3]];
    _needPerDayTextField.keyboardType = UIKeyboardTypeNumberPad;
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [_needPerDayTextField setText:[numberFormatter stringFromNumber:_detailNeeds.needPerDay]];
    [answerView addSubview:_needPerDayTextField];
    
    [ShareInstances addSubTitleLabel:@"每月平均的采购数量" withFrame:CGRectMake(MARGIN_WIDE, _needPerDayTextField.bottom + MARGIN_NARROW, answerView.width, TEXTSIZE_SUBTITLE) withSuperView:answerView];
    _needPerMonthTextField = [[UITextField alloc] initWithFrame:CGRectMake(MARGIN_WIDE, _needPerDayTextField.bottom + MARGIN_NARROW*2 + TEXTSIZE_SUBTITLE, answerView.width - MARGIN_WIDE * 2, 32)];
    [_needPerMonthTextField setBackgroundColor:[UIColor colorWithRed:0.2 green:0.9 blue:0.5 alpha:0.3]];
    _needPerMonthTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_needPerMonthTextField setText:[numberFormatter stringFromNumber:_detailNeeds.needPerMonth]];
    [answerView addSubview:_needPerMonthTextField];
    
    [ShareInstances addSubTitleLabel:@"备注" withFrame:CGRectMake(MARGIN_WIDE, _needPerMonthTextField.bottom + MARGIN_NARROW, answerView.width, TEXTSIZE_SUBTITLE) withSuperView:answerView];
    _remarkTextField = [[UITextField alloc] initWithFrame:CGRectMake(MARGIN_WIDE, _needPerMonthTextField.bottom + MARGIN_NARROW*2 + TEXTSIZE_SUBTITLE, answerView.width - MARGIN_WIDE * 2, 32)];
    [_remarkTextField setBackgroundColor:[UIColor colorWithRed:0.2 green:0.9 blue:0.5 alpha:0.3]];
    [_remarkTextField setText:_detailNeeds.remark];
    [answerView addSubview:_remarkTextField];
    
    UIButton *okButton = [[UIButton alloc] initWithFrame:CGRectMake(0, _remarkTextField.bottom + 32, self.view.width, 44)];
    [okButton setBackgroundColor:[UIColor orangeColor]];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [answerView addSubview:okButton];
    
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap:)];
    [self.view addGestureRecognizer:gr];
}


-(void)okButtonClick{
    [_needPerDayTextField setBackgroundColor:[UIColor colorWithRed:0.2 green:0.9 blue:0.5 alpha:0.3]];
    [_needPerMonthTextField setBackgroundColor:[UIColor colorWithRed:0.2 green:0.9 blue:0.5 alpha:0.3]];
    
    if ([_needPerDayTextField.text isEqual: @""]) {
        [_needPerDayTextField setBackgroundColor:[UIColor yellowColor]];
        [_needPerDayTextField becomeFirstResponder];
    }else if([_needPerMonthTextField.text isEqual: @""]){
        [_needPerMonthTextField setBackgroundColor:[UIColor yellowColor]];
        [_needPerMonthTextField becomeFirstResponder];
    }else{
        _detailNeeds.needPerDay = [NSNumber numberWithInteger:[_needPerDayTextField.text integerValue]];
        _detailNeeds.needPerMonth = [NSNumber numberWithInteger:[_needPerMonthTextField.text integerValue]];
        _detailNeeds.remark = _remarkTextField.text;
        
        if ([_delegate respondsToSelector:@selector(detailNeedsChanged:)]) {
            [_delegate detailNeedsChanged:_rowIndex];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void) backgroundTap:(id)sender
{
    [_needPerDayTextField resignFirstResponder];
    [_needPerMonthTextField resignFirstResponder];
    [_remarkTextField resignFirstResponder];
}


@end
