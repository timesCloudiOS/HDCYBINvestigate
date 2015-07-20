//
//  DetailNeedTableViewCell.m
//  HDCInvestigate
//
//  Created by TsaoLipeng on 15/7/18.
//  Copyright (c) 2015年 TsaoLipeng. All rights reserved.
//

#import "DetailNeedTableViewCell.h"
#import "Defines.h"
#import "ShareInstances.h"
#import "UIView+XD.h"
#import "DetailNeeds.h"

@interface DetailNeedTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *needsPerDayLabel;
@property (nonatomic, strong) UILabel *needsPerMonthLabel;
@property (nonatomic, strong) UILabel *remarkLabel;

@end

@implementation DetailNeedTableViewCell{
    NSInteger curDetailNeeds;
    UIView *backView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setBackgroundColor:NORMAL_BACKGROUND_COLOR];
        
        CGSize size = [[UIScreen mainScreen] applicationFrame].size;
        backView = [[UIView alloc] initWithFrame:CGRectMake(MARGIN_WIDE, MARGIN_NARROW, size.width - MARGIN_WIDE * 2, 85)];
        [backView setBackgroundColor:[UIColor whiteColor]];
        backView.layer.cornerRadius = 5;
        [self addSubview:backView];
        
        _titleLabel = [ShareInstances addLabel:@"" withFrame:CGRectMake(MARGIN_WIDE, MARGIN_WIDE, backView.width - MARGIN_WIDE * 2, TEXTSIZE_TITLE) withSuperView:backView withTextColor:NORMAL_TEXT_COLOR withAlignment:NSTextAlignmentCenter withTextSize:TEXTSIZE_BIG];
        _needsPerDayLabel = [ShareInstances addLabel:@"日需求量（斤）" withFrame:CGRectMake(0, _titleLabel.bottom + MARGIN_WIDE, backView.width / 2, TEXTSIZE_TITLE) withSuperView:backView withTextColor:NORMAL_TEXT_COLOR withAlignment:NSTextAlignmentCenter withTextSize:TEXTSIZE_TITLE];
        _needsPerMonthLabel = [ShareInstances addLabel:@"月需求量（斤）" withFrame:CGRectMake(backView.width / 2, _titleLabel.bottom + MARGIN_WIDE, backView.width / 2, TEXTSIZE_TITLE) withSuperView:backView withTextColor:NORMAL_TEXT_COLOR withAlignment:NSTextAlignmentCenter withTextSize:TEXTSIZE_TITLE];
        _remarkLabel = [ShareInstances addLabel:@"备注" withFrame:CGRectMake(MARGIN_WIDE, _needsPerMonthLabel.bottom + MARGIN_WIDE, backView.width - MARGIN_WIDE * 2, TEXTSIZE_SUBTITLE) withSuperView:backView withTextColor:NORMAL_TEXT_COLOR withAlignment:NSTextAlignmentLeft withTextSize:TEXTSIZE_TITLE];
    }
    return self;
}

- (void)setDetailNeeds:(DetailNeeds *)detailNeeds{
    [_titleLabel setText:detailNeeds.productName];
    [_needsPerDayLabel setText:[NSString stringWithFormat:@"日需求量%ld斤", (long)[detailNeeds.needPerDay integerValue]]];
    [_needsPerMonthLabel setText:[NSString stringWithFormat:@"月需求量%ld斤", (long)[detailNeeds.needPerMonth integerValue]]];
    if (detailNeeds.remark != nil) {
        [_remarkLabel setText:[NSString stringWithFormat:@"备注：%@", detailNeeds.remark]];
    }
    
//    if ([detailNeeds.needPerDay integerValue] == 0 || [detailNeeds.needPerMonth integerValue] == 0){
//        [backView setBackgroundColor:[UIColor yellowColor]];
//    }
}

@end
