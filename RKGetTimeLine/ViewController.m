//
//  ViewController.m
//  RKGetTimeLine
//
//  Created by RyousukeKushihata on 2014/10/25.
//  Copyright (c) 2014年 RyousukeKushihata. All rights reserved.
//

#import "ViewController.h"
#import "RKGetTimeLine.h"
#import "RKGetFacebookTimeLine.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    RKGetFacebookTimeLine*testFacebook=[[RKGetFacebookTimeLine alloc]init];
    
    NSDictionary*readOnlyOptions=@{
                                   ACFacebookAppIdKey : @"878372405515997",
                                   ACFacebookAudienceKey : ACFacebookAudienceOnlyMe,
                                   ACFacebookPermissionsKey : @[@"email"]
                                   };
    
    [testFacebook getFacebookTimelineFromServer:readOnlyOptions completion:^(NSArray*resultsArray,NSError*error){
        NSLog(@"%@",resultsArray);
        NSLog(@"%@",error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
