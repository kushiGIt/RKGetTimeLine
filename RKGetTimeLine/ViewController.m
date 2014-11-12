//
//  ViewController.m
//  RKGetTimeLine
//
//  Created by RyousukeKushihata on 2014/10/25.
//  Copyright (c) 2014年 RyousukeKushihata. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIProgressView *progressview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
    
    NSLog(@"Start get image data.");
    
    RKDataDownloader*dataDownloader=[[RKDataDownloader alloc]initWithUrlArray_defaults:[RKDataDownloader cheakDuplicationURLString:urlStrArray]];
    dataDownloader.delegate=self;
    [dataDownloader startDownloads];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - RKDownloader delegate
-(void)fileDownloadProgress:(NSNumber *)progress{
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
 dispatch_async(mainQueue, ^{
     
     [self.progressview setProgress:[progress floatValue] animated:YES];
     
  });
    
}
-(void)didFinishDownloadData:(NSData *)data withError:(NSError *)readingDataError dataWithURL:(NSString *)urlStr{
    
    NSLog(@"complete recive data.Data size is %ld byte.",data.length);
    
}
-(void)didFinishAllDownloadsWithDataDictinary:(NSDictionary *)dataDic withErrorDic:(NSDictionary *)errorDic{
    
    NSLog(@"%@",dataDic.allKeys);
    
    
}
@end
