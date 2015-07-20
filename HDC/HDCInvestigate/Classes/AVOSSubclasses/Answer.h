//
//  Gift.h
//  HDCInvestigate
//
//  Created by TsaoLipeng on 15/6/21.
//  Copyright (c) 2015年 TsaoLipeng. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface Answer : AVObject<AVSubclassing>

@property (nonatomic, strong) NSString *interviewerPhoneNo;
@property (nonatomic, strong) AVUser *interviewer;
@property (nonatomic, strong) NSString *restaurantName;
@property (nonatomic, strong) AVGeoPoint *location;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSNumber *tableCount;
@property (nonatomic, strong) NSNumber *restaurantType;
@property (nonatomic, strong) NSNumber *styleOfCooking;
@property (nonatomic, strong) NSNumber *answer4_1;
@property (nonatomic, strong) NSNumber *answer4_2;
@property (nonatomic, strong) NSNumber *answer4_3;
@property (nonatomic, strong) NSNumber *answer4_4;
@property (nonatomic, strong) NSNumber *answer4_5;
@property (nonatomic, strong) NSArray *favoriteProducts;
@property (nonatomic, strong) AVRelation *detailNeeds;

@end
