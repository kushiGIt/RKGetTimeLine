//
//  ViewController.m
//  RKGetTimeLine
//
//  Created by RyousukeKushihata on 2014/10/25.
//  Copyright (c) 2014年 RyousukeKushihata. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) STTwitterAPI*twitter;
@property (nonatomic, strong) FBLoginView *loginView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginView = [[FBLoginView alloc]init];
    self.loginView.delegate=self;
    self.loginView.center = self.view.center;
    //FBSessionLoginBehavior
    self.loginView.loginBehavior=FBSessionLoginBehaviorUseSystemAccountIfPresent;
    [self.view addSubview:self.loginView];
    
    FBRequestConnection*requestConnecton=[[FBRequestConnection alloc]init];
    [requestConnecton setDelegate:self];

}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    [FBRequestConnection startWithGraphPath:@"me/feed" completionHandler:^(FBRequestConnection *connection,id result,NSError *error){
        
        NSLog(@"=============FACEBOOK_RESULTS=============");
        
        NSLog(@"connection=%@",connection);
        NSLog(@"result=%@",result);
        NSLog(@"error=%@",error);
        
        NSLog(@"====================END====================");
        
    }];
    
    
    self.twitter=[STTwitterAPI twitterAPIOSWithFirstAccount];
    [_twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
        
        NSLog(@"=============TWITTER_RESULTS=============");
        
        NSLog(@"twitter user name (results) %@",username);
        [self getTwitterTest];
        
        NSLog(@"====================END====================");
        
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"twitter error (results) %@",error);
        
    }];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getTwitterTest{
    
    [_twitter getHomeTimelineSinceID:nil
                               count:20
                        successBlock:^(NSArray *statuses) {
                            
                            NSLog(@"-- twitter statuses: %@", statuses);
                            
                        } errorBlock:^(NSError *error) {
                            
                            NSLog(@"-- twitter error: %@",error);
                            
                        }];
    
}
-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    NSLog(@"%@",error);
}
-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    NSLog(@"%@",user);
}
-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    
}
-(void)requestConnection:(FBRequestConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}
-(void)requestConnection:(FBRequestConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{
    NSLog(@"%ld",(long)totalBytesExpectedToWrite);
}
@end
