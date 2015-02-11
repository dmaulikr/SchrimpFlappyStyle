//
//  GameScene.h
//  PentaminoGame
//
//  Created by JTK on 12/16/13.
//  Copyright 2013 org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "GameEndLayer.h"

@interface GameScene : CCLayer<MFMailComposeViewControllerDelegate>{
    CCMenu *menu;
    CCMenuItemImage *m_mPause, *m_mResume, *m_mMenu;
    CCMenuItemToggle *m_mMusic;
    CCLayerColor *m_lColorLayer;
    CCSprite *m_sBirdSprite;
    CCSprite *m_sObstacle[10];
    CCSprite *m_sGroundSprite[2];
    CCSprite *m_sTapSprite;
    CCSprite *m_sReadySprite;
    CCAction *m_aUpDownAction;
    CGPoint m_gCenPos[10];
    CCLabelTTF *m_lbtScore, *m_lbtLives;
    GameEndLayer *m_lGameEndLayer;
    int m_iScore;
    int m_iOvercomedObstacle;
    float m_fSpeedY;
    float m_fSpeedX;
    int m_iPastTime;
    int m_iRecurrenceTime;
    int m_iObstacleCnt;
    float m_fTime;
}

- (void) recurrenceGame;
- (void) dealloc;

@end
