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
    
//    RKGetFacebookTimeLine*test_facebook=[[RKGetFacebookTimeLine alloc]init];
//    [test_facebook getFacebookTimelineNewlyWithCompletion:^(NSDictionary*dic,NSError*error){
//        
//    }];
    
    RKGetDataWithURLSettion*testSettion=[[RKGetDataWithURLSettion alloc]init];
    testSettion.delegate=self;
    
    [testSettion getDataWithUrlArray:[[NSArray alloc]initWithObjects:@"http://aqueous-beyond-6099.herokuapp.com/images/maverick-osx.jpg",@"https://scontent-b.xx.fbcdn.net/hphotos-xfa1/v/t1.0-9/1653489_355346127959339_1933610677989687628_n.jpg?oh=c8240cf4b1db62b1646cb95bdd3e0bdc&oe=54ABE206",@"https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-xpf1/v/t1.0-9/10690037_355346094626009_5405824933846730956_n.jpg?oh=7667552b1ecfc4ca35a4d2d848c96abd&oe=54EEE3A7&__gda__=1420538317_bbc24ffae022b4a44d27ae3e0af699b1", nil]];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getProgressInDictionary:(NSDictionary *)progressValueInDic withAllTaskCount:(NSNumber *)taskCount{
    
    float progress = 0.0;
    
    for (NSNumber*num in [progressValueInDic allValues]) {
    
        progress=progress+[num floatValue];
        
    }
    
    NSLog(@"All task is progressing.....%f persent",progress/[taskCount floatValue]*100);

}
-(void)completeGetData:(NSData *)data withErrorType:(RKGetDataErrorType)errorType CompeteReciveUrl:(NSString *)urlStr AllTaskCount:(NSNumber *)taskCount{
    
    NSLog(@"=======================COMPLETE========================");
    NSLog(@"errorType=%ld",errorType);
    NSLog(@"%@",urlStr);
    NSLog(@"all task count=%@",taskCount);
    NSLog(@"complete recive data %ld byte",data.length);
    
}
-(void)didComplteTask:(RKTaskCompletedCondition)condition taskURL:(NSString *)urlStr withError:(NSError *)error{
    
    NSLog(@"=======================Finish_.htask========================");
    NSLog(@"%ld",condition);
    NSLog(@"%@",urlStr);
    NSLog(@"%@",error);
    
}
@end
