//
//  AnswerTableViewCell.h
//  HDCInvestigate
//
//  Created by TsaoLipeng on 15/7/18.
//  Copyright (c) 2015年 TsaoLipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAnswerCellHeight 85

@class Answer;

@interface AnswerTableViewCell : UITableViewCell

- (void)setAnswer:(Answer *)answer;

@end
