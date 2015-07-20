//
//  Gift.m
//  HDCInvestigate
//
//  Created by TsaoLipeng on 15/6/21.
//  Copyright (c) 2015年 TsaoLipeng. All rights reserved.
//

#import "Answer.h"

@implementation Answer
@dynamic interviewerPhoneNo, restaurantName, interviewer, location, date, tableCount, restaurantType, styleOfCooking, answer4_1, answer4_2, answer4_3, answer4_4, answer4_5, favoriteProducts, detailNeeds, address;

+(NSString *)parseClassName{
    return @"Answer";
}

@end
