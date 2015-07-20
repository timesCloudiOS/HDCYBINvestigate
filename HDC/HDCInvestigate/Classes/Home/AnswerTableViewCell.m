//
//  AnswerTableViewCell.m
//  HDCInvestigate
//
//  Created by TsaoLipeng on 15/7/18.
//  Copyright (c) 2015年 TsaoLipeng. All rights reserved.
//

#import "AnswerTableViewCell.h"
#import "Defines.h"
#import "UIView+XD.h"
#import "ShareInstances.h"
#import "Answer.h"

@interface AnswerTableViewCell()

@property (nonatomic, strong) UILabel *restaurantNameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation AnswerTableViewCell{
    
}

- (void)setAnswer:(Answer *)answer{
    _restaurantNameLabel.text = answer.restaurantName;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    _dateLabel.text = [formatter stringFromDate:answer.date];
    _addressLabel.text = answer.address;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        CGSize size = [[UIScreen mainScreen] applicationFrame].size;
        _restaurantNameLabel = [ShareInstances addLabel:@"" withFrame:CGRectMake(MARGIN_WIDE, MARGIN_WIDE, size.width - MARGIN_WIDE * 2 - 44, TEXTSIZE_BIG) withSuperView:self withTextColor:NORMAL_TEXT_COLOR withAlignment:NSTextAlignmentLeft withTextSize:TEXTSIZE_BIG];
        _dateLabel = [ShareInstances addLabel:@"" withFrame:CGRectMake(_restaurantNameLabel.x, _restaurantNameLabel.bottom + MARGIN_WIDE, _restaurantNameLabel.width, TEXTSIZE_TITLE) withSuperView:self withTextColor:LIGHT_TEXT_COLOR withAlignment:NSTextAlignmentLeft withTextSize:TEXTSIZE_TITLE];
        _addressLabel = [ShareInstances addLabel:@"" withFrame:CGRectMake(_dateLabel.x, _dateLabel.bottom + MARGIN_WIDE, _dateLabel.width, TEXTSIZE_TITLE) withSuperView:self withTextColor:LIGHT_TEXT_COLOR withAlignment:NSTextAlignmentLeft withTextSize:TEXTSIZE_TITLE];
        
        [ShareInstances addGoIndicateOnView:self withImageFrame:CGRectMake(size.width - 44, (kAnswerCellHeight - 44) / 2, 44, 44)];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
