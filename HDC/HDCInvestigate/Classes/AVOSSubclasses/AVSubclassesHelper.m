//
//  AVSubclassesHelper.m
//  Bauma360
//
//  Created by TsaoLipeng on 14-10-17.
//  Copyright (c) 2014年 TsaoLipeng. All rights reserved.
//

#import "AVSubclassesHelper.h"
#import "Answer.h"
#import "DetailNeeds.h"

@implementation AVSubclassesHelper

+(void) RegisterSubclasses {
    [Answer registerSubclass];
    [DetailNeeds registerSubclass];
}

@end
