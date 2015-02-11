//
//  GameConfig.h
//  Pot O' Gold
//
//  Created by YunXiong Shen on 9/1/13.
//  Copyright 2013 YunXiong Shen. All rights reserved.
//

#ifndef _GAME_CONFIG_H
#define _GAME_CONFIG_H
#import "cocos2d.h"
#import "Constants.h"

#define TEXT_TAG    1
#define FX_BTN() [[SimpleAudioEngine sharedEngine] playEffect:@"sfx_swooshing.mp3"];

typedef enum
{
    D_EASY = 0,
    D_MEDIUM,
    D_HARD,
}DIFFICULTY;

extern BOOL g_bMusicMute;
extern BOOL g_bSoundMute;
extern BOOL g_bIsTimeMode;
extern int g_nDifficulty;

extern int g_nCurrentLevel;
extern int g_nCompleteLevel;
extern int g_nTotalScore;

extern CCAnimation *g_frmBird;
extern CCAnimation *g_frmObstacle;

#endif