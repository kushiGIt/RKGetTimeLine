//
//  GetImageWithNSURLSettion.h
//  RKGetTimeLine
//
//  Created by RyousukeKushihata on 2014/10/26.
//  Copyright (c) 2014年 RyousukeKushihata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

typedef NS_ENUM(NSInteger,RKGetImageDataErrorType){
    RKGetImageDataErrorType_ReciveDataIsNull, 
    RKGetImageDataErrorType_Success
};

@class RKGetDataWithURLSettion;

@protocol  RKGetDataWithURLSettionDelegate;

@interface RKGetDataWithURLSettion : NSObject<NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDownloadDelegate>{
    
    NSMutableDictionary*taskProgressDic;
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
-(void)getProgressInDictionary:(NSDictionary*)progressValueInDic;
/**
 *  This method call when complete recive data.
 *
 *  @param data      recived data
 *  @param errorType RKGetImageDataErrorType
 */
-(void)completeGetData:(NSData*)data withErrorType:(RKGetImageDataErrorType)errorType andCompeteReciveUrl:(NSString*)urlStr;
@end


