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

typedef NS_ENUM(NSUInteger,RKGetFacebookTimeLineError){
    /**
     *  Return when there was no error and app was able to obtain the facebook information correctly.
     */
    RKGetFacebookTimeLineErrorType_Success=0,
    /**
     *  Return when app does not have a valid facebook account.
     */
    RKGetFacebookTimeLineErrorType_AccountIsNULL=1,
    /**
     *  Return when the user did not accept the permission of the account of app.
     */
    RKGetFacebookTimeLineErrorType_NoPermission=2,
    /**
     *  Return when there was no response from the server.
     */
    RKGetFacebookTimeLineErrorType_RequestError=3,
    /**
     *  Return when there was no new data on facebook server.
     */
    RKGetFacebookTimeLineErrorType_DataIsNull=4,
    /**
     *  Return when there was error of facebook server or miss of the developer's code.
     */
    RKGetFacebookTimeLineErrorType_FacebookServerError=5
};


typedef void (^CallbackHandlerForServer)(NSArray *resultArray, NSError *error, RKGetFacebookTimeLineError*errorType);
typedef void (^CallbackHandlerForEdit)(NSDictionary *resultsDic, NSError *error);



@class RKGetFacebookTimeLine;

@protocol RKGetFacebookDelegate;

@interface RKGetFacebookTimeLine : NSObject

@property(nonatomic,weak)id<RKGetFacebookDelegate>delegate;
/**
 *  This method get a facebook post from the server.  When the prosess is finished,run completion block.
 *
 *  @param permissionDic {NSDictionary}
 *  @param handler       {void}
 */
-(void)getFacebookTimelineFromServer:(NSDictionary*)permissionDic completion:(CallbackHandlerForServer)handler;

@end
