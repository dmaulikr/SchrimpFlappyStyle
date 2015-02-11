//
//  GameEndLayer.h
//  Flappy Bird
//
//  Created by JTK on 1/20/14.
//  Copyright 2014 org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface GameEndLayer : CCLayer<MFMailComposeViewControllerDelegate> {
    CCMenu *menu;
    CCMenuItemImage *m_mOk, *m_mContinue, *m_mTW, *m_mFB, *m_mML;
}
- (void) setScore:(int) score;
@end
