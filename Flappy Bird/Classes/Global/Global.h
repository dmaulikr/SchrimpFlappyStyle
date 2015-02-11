//
//  Global.h
//  Pot O' Gold
//
//  Created by YunXiong Shen on 9/1/13.
//  Copyright 2013 YunXiong Shen. All rights reserved.
//

#ifndef _GLOBAL_H_
#define _GLOBAL_H_
#import "cocos2d.h"
#import <UIKit/UIDevice.h>
#import "GameConfig.h"
#import "SimpleAudioEngine.h"
#import "GameScene.h"
#import "MainScene.h"
#import "SimpleAudioEngine.h"

#define G_ORG_WIDTH 288
#define G_ORG_HEIGHT 512
#ifdef UI_USER_INTERFACE_IDIOM//()
#define IS_IPAD() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD() (NO)
#endif

#define G_SWIDTH    (IS_IPAD() ? 768: [[CCDirector sharedDirector] winSize].width)  //Screen width
#define G_SHEIGHT   (IS_IPAD() ? 1024: [[CCDirector sharedDirector] winSize].height)   //Screen height

#define G_SCALEX    (G_SWIDTH * g_fScaleR / G_ORG_WIDTH)
#define G_SCALEY    (G_SHEIGHT * g_fScaleR / G_ORG_HEIGHT)

//extern MenuScene *g_layerMenu;
//extern GameScene *g_layerGame;
//http://we.tl/Heys8cnCrP

typedef enum
{
    RATIO_XY = 0,
    RATIO_X,
    RATIO_Y,
}Ratio;

typedef enum{
    NORMALTOOLS = 588,
} TOOLSTATE;

extern float g_fScaleR; //For some retina things such text
extern GameScene *g_lGameLayer;
extern MainScene *g_lMainLayer;
extern int g_iLives;
float getX(int x);
float getY(int y);

void loadGameInfo();
void updateGameInfo();

CCSprite *newSprite(NSString *sName, float x, float y, id target, int zOrder, int nRatio);
CCSprite *newSprite_u(NSString *sName, float x, float y, int zOrder, int nRatio);
CCMenuItemImage *newButton(NSString* btnName, float x, float y, id target, SEL selector, BOOL isOneImage, int nRatio);
CCMenuItemImage *newButton_d(NSString* btnName, float x, float y, id target, SEL selector, int nRatio);
CCMenuItemImage *newButton_l(NSString* btnName, NSString *btnDisName, float x, float y, id target, SEL selector, int nRatio);
CCMenuItemToggle *newToggleButton(NSString *btnName, float x, float y, id target, SEL selector, BOOL isOneImage, int nRatio);
CCAnimation *newAnimation(NSString *name, int nStartNum, int nFrameNum, BOOL isAscending, float fDelayPerUnit);
CCSpriteFrame *getSpriteFromAnimation(CCAnimation *ani, int index);
void setScale(CCNode *node, int nRatio);
CCLabelTTF *addTextToButton(CGPoint pos, CCNode *scene, NSString *str, int fontSize, int z);
#endif