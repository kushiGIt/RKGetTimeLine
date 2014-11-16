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
    
    ManageCoreData*mcd=[[ManageCoreData alloc]init];

    [mcd checkDateInEntity:@"DataLifeTime" isDelete:YES];
    
    [GetAllTimeLine getAllTimeLine:^(NSMutableArray*urlStrArray,NSMutableArray*timelineDataArray){
        
        NSLog(@"Start get image data.");
        
        NSMutableIndexSet*indexSet=[[NSMutableIndexSet alloc]init];
        NSUInteger index=0;
        NSLock *coredataLock=[[NSLock alloc]init];
        
        
        for (NSString*urlStr in urlStrArray) {
            
            [coredataLock lock];
            
            @try {
                
                if ([mcd checkDupulicationInEntity:@"DataLifeTime" withKey:urlStr]!=NULL) {
                    
                    [indexSet addIndex:index];
                    
                }
                
                index++;
                
            }
            @finally {
                
                [coredataLock unlock];
                
            }
            
        }
        
        [urlStrArray removeObjectsAtIndexes:indexSet];
        
        RKDataDownloader*dataDownloader=[[RKDataDownloader alloc]initWithUrlArray_defaults:[RKDataDownloader cheakDuplicationURLString:urlStrArray]];
        dataDownloader.delegate=self;
        [dataDownloader startDownloads];
        
    }];
    
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
-(void)didFinishDownloadData:(NSData *)data withError:(NSError *)readingDataError dataWithUrl:(NSString *)urlStr{
    
    NSDate*now=[NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone]secondsFromGMT]];
    
    ManageCoreData*mcd=[[ManageCoreData alloc]init];
    [mcd setContextData:data forKey:urlStr ObjectDeleteTime:[now dateByAddingTimeInterval:60*60*24] ischeckDupulicationInEntity:YES];

}
-(void)didFinishAllDownloadsWithDataDictinary:(NSDictionary *)dataDic withErrorDic:(NSDictionary *)errorDic{
    
    //ManageCoreData*mcd=[[ManageCoreData alloc]init];
    //NSLog(@"%@",[mcd checkDateInEntity:@"DataLifeTime" isDelete:NO]);
    
}

@end
