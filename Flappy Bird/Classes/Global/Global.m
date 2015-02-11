//
//  Global.m
//  Pot O' Gold
//
//  Created by YunXiong Shen on 9/1/13.
//  Copyright 2013 YunXiong Shen. All rights reserved.
//

#import "Global.h"

float g_fScaleR = 1.0f;
GameScene *g_lGameLayer;
MainScene *g_lMainLayer;
int g_iLives;

float getX(int x)
{
    float fx;
    
    fx = G_SWIDTH * x / G_ORG_WIDTH;
    return fx;
}

float getY(int y)
{
    float fy;
    fy = G_SHEIGHT - G_SHEIGHT * y / G_ORG_HEIGHT;
    return fy;
}

void loadGameInfo()
{
// 	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    g_nCompleteLevel = (NSInteger)[userDefaults integerForKey:@"Completed"];
    /*
     for (int i = 0; i < LEVEL_COUNT; i++) {
     NSString *str = [NSString stringWithFormat:@"Move%d", i];
     g_nMoves[i] = (NSInteger)[userDefaults integerForKey:str];
     }
     
     for (int i = 0; i < LEVEL_COUNT; i++) {
     NSString *str = [NSString stringWithFormat:@"Time%d", i];
     g_nTimes[i] = (NSInteger)[userDefaults integerForKey:str];
     }*/
}

void saveGameInfo()
{
//	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setInteger:g_nCompleteLevel forKey:@"Completed"];
    /*
     for (int i = 0; i < LEVEL_COUNT; i++) {
     NSString *str = [NSString stringWithFormat:@"Move%d", i];
     [userDefaults setInteger:(NSInteger)g_nMoves[i] forKey:str];
     }
     
     for (int i = 0; i < LEVEL_COUNT; i++) {
     NSString *str = [NSString stringWithFormat:@"Time%d", i];
     [userDefaults setInteger:(NSInteger)g_nTimes[i] forKey:str];
     }*/
}

CCSprite *newSprite(NSString *sName, float x, float y, id target, int zOrder, int nRatio)
{
    CCSprite *sprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png",sName]];
    setScale(sprite, nRatio);
    
    sprite.position = ccp(x, y);
    [target addChild:sprite z:zOrder];
    return sprite;
}

CCSprite *newSprite_u(NSString *sName, float x, float y, int zOrder, int nRatio)
{
    CCSprite *sprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png",sName]];
    setScale(sprite, nRatio);
    
    sprite.position = ccp(x, y);
    
    return sprite;
}


CCMenuItemImage *newButton(NSString* btnName, float x, float y, id target, SEL selector, BOOL isOneImage, int nRatio)
{
    CCMenuItemImage *item;
    
    if(isOneImage)
        item = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"%@.png", btnName] selectedImage:[NSString stringWithFormat:@"%@.png", btnName] target:target selector:selector];
    else
        item = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"btn_%@_normal.png", btnName] selectedImage:[NSString stringWithFormat:@"btn_%@_pressed.png", btnName] target:target selector:selector];
    setScale(item, nRatio);
    item.position = ccp(x, y);
    return item;
}

CCMenuItemImage *newButton_d(NSString* btnName, float x, float y, id target, SEL selector, int nRatio)
{
    CCMenuItemImage *item;
    
    item = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"%@.png", btnName] selectedImage:[NSString stringWithFormat:@"%@.png", btnName] disabledImage:[NSString stringWithFormat:@"%@.png", btnName] target:target selector:selector];
    setScale(item, nRatio);
    item.position = ccp(x, y);
    return item;
}

CCMenuItemImage *newButton_l(NSString* btnName, NSString *btnDisName, float x, float y, id target, SEL selector, int nRatio)
{
    CCMenuItemImage *item;
    
    item = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"btn_%@.png", btnName] selectedImage:[NSString stringWithFormat:@"btn_%@.png", btnName] disabledImage:[NSString stringWithFormat:@"btn_%@_n.png", btnDisName] target:target selector:selector];
    setScale(item, nRatio);
    item.position = ccp(x, y);
    return item;
}
CCMenuItemToggle *newToggleButton(NSString *btnName, float x, float y, id target, SEL selector, BOOL isOneImage, int nRatio)
{
    CCMenuItemToggle *item;
    CCMenuItemImage *itemOn, *itemOff;
    
    if(isOneImage)
    {
        if([btnName isEqualToString:@"music"]){
            if(g_bMusicMute){
                itemOff = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"btn_%@on.png", btnName] selectedImage:[NSString stringWithFormat:@"btn_%@on.png", btnName]];
                
                itemOn = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"btn_%@off.png", btnName] selectedImage:[NSString stringWithFormat:@"btn_%@off.png", btnName]];
            }
            else{
                itemOn = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"btn_%@on.png", btnName] selectedImage:[NSString stringWithFormat:@"btn_%@on.png", btnName]];
                
                itemOff = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"btn_%@off.png", btnName] selectedImage:[NSString stringWithFormat:@"btn_%@off.png", btnName]];
            }
        }
        if([btnName isEqualToString:@"sounds"]){
            if(g_bSoundMute){
                itemOff = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"btn_%@_normal.png", btnName] selectedImage:[NSString stringWithFormat:@"btn_%@_normal.png", btnName]];
                
                itemOn = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"btn_%@_pressed.png", btnName] selectedImage:[NSString stringWithFormat:@"btn_%@_pressed.png", btnName]];
            }
            else{
                itemOn = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"btn_%@_normal.png", btnName] selectedImage:[NSString stringWithFormat:@"btn_%@_normal.png", btnName]];
                
                itemOff = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"btn_%@_pressed.png", btnName] selectedImage:[NSString stringWithFormat:@"btn_%@_pressed.png", btnName]];
            }
        }
        
    }
    else
    {
        itemOn = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"%@_normal.png", btnName] selectedImage:[NSString stringWithFormat:@"%@_prest.png", btnName]];
        
        itemOff = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"%@_prest.png", btnName] selectedImage:[NSString stringWithFormat:@"%@_normal.png", btnName]];
    }

    item = [CCMenuItemToggle itemWithTarget:target selector:selector items:itemOn, itemOff, nil];
    setScale(item, nRatio);
    item.position = ccp(x, y);
    return item;
}

//void createAtlas(NSString *atlasName)
//{
//    NSString *strName = [NSString stringWithFormat:@"%@.atlas", atlasName];
//    NSString * strName1 = [NSString stringWithFormat:@"%@.png", atlasName];
//    CCSpriteFrameCache* cache = [[CCSpriteFrameCache alloc] init];
//    
//    Atlas* atlas = Atlas_readAtlasFile(strName);
//    AtlasRegion* region = atlas->regions;
//    while(region) {
//        CCSpriteFrame* sf = CCSpriteFrame::create(strName1.c_str(),
//                                                  CCRectMake(region->x, region->y, region->width, region->height),
//                                                  (bool)region->rotate,
//                                                  CCPointMake(region->offsetX, region->offsetY),
//                                                  CCSizeMake(region->originalWidth, region->originalHeight));
//        cache->addSpriteFrame(sf, region->name);
//        region = region->next;
//    }
//}
//CCAnimation *createAnimationWithAtlas(string animationName,int animationCnt,int startNumber,float delayTime)
//{
//    CCAnimation *animation = new CCAnimation;
//    animation->init();
//    animation->setDelayPerUnit(delayTime);
//    for(int i = startNumber; i < startNumber+animationCnt; i++)
//    {
//        stringstream s;
//        s<<animationName<<i;
//        animation->addSpriteFrame(CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(s.str().c_str()));
//    }
//    return animation;
//}

CCAnimation *newAnimation(NSString *sName, int nStartNum, int nFrameNum, BOOL isAscending, float fDelayPerUnit)
{
    CCAnimation *aniFrame = [[CCAnimation alloc] init];
    aniFrame.delayPerUnit = fDelayPerUnit;
    if(isAscending)
    {
        for(int i = nStartNum; i < nStartNum + nFrameNum; i++)
        {
            if(i < 10)
                [aniFrame addSpriteFrameWithFilename:[NSString stringWithFormat:@"%@000%d.png", sName, i]];
            else
            {
                [aniFrame addSpriteFrameWithFilename:[NSString stringWithFormat:@"%@00%d.png", sName, i]];
            }
        }
    }
    else
    {
        for(int i = nStartNum + nFrameNum - 1; i >= nStartNum; i--)
        {
            if(i < 10)
                [aniFrame addSpriteFrameWithFilename:[NSString stringWithFormat:@"%@000%d.png", sName, i]];
            else
            {
                [aniFrame addSpriteFrameWithFilename:[NSString stringWithFormat:@"%@00%d.png", sName, i]];
            }
        }
    }
    return aniFrame;
}

CCSpriteFrame *getSpriteFromAnimation(CCAnimation *ani, int index)
{
    CCAnimationFrame *frame = [ani.frames objectAtIndex:index];
    return frame.spriteFrame;
}

void setScale(CCNode *node, int nRatio)
{
    if(nRatio == RATIO_XY)
    {
        node.scaleX = G_SCALEX;
        node.scaleY = G_SCALEY;
    }
    else if(nRatio == RATIO_X)
        node.scale = G_SCALEX;
    else if(nRatio == RATIO_Y)
        node.scale = G_SCALEY;
}
