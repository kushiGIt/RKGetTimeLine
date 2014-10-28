//
//  RKGetDataWithNSURLSettion.h
//  RKGetTimeLine
//
//  Created by RyousukeKushihata on 2014/10/26.
//  Copyright (c) 2014年 RyousukeKushihata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

typedef NS_ENUM(NSInteger,RKGetDataErrorType){
    
    RKGetDataErrorType_Success,
    RKGetDataErrorType_ReciveDataIsNull

};
typedef NS_ENUM(NSInteger,RKTaskCompletedCondition){
    
    RKTaskCompletedConditionSuccessfully,
    RKTaskCompletedConditionFailure
    
};

@class RKGetDataWithURLSettion;

@protocol  RKGetDataWithURLSettionDelegate;

@interface RKGetDataWithURLSettion : NSObject<NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDownloadDelegate>{
    
    NSMutableDictionary*taskProgressDic;
    NSNumber*taskCount;
}

@property id<RKGetDataWithURLSettionDelegate>delegate;
/**
 *  This method get data from url. You must not set NSURL. Only NSString!!
 *
 *  @param array only String url in array.
 */
-(void)getDataWithUrlArray:(NSArray*)array;

@end


@protocol RKGetDataWithURLSettionDelegate <NSObject>

@optional
/**
 *  This methods use for cheak progress(optinal)
 *
 *  @param progressValueInDic NSNumber(progress value) in NSDictionary
 */
-(void)getProgressInDictionary:(NSDictionary*)progressValueInDic withAllTaskCount:(NSNumber*)taskCount;
/**
 *  This method call when complete recive data.
 *
 *  @param data      recived data
 *  @param errorType RKGetDataErrorType
 */
-(void)completeGetData:(NSData*)data withErrorType:(RKGetDataErrorType)errorType CompeteReciveUrl:(NSString*)urlStr AllTaskCount:(NSNumber*)taskCount;
/**
 *  This method call when finish task. Return TaskCondition,URL and error.
 *
 *  @param condition RKTaskCompletedCondition
 *  @param urlStr    finished task url
 *  @param error     task error
 */
-(void)didComplteTask:(RKTaskCompletedCondition)condition taskURL:(NSString*)urlStr withError:(NSError*)error;
@end


