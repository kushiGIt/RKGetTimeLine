//
//  GetInformation.h
//  RKGetTimeLine
//
//  Created by RyousukeKushihata on 2014/11/19.
//  Copyright (c) 2014年 RyousukeKushihata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetAllTimeLine.h"
#import "RKDataDownloader.h"
#import "ManageCoreData.h"

@class GetInformation;
@protocol GetInformationDelegate;

typedef void (^CallbackHandler)(NSArray*timelineDataArray);

@interface GetInformation : NSObject<RKDataDownloaderDelegate>{
    
}

@property id<GetInformationDelegate>delegate;

-(void)getSubmission:(CallbackHandler)handler;

@end

@protocol  GetInformationDelegate<NSObject>
@optional

-(void)didFinishAllDownload;

@end
