//
//  ViewController.m
//  RKGetTimeLine
//
//  Created by RyousukeKushihata on 2014/10/25.
//  Copyright (c) 2014年 RyousukeKushihata. All rights reserved.
//

#import "ViewController.h"
#import "RKGetFacebookTimeLine.h"
#import "RKGetTwitterTimeline.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    /*
     test to get facebook timeline
     */
    /*RKGetFacebookTimeLine*testFacebook=[[RKGetFacebookTimeLine alloc]init];
    
    NSDictionary*readOnlyOptions=@{
                                   ACFacebookAppIdKey : @"878372405515997",
                                   ACFacebookAudienceKey : ACFacebookAudienceOnlyMe,
                                   ACFacebookPermissionsKey : @[@"email",@"read_stream"]
                                   };
    
    [testFacebook getFacebookTimelineFromServer:readOnlyOptions completion:^(NSArray*resultsArray,NSError*error){
        
        NSLog(@"=======FACEBOOK=======");
        NSLog(@"%lu",(unsigned long)resultsArray.count);
        NSLog(@"%@",error);
    
    }];*/
    
    /*
     test to get twitter timeline
     */
    /*NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    NSDictionary*parametersDic;
    
    if ([defaults stringForKey:@"TWITTER_SINCE_ID"].length==0) {
        
        parametersDic=@{@"include_entities": @"1",@"count": @"200"};
        NSLog(@"request parameters don't have since_id");
        
    }else{
        
        parametersDic=@{@"include_entities": @"1",@"count": @"200",@"since_id": [defaults stringForKey:@"TWITTER_SINCE_ID"]};
        NSLog(@"request parameters have since_id");
        
    }
    
    RKGetTwitterTimeline*testTwitter=[[RKGetTwitterTimeline alloc]init];
    [testTwitter getTwitterTimelineFromServer:parametersDic completion:^(NSArray*resultsArray,NSError*error){
        
        NSLog(@"=======TWITTER=======");
        NSLog(@"%lu",(unsigned long)resultsArray.count);
        NSLog(@"%@",error);
    
    }];*/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
