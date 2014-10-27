//
//  RKGetDataWithNSURLSettion.m
//  RKGetTimeLine
//
//  Created by RyousukeKushihata on 2014/10/26.
//  Copyright (c) 2014年 RyousukeKushihata. All rights reserved.
//

#import "RKGetDataWithNSURLSettion.h"

@implementation RKGetDataWithURLSettion

-(void)getDataWithUrlArray:(NSArray*)array{
    
    taskProgressDic=[[NSMutableDictionary alloc]init];
    
    dispatch_group_t group = dispatch_group_create();
    
    for (NSString*urlStr in array) {
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_group_async(group, queue, ^{
            
            NSURL*url=[NSURL URLWithString:urlStr];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            NSURLSessionConfiguration*configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession*session=[NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
            NSURLSessionTask*getImageTask=[session downloadTaskWithRequest:request];
            
            [getImageTask resume];
            
        });
        
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    NSLog(@"Complete add all task");
    
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    double progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
    
    [taskProgressDic setObject:[NSNumber numberWithDouble:progress] forKey:[NSString stringWithFormat:@"%@",[[downloadTask originalRequest]URL]]];
    
    if ([self.delegate respondsToSelector:@selector(getProgressInDictionary:)]) {
        
        [self.delegate getProgressInDictionary:taskProgressDic];
    
    }

}
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
    NSData* data = [NSData dataWithContentsOfURL:location];
    
    RKGetDataErrorType errorType;
    
    NSString*completeUrlStr=[NSString stringWithFormat:@"%@",[[downloadTask originalRequest]URL]];
    
    if (data.length == 0) {
        
        errorType=RKGetDataErrorType_ReciveDataIsNull;
    
    }else{
        
        errorType=RKGetDataErrorType_Success;
    
    }
    
    if ([self.delegate respondsToSelector:@selector(completeGetData:withErrorType:andCompeteReciveUrl:)]) {
        
        [self.delegate completeGetData:data withErrorType:errorType andCompeteReciveUrl:completeUrlStr];
    
    }
    
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    RKTaskCompletedCondition condition;
    
    if (error == nil){
        
        condition=RKTaskCompletedConditionSuccessfully;
    
    }
    else{
        
        condition=RKTaskCompletedConditionFailure;
    
    }
    
     NSString*urlStr=[NSString stringWithFormat:@"%@",[[task originalRequest]URL]];
    
    if ([self.delegate respondsToSelector:@selector(didComplteTask:taskURL:withError:)]) {
        
        [self.delegate didComplteTask:condition taskURL:urlStr withError:error];
    
    }

}

@end
