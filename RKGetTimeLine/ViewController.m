//
//  ViewController.m
//  RKGetTimeLine
//
//  Created by RyousukeKushihata on 2014/10/25.
//  Copyright (c) 2014年 RyousukeKushihata. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    NSLock*threadLock=[[NSLock alloc]init];
    
    __block int isProgress=0;
    __block NSMutableArray*urlStrArray=[[NSMutableArray alloc]init];
    
    RKGetFacebookTimeLine*test_facebook=[[RKGetFacebookTimeLine alloc]init];
    [test_facebook getFacebookTimelineNewlyWithCompletion:^(NSArray*array,NSError*error){
        
        dispatch_group_t group_facebook = dispatch_group_create();
        
        for (NSDictionary*dataDic in array) {
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            
            dispatch_group_async(group_facebook, queue, ^{
                
                [threadLock lock];
                
                @try {
                    
                    NSString*urlStr=[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture",[dataDic objectForKey:@"USER_ID"]];
                    [urlStrArray addObject:urlStr];
                
                }
                
                @finally {
                    
                    [threadLock unlock];
                
                }
                                 
            });
            
        }
        
        dispatch_group_wait(group_facebook, DISPATCH_TIME_FOREVER);
        
        NSLog(@"facebook task...done");
        
        isProgress++;
    }];
    
    RKGetTwitterTimeline*test_twitter=[[RKGetTwitterTimeline alloc]init];
    [test_twitter getFacebookTimelineNewlyWithCompletion:^(NSArray*array,NSError*error){
        
        dispatch_group_t group_twitter = dispatch_group_create();
        
        for (NSDictionary*dataDic in array) {
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            
            dispatch_group_async(group_twitter, queue, ^{
                
                [threadLock lock];
                
                @try {
                    
                    NSString*urlStr=[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"USER_ICON"]];
                    [urlStrArray addObject:urlStr];
                
                }
                @finally {
                    
                    [threadLock unlock];
                
                }
                
            });
            
        }
        
        dispatch_group_wait(group_twitter, DISPATCH_TIME_FOREVER);
        
        NSLog(@"twitter task...done");
        
        isProgress++;
    }];
    
    
    while(isProgress<2){
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1f]];
    }
    
    NSLog(@"Process for receiving the data has been completed all.");
    
    RKGetDataWithURLSettion*testSettion=[[RKGetDataWithURLSettion alloc]init];
    testSettion.delegate=self;
    
    [testSettion getDataWithUrlArray:[[NSArray alloc]initWithArray:urlStrArray]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - RKGetDataWithNSURLSession Delegate
-(void)getProgressInDictionary:(NSDictionary *)progressValueInDic withAllTaskCount:(NSNumber *)taskCount{
    
    double progress = 0.0;
    
    for (NSNumber*num in [progressValueInDic allValues]) {
    
        progress=progress+[num floatValue];
        
    }
    
    NSLog(@"All task is progressing.....%f persent",progress/[taskCount floatValue]);

}
-(void)completeGetData:(NSData *)data withErrorType:(RKGetDataErrorType)errorType CompeteReciveUrl:(NSString *)urlStr AllTaskCount:(NSNumber *)taskCount{
    
    NSLog(@"=======================COMPLETE========================");
//    NSLog(@"errorType=%ld",errorType);
//    NSLog(@"%@",urlStr);
//    NSLog(@"all task count=%@",taskCount);
//    NSLog(@"complete recive data %ld byte",data.length);
    
}
-(void)didComplteTask:(RKTaskCompletedCondition)condition taskURL:(NSString *)urlStr withError:(NSError *)error{
    
//    NSLog(@"=======================Finish_task========================");
//    NSLog(@"%ld",condition);
//    NSLog(@"%@",urlStr);
//    NSLog(@"%@",error);
    
}
@end
