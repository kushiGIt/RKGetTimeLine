//
//  GetImageWithNSURLSettion.m
//  RKGetTimeLine
//
//  Created by RyousukeKushihata on 2014/10/26.
//  Copyright (c) 2014年 RyousukeKushihata. All rights reserved.
//

#import "GetImageWithNSURLSettion.h"

@implementation RKGetImageWithURLSettion
-(id)init{
    NSLog(@"init");
    return self;
}
-(void)getImageDataWithUrlArray:(NSArray*)array{
    
    taskProgressDic=[[NSMutableDictionary alloc]init];
    
    for (NSString*urlStr in array) {
        
        dispatch_group_t group = dispatch_group_create();
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_group_async(group, queue, ^{
            
            NSURL*url=[NSURL URLWithString:urlStr];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            NSURLSessionConfiguration*configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession*session=[NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
            NSURLSessionTask*getImageTask=[session downloadTaskWithRequest:request];
            [getImageTask resume];

        
        });
        
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        
        NSLog(@"Complete add all task");
    }
    
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
//    if (downloadTask == self.downloadTask)
//    {
//        //NSLog(@"totalBytesWirt:%lld    totalBytesExpected:%lld",totalBytesWritten, totalBytesExpectedToWrite);
//        double progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
//        NSLog(@"progress...%f percent",progress*100);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            _progressView.progress = progress;
//        });
//    }
    double progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
    [taskProgressDic setObject:[NSNumber numberWithDouble:progress] forKey:[NSString stringWithFormat:@"%@",downloadTask]];
    NSLog(@"%@",taskProgressDic);
    
    
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)downloadURL
{
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    NSArray *URLs = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
//    NSURL *documentsDirectory = [URLs objectAtIndex:0];
//    
//    NSURL *originalURL = [[downloadTask originalRequest] URL];
//    NSURL *destinationURL = [documentsDirectory URLByAppendingPathComponent:[originalURL lastPathComponent]];
//    [fileManager removeItemAtURL:destinationURL error:NULL];
//    BOOL success = [fileManager copyItemAtURL:downloadURL toURL:destinationURL error:NULL];
//    
//    if (success)
//    {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            UIImage *image = [UIImage imageWithContentsOfFile:[destinationURL path]];
//            _imageView.image = image;
//            _imageView.hidden = NO;
//            _progressView.hidden = YES;
//        });
//    }
}


/*- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error == nil)
    {
        NSLog(@"Task: %@ completed successfully", task);
    }
    else
    {
        NSLog(@"Task: %@ completed with error: %@", task, [error localizedDescription]);
    }
    
    double progress = (double)task.countOfBytesReceived / (double)task.countOfBytesExpectedToReceive;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressView.progress = progress;
    });
    
    _downloadTask = nil;
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.backgroundSessionCompletionHandler)
    {
        void (^completionHandler)() = appDelegate.backgroundSessionCompletionHandler;
        appDelegate.backgroundSessionCompletionHandler = nil;
        completionHandler();
    }
    
    NSLog(@"All tasks are finished");
}
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{}*/

@end
