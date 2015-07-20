//
//  DetailNeedTableViewCell.h
//  HDCInvestigate
//
//  Created by TsaoLipeng on 15/7/18.
//  Copyright (c) 2015年 TsaoLipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDetailNeedsCellHeight 95

@class DetailNeeds;

@protocol DetailNeedTableViewCellDelegate

@required
-(void)needPerDayChanged:(NSInteger)productIndex;
-(void)needPerMonthChanged:(NSInteger)productIndex;
-(void)remarkChanged:(NSInteger)productIndex;

@end

@interface DetailNeedTableViewCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)setDetailNeeds:(DetailNeeds *)detailNeeds;

@end
