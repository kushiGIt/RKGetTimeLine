//
//  RKGetTimeLine.h
//  RKGetTimeLine
//
//  Created by RyousukeKushihata on 2014/10/25.
//  Copyright (c) 2014年 RyousukeKushihata. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{
    
    RKGetTimeLineErrorType_Success=0,
    RKGetTimeLineErrorType_AccountError=1,
    RKGetTimeLineErrorType_RequestError=2,
    RKGetTimeLineErrorType_DataIsNull=3,
    RKGetTimeLineErrorType_TwitterServerError=4

}RKGetTimeLineErrorType;

typedef enum {
    
    GetTimeLineAccountType_FACEBOOK=1,
    GetTimeLineAccountType_TWITTER=2,

}GetTimeLineAccountType;

typedef enum : NSInteger{
    
    RKGetTimeLineDataError_AccountTypeInvalid
    
}RKGetTimeLineDataErrorCode;

@class RKGetTimeLineData;

@protocol RKGetTimeLineDataDelegate;

@interface RKGetTimeLineData : NSObject

@property(nonatomic,weak)id<RKGetTimeLineDataDelegate>delegate;

-(id)init;
-(void)GetServerData_Type:(GetTimeLineAccountType)accountType;

@end

