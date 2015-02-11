//
//  AppDelegate.h
//  Flappy Bird
//
//  Created by JTK on 1/20/14.
//  Copyright org 2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "Global.h"
#import "GameCenterManager.h"
#import <GameKit/GameKit.h>
#import <iAd/iAd.h>

// Added only for iOS 6 support
@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end

@class MyiAd;

@interface AppController : NSObject <UIApplicationDelegate, ChartboostDelegate, RevMobAdsDelegate, GKAchievementViewControllerDelegate, GameCenterManagerDelegate, GKLeaderboardViewControllerDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
    RevMobBannerView *revBannerView;
    MyiAd *mIAd;
    ADBannerView *adView;
    GameCenterManager* gameCenterManager_;
	NSString* currentLeaderBoard_;
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) MyNavigationController *navController;
@property (readonly) CCDirectorIOS *director;
@property (nonatomic, retain) GameCenterManager *gameCenterManager;
@property (nonatomic, retain) NSString* currentLeaderBoard;

-(void) showAdBanner;
-(void) hideADS;
- (void) showBanner;
- (void) hideBanner;
- (void)showRate;
#pragma mark Game Center

- (void) submitScore:(int) uploadScore;
- (void) showLeaderboard;
- (void) showAchievements;
- (BOOL) initGameCenter;

@end
