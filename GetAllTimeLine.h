//
//  GetAllTimeLine.h
//  RKGetTimeLine
//
//  Created by RyousukeKushihata on 2014/11/16.
//  Copyright (c) 2014年 RyousukeKushihata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKGetFacebookTimeLine.h"
#import "RKGetTwitterTimeLine.h"

typedef void (^CallbackHandlerForGetInfo)(NSMutableArray*urlArray,NSMutableArray*timelineDataArray);

@class GetAllTimeLine;
@protocol GetAllTimeLineDelegate <NSObject>

@end

@interface GetAllTimeLine : NSObject{
    
}

+(void)getAllTimeLine:(CallbackHandlerForGetInfo)handler;


//@property(nonatomic,weak)id<GetAllTimeLineDelegate>delegate;

@end



