//
//  GameScene.m
//  PentaminoGame
//
//  Created by JTK on 12/16/13.
//  Copyright 2013 org. All rights reserved.
//

#import "GameScene.h"
#import "Global.h"
#import <Social/Social.h>
#import "MainScene.h"
#import "GameEndLayer.h"
#import "AppDelegate.h"

@implementation GameScene
- (id) init{
    if((self=[super init]))
    {
        self.touchEnabled = YES;
        [self createBackground];
        [self initVariable];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        int runCnt = [userDefaults integerForKey:@"ADS"];
        if(runCnt % 2)
            [[Chartboost sharedChartboost] showInterstitial];        
    }
    g_lGameLayer = self;
    return self;
}

- (void) initVariable{
    [m_sBirdSprite runAction: [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation: g_frmBird]]];
    m_aUpDownAction = [m_sBirdSprite runAction: [CCRepeatForever actionWithAction:[CCSequence actionOne:[CCMoveBy actionWithDuration:0.5f position:ccp(0, 20 * G_SCALEY / g_fScaleR)] two:[CCMoveBy actionWithDuration:0.5f position:ccp(0, -20 * G_SCALEY / g_fScaleR)]]]];
    
    [m_mResume setIsEnabled:NO];
    m_mResume.visible = NO;
    [m_mMenu setIsEnabled:NO];
    m_mMenu.visible = NO;
    g_iLives = LIVES_COUNT;
    if(!ENABLE_LIVES) g_iLives = 0;
    [m_lbtLives setString: [NSString stringWithFormat: @"Lives: %d", g_iLives]];
    
    m_sObstacle[0].anchorPoint = ccp(0.5, 0);
    m_sObstacle[1].anchorPoint = ccp(0.5, 1);
    m_sObstacle[2].anchorPoint = ccp(0.5, 0);
    m_sObstacle[3].anchorPoint = ccp(0.5, 1);
    m_sObstacle[4].anchorPoint = ccp(0.5, 0);
    m_sObstacle[5].anchorPoint = ccp(0.5, 1);
    
    m_iObstacleCnt = 0;
    
    int tmp = arc4random() % 256 + 180;
    m_sObstacle[0].position = ccp(m_sObstacle[0].position.x, (tmp + (120 - m_iObstacleCnt * 2)) * G_SCALEY / g_fScaleR);
    m_sObstacle[1].position = ccp(m_sObstacle[1].position.x, (tmp - (120 - m_iObstacleCnt * 2)) * G_SCALEY / g_fScaleR);
    m_gCenPos[0] = ccp(m_sObstacle[0].position.x, tmp * G_SCALEY / g_fScaleR);
    m_gCenPos[1] = ccp(m_sObstacle[1].position.x, tmp * G_SCALEY / g_fScaleR);
    m_iObstacleCnt++;
    tmp = arc4random() % 256 + 180;
    m_sObstacle[2].position = ccp(m_sObstacle[2].position.x, (tmp + (120 - m_iObstacleCnt * 2)) * G_SCALEY / g_fScaleR);
    m_sObstacle[3].position = ccp(m_sObstacle[3].position.x, (tmp - (120 - m_iObstacleCnt * 2)) * G_SCALEY / g_fScaleR);
    m_gCenPos[2] = ccp(m_sObstacle[2].position.x, tmp * G_SCALEY / g_fScaleR);
    m_gCenPos[3] = ccp(m_sObstacle[3].position.x, tmp * G_SCALEY / g_fScaleR);
    m_iObstacleCnt++;
    tmp = arc4random() % 256 + 180;
    m_sObstacle[4].position = ccp(m_sObstacle[4].position.x, (tmp + (120 - m_iObstacleCnt * 2)) * G_SCALEY / g_fScaleR);
    m_sObstacle[5].position = ccp(m_sObstacle[5].position.x, (tmp - (120 - m_iObstacleCnt * 2)) * G_SCALEY / g_fScaleR);
    m_gCenPos[4] = ccp(m_sObstacle[4].position.x, tmp * G_SCALEY / g_fScaleR);
    m_gCenPos[5] = ccp(m_sObstacle[5].position.x, tmp * G_SCALEY / g_fScaleR);
    
    m_iPastTime = 0;
    m_fSpeedX = 8 * G_SCALEX / g_fScaleR;
    [self schedule:@selector(Update:) interval:0.05f];
    
    m_iOvercomedObstacle = -1;
    m_iScore = 0;
    m_fTime = 0;
    m_iRecurrenceTime = 0;
}

- (void) createBackground{
    newSprite(@"bg", G_SWIDTH / 2, G_SHEIGHT / 2, self, -1, RATIO_XY);

    m_sBirdSprite = newSprite(@"bird0", getX(90), getY(230), self, 1, RATIO_X);
    
    m_sTapSprite = newSprite(@"start_tap", getX(170), getY(260), self, 1, RATIO_X);
    m_sReadySprite = newSprite(@"get ready", G_SWIDTH / 2, getY(130), self, 1, RATIO_X);
    
    int tmp = arc4random() % OBSTACLE_COUNT;
    m_sObstacle[0] = newSprite([NSString stringWithFormat:@"obstacle_up%d", tmp], getX(400), getY(230), self, -1, RATIO_XY);
    m_sObstacle[1] = newSprite([NSString stringWithFormat:@"obstacle_down%d", tmp], getX(400), getY(230), self, -1, RATIO_XY);
    tmp = arc4random() % OBSTACLE_COUNT;
    m_sObstacle[2] = newSprite([NSString stringWithFormat:@"obstacle_up%d", tmp], getX(600), getY(230), self, -1, RATIO_XY);
    m_sObstacle[3] = newSprite([NSString stringWithFormat:@"obstacle_down%d", tmp], getX(600), getY(230), self, -1, RATIO_XY);
    tmp = arc4random() % OBSTACLE_COUNT;
    m_sObstacle[4] = newSprite([NSString stringWithFormat:@"obstacle_up%d", tmp], getX(800), getY(230), self, -1, RATIO_XY);
    m_sObstacle[5] = newSprite([NSString stringWithFormat:@"obstacle_down%d", tmp], getX(800), getY(230), self, -1, RATIO_XY);
    
    m_sGroundSprite[0] = newSprite(@"ground", getX(154), getY(456), self, 0, RATIO_XY);
    m_sGroundSprite[1] = newSprite(@"ground", getX(460), getY(456), self, 0, RATIO_XY);
    
    m_lColorLayer = [[CCLayerColor alloc] initWithColor: ccc4(0, 0, 0, 150)];
    [self addChild:m_lColorLayer z:5];
    m_lColorLayer.visible = NO;
    
    m_mPause = newButton(@"pause", getX(30), getY(30), self, @selector(onClickPause), false,RATIO_X);
    m_mResume = newButton(@"resume", getX(30), getY(30), self, @selector(onClickResume), false,RATIO_X);
    m_mMenu = newButton(@"menu", G_SWIDTH / 2, G_SHEIGHT / 2, self, @selector(onClickMenu), false,RATIO_X);
    m_mMusic = newToggleButton(@"music", getX(70), getY(30), self, @selector(onClickMusic), YES, RATIO_X);
    
    menu = [CCMenu menuWithItems: m_mPause, m_mResume, m_mMenu, m_mMusic, nil];
    menu.position = ccp(0, 0);
    [self addChild: menu z:10];
    
    m_lbtScore = [self newLabel:@"Time: 0" :24 :ccc3(255, 255, 255) :ccp(G_SWIDTH / 2, getY(30))];
    m_lbtScore.anchorPoint = ccp(0.5, 0.5);
    
    
    m_lbtLives = [self newLabel:@"Lives: 3" :18 :ccc3(255, 255, 255) :ccp(getX(280), getY(30))];
    m_lbtLives.anchorPoint = ccp(1, 0.5);
    
    if(!ENABLE_LIVES) m_lbtLives.opacity = 0;
    
}

- (CCLabelTTF*) newLabel:(NSString*) str :(int)size :(ccColor3B)color :(CGPoint) pos{
    CCLabelTTF* label = [[CCLabelTTF alloc] initWithString: str fontName:@"AmericanTypewriter" fontSize: size];
    label.scale = G_SCALEX / g_fScaleR;
//    label.scaleY = G_SCALEY / g_fScaleR;
    [self addChild: label];
    [label setColor:color];
    label.anchorPoint = ccp(0, 0.5);
    label.position = pos;
    return label;
}

#pragma mark -ClickActions

- (void) onClickMusic{
    g_bMusicMute = !g_bMusicMute;
    if(g_bMusicMute){
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0];
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:0];
    }
    else{
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:1];
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:1];
    }
}

- (void) onClickPause{
    FX_BTN();
    [m_mPause setIsEnabled:NO];
    m_mPause.visible = NO;

    [m_mResume setIsEnabled:YES];
    m_mResume.visible = YES;

    self.touchEnabled = NO;
    [m_mMenu setIsEnabled:YES];
    m_mMenu.visible = YES;
    
    m_lColorLayer.visible = YES;

    [self unschedule: @selector(Update:)];
    
    [m_sBirdSprite pauseSchedulerAndActions];
}

- (void) onClickMenu{
    FX_BTN();
    [[CCDirector sharedDirector] replaceScene: [MainScene node]];
}

- (void) onClickResume{
    FX_BTN();
    [m_mPause setIsEnabled:YES];
    m_mPause.visible = YES;
    
    [m_mResume setIsEnabled:NO];
    m_mResume.visible = NO;
    
    self.touchEnabled = YES;
    [m_mMenu setIsEnabled:NO];
    m_mMenu.visible = NO;
    
    m_lColorLayer.visible = NO;
    
    [self schedule:@selector(Update:) interval:0.05];
    
    [m_sBirdSprite resumeSchedulerAndActions];
}
#pragma mark -GameEngine

- (void) gameEnd{

    [[SimpleAudioEngine sharedEngine] playEffect: @"sfx_die.mp3"];
    AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
    [delegate hideBanner];
    [delegate hideADS];

    m_lColorLayer.visible = YES;
    [m_lColorLayer setZOrder:99];
    menu.touchEnabled = NO;
    self.touchEnabled = NO;
    
    [self unschedule: @selector(Update:)];
    
    [m_sBirdSprite pauseSchedulerAndActions];
    
    m_lGameEndLayer = [GameEndLayer node];
    [m_lGameEndLayer setScore: (int)m_fTime];
    [self addChild: m_lGameEndLayer z:100];
}

- (void) recurrenceGame{
    [self removeChild: m_lGameEndLayer];
    [m_lbtLives setString: [NSString stringWithFormat: @"Lives: %d", g_iLives]];
    [m_mPause setIsEnabled:YES];
    m_mPause.visible = YES;
    
    [m_mResume setIsEnabled:NO];
    m_mResume.visible = NO;
    self.touchEnabled = YES;
    [m_mMenu setIsEnabled:NO];
    m_mMenu.visible = NO;
    
    m_lColorLayer.visible = NO;
    
    m_fSpeedY = 7 * G_SCALEX / g_fScaleR;
    m_iPastTime = 0;
    m_fSpeedX = 8 * G_SCALEX / g_fScaleR;
    m_iRecurrenceTime = 120;
    
    [m_sBirdSprite runAction:[CCBlink actionWithDuration:1 blinks:5]];
    [m_sBirdSprite runAction:[CCFadeTo actionWithDuration:1 opacity:255]];
    
    [self schedule:@selector(Update:) interval:0.05];
    
    [m_sBirdSprite resumeSchedulerAndActions];
    m_sBirdSprite.position = ccp(m_sBirdSprite.position.x, getY(230));
}

- (void) Update:(float) dt{
    if(m_aUpDownAction != NULL) return;
    m_fTime += 0.05;
    m_fSpeedY -= 0.7 * m_iPastTime;
    m_iPastTime++;
    m_sBirdSprite.position = ccpAdd(m_sBirdSprite.position, ccp(0, m_fSpeedY));
    m_sBirdSprite.rotation = -CC_RADIANS_TO_DEGREES(atan2f(m_fSpeedY, m_fSpeedX));
    for (int i = 0; i < 6; i ++) {
        m_sObstacle[i].position = ccp(m_sObstacle[i].position.x - m_fSpeedX, m_sObstacle[i].position.y);
        if(m_sObstacle[i].position.x < -30 * G_SCALEX / g_fScaleR){
            int tmp = arc4random() % 256 + 180;
//            if(m_iObstacleCnt < 30) m_iObstacleCnt++;
            m_iObstacleCnt++;
            m_sObstacle[i].position = ccp(m_sObstacle[i].position.x + 600.0 * G_SCALEX / g_fScaleR, (tmp + (120 - m_iObstacleCnt)) * G_SCALEY / g_fScaleR);
            m_sObstacle[i + 1].position = ccp(m_sObstacle[i].position.x, (tmp - (120 - m_iObstacleCnt)) * G_SCALEY / g_fScaleR);
            m_gCenPos[i] = ccp(m_sObstacle[i].position.x + 600.0 * G_SCALEX / g_fScaleR, tmp * G_SCALEY / g_fScaleR);
            m_gCenPos[i + 1] = ccp(m_sObstacle[i + 1].position.x + 600.0 * G_SCALEX / g_fScaleR, tmp * G_SCALEY / g_fScaleR);
            tmp = arc4random() % OBSTACLE_COUNT;
            [m_sObstacle[i] setDisplayFrame: getSpriteFromAnimation(g_frmObstacle, tmp * 2)];
            [m_sObstacle[i + 1] setDisplayFrame: getSpriteFromAnimation(g_frmObstacle, tmp * 2 + 1)];
            i++;
        }
        if(m_sObstacle[(m_iScore * 2) % 6].position.x < m_sBirdSprite.position.x){
            m_iScore++;
            
        }
        if(m_iRecurrenceTime > 0){
            m_iRecurrenceTime--;
        }
        else{
            if(CGRectIntersectsRect([m_sObstacle[i] boundingBox], m_sBirdSprite.boundingBox) || CGRectIntersectsRect([m_sObstacle[i] boundingBox], m_sBirdSprite.boundingBox)){
                g_iLives--;
                
                if(g_iLives < 1){
                    self.touchEnabled = NO;
                    if(m_fSpeedX != 0) [[SimpleAudioEngine sharedEngine] playEffect: @"sfx_hit.mp3"];
                    m_fSpeedX = 0;
                }
                else{
                    [[SimpleAudioEngine sharedEngine] playEffect: @"sfx_hit.mp3"];
                    m_iRecurrenceTime = 120;
                    [m_sBirdSprite runAction:[CCBlink actionWithDuration:1 blinks:5]];
                    [m_sBirdSprite runAction:[CCFadeTo actionWithDuration:1 opacity:255]];
                    [m_lbtLives setString: [NSString stringWithFormat: @"Lives: %d", g_iLives]];
                }
            }
            
        }
    }
    [m_lbtScore setString: [NSString stringWithFormat: @"Time: %d", (int)m_fTime]];
    m_sGroundSprite[0].position = ccp(m_sGroundSprite[0].position.x - m_fSpeedX, m_sGroundSprite[0].position.y);
    m_sGroundSprite[1].position = ccp(m_sGroundSprite[1].position.x - m_fSpeedX, m_sGroundSprite[1].position.y);
    
    if(m_sGroundSprite[0].position.x < -154 * G_SCALEX / g_fScaleR){
        m_sGroundSprite[0].position = ccp(getX(154), getY(456));
        m_sGroundSprite[1].position = ccp(getX(460), getY(456));
    }
    
    if(m_sBirdSprite.position.y < 140 * G_SCALEY / g_fScaleR){
        [self gameEnd];
//        [self onClickPause];
    }
}

#pragma mark -TouchDelegate

- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];

    if(m_aUpDownAction != NULL){

        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        int runCnt = [userDefaults integerForKey:@"ADS"];
        [userDefaults setInteger: runCnt + 1 forKey:@"ADS"];
        if(runCnt % 2){
            AppController *delegate = (AppController *)[[UIApplication sharedApplication] delegate];
            if((runCnt / 2) % 2) [delegate showAdBanner];
            else [delegate showBanner];
        }

        [m_sBirdSprite stopAction: m_aUpDownAction];
        m_aUpDownAction = NULL;
        [m_sTapSprite runAction: [CCFadeTo actionWithDuration:0.5 opacity:0]];
        [m_sReadySprite runAction: [CCFadeTo actionWithDuration:0.5 opacity:0]];
    }
    [[SimpleAudioEngine sharedEngine] playEffect: @"sfx_wing.mp3"];
    m_fSpeedY = 7 * G_SCALEX / g_fScaleR;
    m_iPastTime = 0;
}


- (void) dealloc{
    [super dealloc];
    g_lGameLayer = NULL;
}
@end
