//
//  GameEndLayer.m
//  Flappy Bird
//
//  Created by JTK on 1/20/14.
//  Copyright 2014 org. All rights reserved.
//

#import "GameEndLayer.h"
#import "Global.h"
#import "MainScene.h"
#import <Social/Social.h>
#import "MKStoreManager.h"

@implementation GameEndLayer

- (id) init{
    if((self=[super init]))
    {
        self.touchEnabled = YES;
        [self createBackground];
        [self initVariable];
    }
    return self;
}

- (void) initVariable{

}

- (void) setScore:(int) score{
    int maxScore = 0;
    maxScore = [[NSUserDefaults standardUserDefaults] integerForKey: @"SCORE"];
    if(maxScore < score){
        newSprite(@"new", getX(130), getY(265), self, 1, RATIO_XY);
        maxScore = score;
    }
    [[NSUserDefaults standardUserDefaults] setInteger:maxScore forKey:@"SCORE"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    [self newLabel: [NSString stringWithFormat: @"%d", score] :16 :ccc3(255, 255, 255) : ccp(getX(125), getY(255))];
    [self newLabel: [NSString stringWithFormat: @"%d", maxScore] :16 :ccc3(255, 255, 255) : ccp(getX(210), getY(255))];
}

- (void) createBackground{
    newSprite(@"end_bg", G_SWIDTH / 2, G_SHEIGHT / 2, self, -1, RATIO_XY);
    
    newSprite(@"game over", G_SWIDTH / 2, getY(130), self, 1, RATIO_X);
    
    m_mOk = newButton(@"ok", getX(70), getY(350), self, @selector(onClickOk), false,RATIO_X);
    m_mContinue = newButton(@"continue", getX(220), getY(350), self, @selector(onClickContinue), false,RATIO_X);
    m_mFB = newButton(@"fb", getX(147), getY(430), self, @selector(onClickFB), false,RATIO_X);
    m_mTW = newButton(@"tw", getX(220), getY(430), self, @selector(onClickTW), false,RATIO_X);
    m_mML = newButton(@"email", getX(72), getY(430), self, @selector(onClickMail), false,RATIO_X);
    menu = [CCMenu menuWithItems: m_mOk, m_mFB, m_mML, m_mTW, m_mContinue, nil];
    menu.position = ccp(0, 0);
    [self addChild: menu z:10];
    
    if(g_iLives < 0) g_iLives = 0;
}

- (CCLabelTTF*) newLabel:(NSString*) str :(int)size :(ccColor3B)color :(CGPoint) pos{
    CCLabelTTF* label = [[CCLabelTTF alloc] initWithString: str fontName:@"AmericanTypewriter" fontSize: size];
    label.scale = G_SCALEX / g_fScaleR;
    [self addChild: label];
    [label setColor:color];
    label.anchorPoint = ccp(0, 0.5);
    label.position = pos;
    return label;
}

- (void) onClickContinue{
    [[SimpleAudioEngine sharedEngine] playEffect: @"general_button3.mp3"];
    if(DEBUG_MODE){
        g_iLives += 3;
        [g_lGameLayer recurrenceGame];
        [self removeFromParentAndCleanup: YES];
    }
    else{
        [[MKStoreManager sharedManager] buyFeatureLives];
        [self showPurchaseAlert: IAP_Q_LIVES :0];
    }
}

- (void) onClickFB{
    [[SimpleAudioEngine sharedEngine] playEffect: @"general_button3.mp3"];
    [self shareFB:GAME_FBTEXT];
}

- (void) onClickTW{
    [[SimpleAudioEngine sharedEngine] playEffect: @"general_button3.mp3"];
    [self shareTwitter:GAME_TWITTERTEXT];
}


- (void) onClickMail{
    [[SimpleAudioEngine sharedEngine] playEffect: @"general_button3.mp3"];
    [self sendMail:EMAIL_SUBJECT :EMAIL_BODY];
}

#pragma mark Share Feature

-(void)shareFB:(NSString *)text
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:text];
        //[controller addURL:[NSURL URLWithString:@"http://www.appcoda.com"]];
        
        [[CCDirector sharedDirector]presentViewController:controller animated:YES completion:nil];
    }
}

-(void)shareTwitter:(NSString *)text
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [controller setInitialText:text];
        //[controller addURL:[NSURL URLWithString:@"http://www.appcoda.com"]];
        
        [[CCDirector sharedDirector]presentViewController:controller animated:YES completion:nil];
    }
}

- (void) sendMail:(NSString *)subject :(NSString *)body
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass != nil) {
        //Display Email Composer
        
        MFMailComposeViewController *pickerMail = [[MFMailComposeViewController alloc] init];
        pickerMail.mailComposeDelegate = self;
        
        [pickerMail setSubject:subject];
        
        // Fill out the email body text
        NSString *emailBody = body;
        [pickerMail setMessageBody:emailBody isHTML:NO];
        [[CCDirector sharedDirector] presentModalViewController:pickerMail animated:YES];
        [pickerMail release];
    }else{
        
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [[CCDirector sharedDirector]dismissModalViewControllerAnimated:YES];
    
    switch (result) {
        case MFMailComposeResultSent:
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"Sending Result"
                                  message: @"Email Sent"
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
            
            
            break;
        case MFMailComposeResultSaved:
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"Email Result"
                                  message: @"Email Saved"
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
            
            break;
        case MFMailComposeResultCancelled:
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"Email Result"
                                  message: @"Email Cancelled"
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
            
            break;
        case MFMailComposeResultFailed:
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"Email Result"
                                  message: @"Email Failed"
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
            
            break;
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"Email Result"
                                  message: @"Email Other Error"
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
            
            break;
    }
}

- (void) onClickOk{
    FX_BTN();
    [[CCDirector sharedDirector] replaceScene: [MainScene node]];
}

-(void)showPurchaseAlert:(NSString *) messsage :(int)tag
{
    UIAlertView   *alert = [[UIAlertView alloc] initWithTitle:@"Flappy Bird" message:messsage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    alert.tag = tag;
    [alert show];
    alert = nil;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch(buttonIndex)
    {
        case 0:
            //cancel
            NSLog(@"NO");
            break;
        case 1:
            NSLog(@"GetLives");
            NSLog(@"YES");
            break;
        default:
            break;
    }
}
@end
