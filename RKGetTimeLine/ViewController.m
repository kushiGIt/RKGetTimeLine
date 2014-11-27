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
    
    GetInformation*gi=[[GetInformation alloc]init];
    [gi setDelegate:self];
    
    [gi getSubmission:^(NSArray*array){
        
        NSLog(@"%@",[array lastObject]);
        
    }];
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didFinishAllDownload{
    NSLog(@"finish all download");
}

@end
