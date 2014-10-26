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

//@interface GetImageWithNSURLSettion : UIViewController<NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDownloadDelegate>{
//    
//}
//@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//property (weak, nonatomic) IBOutlet UIProgressView *progressView;@
//
//@property (nonatomic) NSURLSession *session;
//@property (nonatomic) NSURLSessionDownloadTask *downloadTask;
//
//
//@end

@class RKGetImageWithURLSettion;

@protocol  RKGetImageWithURLSettionDelegate;

@interface RKGetImageWithURLSettion : NSObject<NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDownloadDelegate>{
}

@property NSMutableDictionary*taskProgressDic;

@property(nonatomic,weak)id<RKGetImageWithURLSettionDelegate>delegate;

-(void)getImageDataWithUrlArray:(NSArray*)array;
-(id)init;
@end


