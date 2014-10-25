//
//  RKGetFacebookTimeLine.h
//  RKGetTimeLine
//
//  Created by RyousukeKushihata on 2014/10/25.
//  Copyright (c) 2014年 RyousukeKushihata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

typedef enum{
    RKGetFacebookTimeLineErrorType_Success=0,
    RKGetFacebookTimeLineErrorType_AccountError=1,
    RKGetFacebookTimeLineErrorType_RequestError=2,
    RKGetFacebookTimeLineErrorType_DataIsNull=3,
    RKGetFacebookTimeLineErrorType_FacebookServerError=4
}RKGetFacebookTimeLineError;


typedef void (^CallbackHandlerForServer)(NSArray * resultArray, NSError *error);



@class RKGetFacebookTimeLine;

@protocol RKGetFacebookDelegate;

@interface RKGetFacebookTimeLine : NSObject

@property(nonatomic,weak)id<RKGetFacebookDelegate>delegate;

-(void)getFacebookTimelineFromServer:(NSDictionary*)option completion:(CallbackHandlerForServer)handler;


@end