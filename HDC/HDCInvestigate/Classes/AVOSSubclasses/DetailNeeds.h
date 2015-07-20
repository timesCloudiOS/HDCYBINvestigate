//
//  DetailNeeds.h
//  HDCInvestigate
//
//  Created by TsaoLipeng on 15/7/16.
//  Copyright (c) 2015年 TsaoLipeng. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface DetailNeeds : AVObject<AVSubclassing>

@property (nonatomic, strong) NSNumber *productNo;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSNumber *needPerDay;
@property (nonatomic, strong) NSNumber *needPerMonth;
@property (nonatomic, strong) NSString *remark;

@end
