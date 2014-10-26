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
#import "GetImageWithNSURLSettion.h"

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
    
    RKGetImageWithURLSettion*testSettion=[[RKGetImageWithURLSettion alloc]init];
    [testSettion getImageDataWithUrlArray:[[NSArray alloc]initWithObjects:@"http://aqueous-beyond-6099.herokuapp.com/images/maverick-osx.jpg",@"http://aqueous-beyond-6099.herokuapp.com/images/maverick-osx.jpg",@"http://aqueous-beyond-6099.herokuapp.com/images/maverick-osx.jpg",@"http://aqueous-beyond-6099.herokuapp.com/images/maverick-osx.jpg",@"http://aqueous-beyond-6099.herokuapp.com/images/maverick-osx.jpg",@"http://aqueous-beyond-6099.herokuapp.com/images/maverick-osx.jpg",@"http://aqueous-beyond-6099.herokuapp.com/images/maverick-osx.jpg",@"http://aqueous-beyond-6099.herokuapp.com/images/maverick-osx.jpg",@"http://aqueous-beyond-6099.herokuapp.com/images/maverick-osx.jpg", nil]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
