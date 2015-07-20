//
//  ViewController.m
//  paopao
//
//  Created by TsaoLipeng on 15/1/28.
//  Copyright (c) 2015年 TsaoLipeng. All rights reserved.
//

#import "RootViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SidebarViewController.h"
#import "Defines.h"
#import "SignInDelegate.h"
#import "LoginViewController.h"
#import "UserHomeViewController.h"
#import "SettingHomeView.h"
#import "EAIntroView.h"
#import "SorryView.h"
#import "ShareInstances.h"
#import "UIView+XD.h"
#import "SVProgressHUD.h"
#import "HomeView.h"

@interface RootViewController () <SignInDelegate, SidebarViewDelegate, EAIntroDelegate> {
    UIView *navigationBar;
    UIScrollView *scrollView;
    UILabel *titleLabel;
    UIView *currentActiveView;
    NSInteger curUserCharacter;//当前用户角色，1为终端店，2为终极经销商
    NSArray *terminalStores;
    NSArray *finalDealers;
}

@property (nonatomic, strong) SidebarViewController* sidebarVC;
@property (nonatomic, strong) SettingHomeView *settingHomeView;
@property (nonatomic, strong) HomeView *homeView;
@property (nonatomic, strong) SorryView *sorryView;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation RootViewController

- (instancetype)init{
    self = [super init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:KNOTIFICATION_LOGINCHANGE object:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initNavigationBar];
    
    if (scrollView == nil) {
        CGRect scrollViewFrame = CGRectMake(0, NAVIGATION_BAR_HEIGHT + STATU_BAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - NAVIGATION_BAR_HEIGHT - STATU_BAR_HEIGHT);
        scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
        [self.view addSubview:scrollView];
    }
    
    if ([AVUser currentUser] == nil) {
        [self doSignIn];
    } else {
        [self loginStateChange:nil];
        //[self reloadSubViews];
    }
}

-(void)doSignIn {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.rootViewController = self;
    [self.navigationController pushViewController:loginVC animated:NO];
}

-(void)reloadSubViews{
    // 左侧边栏开始
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [panGesture delaysTouchesBegan];
    [self.view addGestureRecognizer:panGesture];
    self.sidebarVC = [[SidebarViewController alloc] init];
    [self.sidebarVC setBgRGB:0x000000];
    [self reloadMenu];
    
    self.sidebarVC.signInDelegate = self;
    self.sidebarVC.delegate = self;
    [self.view addSubview:self.sidebarVC.view];
    self.sidebarVC.view.frame  = self.view.bounds;
    // 左侧边栏结束
    
    //显示引导页面
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        //[self showIntroWithCrossDissolve];
    }
    
    [self.sidebarVC setSelectedIndex:0 withSection:0];
    [self menuItemSelectedOnIndex:0];//默认显示场馆页面
}

-(void)reloadMenu {
    NSArray *items = @[@{@"title":@"主页",@"imagenormal":@"home_normal.png",@"imagehighlight":@"home_highlight.png"},
              @{@"title":@"系统设置",@"imagenormal":@"setting_normal.png",@"imagehighlight":@"setting_highlight.png"}];

    [self.sidebarVC setItems:items];
}

-(void)loginStateChange:(NSNotification *)notification {
    AVUser *curUser = [AVUser currentUser];
    if (curUser == nil) {
        [self doSignIn];
    } else{
        [self reloadSubViews];
    }
}

-(void)comentityLoaded:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KNOTIFICATION_COMENTITYLOADED object:nil];
    [self reloadSubViews];
}

//-(void)viewDidAppear:(BOOL)animated{
//    //Calling this methods builds the intro and adds it to the screen. See below.
//    //[self buildIntro];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"壹通1";
    page1.desc = @"壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通";
    page1.bgImage = [UIImage imageNamed:@"1"];
    page1.titleImage = [UIImage imageNamed:@"original"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"壹通2";
    page2.desc = @"壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通";
    page2.bgImage = [UIImage imageNamed:@"2"];
    page2.titleImage = [UIImage imageNamed:@"supportcat"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"壹通3";
    page3.desc = @"壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通";
    page3.bgImage = [UIImage imageNamed:@"3"];
    page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"壹通4";
    page4.desc = @"壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通";
    page4.bgImage = [UIImage imageNamed:@"1"];
    page4.titleImage = [UIImage imageNamed:@"original"];
    
    EAIntroPage *page5 = [EAIntroPage page];
    page5.title = @"壹通5";
    page5.desc = @"壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通壹通";
    page5.bgImage = [UIImage imageNamed:@"2"];
    page5.titleImage = [UIImage imageNamed:@"supportcat"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4,page5]];
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}


- (void)panDetected:(UIPanGestureRecognizer*)recoginzer
{
    [self.sidebarVC panDetected:recoginzer];
}

- (void)initNavigationBar {
    if (navigationBar == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, STATU_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT);
        navigationBar = [[UIView alloc] initWithFrame:frame];
        [self.view addSubview:navigationBar];
        
        UIImageView *background = [[UIImageView alloc] initWithFrame:navigationBar.frame];
        [background setImage:[UIImage imageNamed:@"navigationBackground.png"]];
        [navigationBar addSubview:background];
        
        UIButton *showMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, STATU_BAR_HEIGHT, NAVIGATION_BUTTON_RESPONSE_WIDTH, NAVIGATION_BUTTON_HEIGHT)];
        [showMenuButton setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
        [showMenuButton setImageEdgeInsets:UIEdgeInsetsMake(0, NAVIGATION_LBUTTON_MARGIN_LEFT, 0, NAVIGATION_BUTTON_RESPONSE_WIDTH-NAVIGATION_LBUTTON_MARGIN_LEFT-NAVIGATION_BUTTON_WIDTH)];
        [showMenuButton addTarget:self action:@selector(doPopMainMenu:) forControlEvents:UIControlEventTouchUpInside];
        [showMenuButton setContentMode:UIViewContentModeLeft];
        [self->navigationBar addSubview:showMenuButton];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + (self.view.frame.size.width - NAVIGATION_TITLE_WIDTH) / 2, STATU_BAR_HEIGHT, NAVIGATION_TITLE_WIDTH, NAVIGATION_TITLE_HEIGHT)];
        [titleLabel setTextColor:[UIColor darkTextColor]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self->navigationBar addSubview:titleLabel];
    }
}

- (void)doPopMainMenu:(id)sender {
    [self.sidebarVC showHideSidebar];
}

#pragma mark CommonMainMenuDelegate
-(void)ShowView:(UIView *)newView withTitle:(NSString *)title withRemoveLastView:(UIView *)lastView {
    [scrollView addSubview:newView];
    [lastView removeFromSuperview];
    
    [self->titleLabel setText:title];
}

#pragma mark SidebarViewDelegate
- (void)menuItemSelectedOnIndex:(NSInteger)index {
    UIView *newView = nil;
    NSString *title = nil;
    CGRect frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    switch (index) {
        case 0:
            if (_homeView == nil) {
                _homeView = [[HomeView alloc] initWithFrame:frame withController:self];
            }
            newView = _homeView;
            title= @"主页";
            break;
        case 1:
            if (_settingHomeView == nil) {
                _settingHomeView = [[SettingHomeView alloc] initWithFrame:frame];
                _settingHomeView.homeViewController = self;
            }
            newView = _settingHomeView;
            title = @"系统设置";
            break;
            break;
        default:
            //if (_sorryView == nil) {
            _sorryView = [[SorryView alloc] initWithFrame:scrollView.bounds withController:self];
            //}
            newView = _sorryView;
            title = @"抱歉";
            break;
    }

    if (currentActiveView != newView) {
        [self ShowView:newView withTitle:title withRemoveLastView:currentActiveView];
        //                [currentActiveView removeFromSuperview];
        //                [rootController.view addSubview:newView];
        //                [rootController.view sendSubviewToBack:newView];
        currentActiveView = newView;
    }
}

#pragma mark SignInDelegate
- (void)onLogin {
    LoginViewController *controller = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)onUserHome {
    UserHomeViewController *userHomeVC = [[UserHomeViewController alloc] init];
    [self.navigationController pushViewController:userHomeVC animated:YES];
}

#pragma mark CityListDelegate
- (void)citySelected:(NSString *)cityName {
    [_rightButton setTitle:cityName forState:UIControlStateNormal];
}

@end
