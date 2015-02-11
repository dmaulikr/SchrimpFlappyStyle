//
//  MainScene.h
//  Flappy Bird
//
//  Created by JTK on 1/20/14.
//  Copyright 2014 org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MainScene : CCLayer {
    CCMenu *menu;
    CCMenuItemImage *m_mStart, *m_mScore, *m_mRate, *m_mMore;
    CCSprite *m_sBirdSprite;
    CCSprite *m_sLogoSprite;
    CCSprite *m_sGroundSprite[2];
}

- (void) updateRateButton;

@end
