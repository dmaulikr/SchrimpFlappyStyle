//
//  MainScene.m
//  Flappy Bird
//
//  Created by JTK on 1/20/14.
//  Copyright 2014 org. All rights reserved.
//

#import "MainScene.h"
#import "Global.h"
#import "AppDelegate.h"

@implementation MainScene
- (id) init{
    if((self=[super init]))
    {
        self.touchEnabled = YES;
        [self createBackground];
        [self initVariable];
    }
    g_lMainLayer = self;
    return self;
}

- (void) initVariable{
    [m_sBirdSprite runAction: [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation: g_frmBird]]];
    [m_sBirdSprite runAction: [CCRepeatForever actionWithAction:[CCSequence actionOne:[CCMoveBy actionWithDuration:0.5f position:ccp(0, 20 * G_SCALEY / g_fScaleR)] two:[CCMoveBy actionWithDuration:0.5f position:ccp(0, -20 * G_SCALEY / g_fScaleR)]]]];
    [m_sLogoSprite runAction: [CCRepeatForever actionWithAction:[CCSequence actionOne:[CCMoveBy actionWithDuration:0.5f position:ccp(0, 20 * G_SCALEY / g_fScaleR)] two:[CCMoveBy actionWithDuration:0.5f position:ccp(0, -20 * G_SCALEY / g_fScaleR)]]]];
    
    [self schedule:@selector(Update:) interval:0.1f];
}

- (void) createBackground{
    newSprite(@"bg", G_SWIDTH / 2, G_SHEIGHT / 2, self, -1, RATIO_XY);
    m_sBirdSprite = newSprite(@"bird0", getX(250), getY(200), self, 1, RATIO_X);
    m_sLogoSprite = newSprite(@"flappy bird", getX(120), getY(200), self, 1, RATIO_X);
    
    m_sGroundSprite[0] = newSprite(@"ground", getX(154), getY(456), self, 0, RATIO_XY);
    m_sGroundSprite[1] = newSprite(@"ground", getX(460), getY(456), self, 0, RATIO_XY);
    
    m_mStart = newButton(@"start", getX(88), getY(368), self, @selector(onClickStart), false,RATIO_X);
    m_mScore = newButton(@"score", getX(207), getY(368), self, @selector(onClickScore), false,RATIO_X);
    m_mRate = newButton(@"rate", getX(207), getY(315), self, @selector(onClickRate), false,RATIO_X);
    m_mMore = newButton(@"more", getX(207), getY(421), self, @selector(onClickMore), false,RATIO_X);
    
    menu = [CCMenu menuWithItems: m_mStart, m_mScore, m_mMore, nil];
    menu.position = ccp(0, 0);
    [self addChild: menu z:10];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(![userDefaults boolForKey:@"Rated"])
       [menu addChild: m_mRate];

}

- (void) updateRateButton{
    [menu removeChild: m_mRate];
}

- (void) onClickStart{
    FX_BTN();
    [[CCDirector sharedDirector] replaceScene: [GameScene node]];
}

- (void) onClickScore{
    FX_BTN();
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    [delegate showLeaderboard];
}

- (void) onClickRate{
    FX_BTN();
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    [delegate showRate];

}

- (void) onClickMore{
    FX_BTN();
    [[Chartboost sharedChartboost] showMoreApps];
}

- (void) Update:(float) dt{
    m_sGroundSprite[0].position = ccp(m_sGroundSprite[0].position.x - 8 * G_SCALEX / g_fScaleR, m_sGroundSprite[0].position.y);
    m_sGroundSprite[1].position = ccp(m_sGroundSprite[1].position.x - 8 * G_SCALEX / g_fScaleR, m_sGroundSprite[1].position.y);
    
    if(m_sGroundSprite[0].position.x < -154 * G_SCALEX / g_fScaleR){
        m_sGroundSprite[0].position = ccp(getX(154), getY(456));
        m_sGroundSprite[1].position = ccp(getX(460), getY(456));
    }
}
@end
