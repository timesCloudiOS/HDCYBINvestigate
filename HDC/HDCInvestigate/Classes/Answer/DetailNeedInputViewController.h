//
//  DetailNeedInputViewController.h
//  HDCInvestigate
//
//  Created by TsaoLipeng on 15/7/18.
//  Copyright (c) 2015年 TsaoLipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailNeedInputViewControllerDelegate <NSObject>

@required
-(void)detailNeedsChanged:(NSInteger)rowIndex;

@end

@class DetailNeeds;

@interface DetailNeedInputViewController : UIViewController

@property (nonatomic, strong) DetailNeeds *detailNeeds;
@property (nonatomic) NSInteger rowIndex;

@property (nonatomic, weak) id<DetailNeedInputViewControllerDelegate> delegate;

@end
