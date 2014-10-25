//
//  RKGetTwitterTimeLine.m
//  RKGetTimeLine
//
//  Created by RyousukeKushihata on 2014/10/26.
//  Copyright (c) 2014年 RyousukeKushihata. All rights reserved.
//

#import "RKGetTwitterTimeLine.h"

@implementation RKGetTwitterTimeline{
    
}

-(void)getTwitterTimelineFromServer:(NSDictionary*)parametersDic completion:(CallbackHandlerForServer)handler{
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted,NSError *accountsError){
            
            if (granted==YES) {
                
                NSArray*accounts=[accountStore accountsWithAccountType:accountType];
                
                if (accounts!=nil&&accounts.count!=0) {
                    
                    ACAccount *twAccount = accounts[0];
                    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/home_timeline.json"];
                    
                    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:url parameters:parametersDic];
                    request.account = twAccount;
                    
                    [request performRequestWithHandler:^(NSData*responseData,NSHTTPURLResponse*urlResponse,NSError*error){
                        
                        if (error) {
                            NSLog(@"%@",error);
                        }
                        
                        if (urlResponse) {
                            NSError *jsonError;
                            NSLog(@"Completion of receiving Twitter timeline data. Byte=%lu byte.",(unsigned long)responseData.length);
                            
                            NSMutableArray*responseArray=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&jsonError];
                            
                            if (jsonError) {
                                
                                NSLog(@"%s,%@",__func__,jsonError);
                                
                            }else{
                                
                                if ([[[responseArray valueForKey:@"errors"]valueForKey:@"message"]isEqual:[NSNull null]]) {
                                    
                                    NSLog(@"twitter request...Failured");
                                    NSString*errorCode=[NSString stringWithFormat:@"%@",[[responseArray valueForKey:@"errors"]valueForKey:@"code"][0]];
                                    NSString*errorMessege=[NSString stringWithFormat:@"%@",[[responseArray valueForKey:@"errors"]valueForKey:@"message"][0]];
                                    NSLog(@"%@",errorCode);
                                    NSLog(@"%@",errorMessege);
                                    
                                    NSMutableDictionary*errDetails = [NSMutableDictionary dictionary];
                                    [errDetails setValue:errorMessege forKey:NSLocalizedDescriptionKey];
                                    NSError*twitterError = [NSError errorWithDomain:@"https://api.twitter.com/1.1/statuses/home_timeline.json" code:[errorCode integerValue] userInfo:errDetails];
                                    
                                    if (handler) {
                                        handler(nil,twitterError);
                                    }
                                
                                }else{
                                    
                                    if (responseArray.count==0) {
                                        
                                        NSLog(@"There is no new data.");
                                        
                                        NSMutableDictionary*errDetails = [NSMutableDictionary dictionary];
                                        [errDetails setValue:@"There is no new data." forKey:NSLocalizedDescriptionKey];
                                        NSError*twitterError = [NSError errorWithDomain:@"https://api.twitter.com/1.1/statuses/home_timeline.json" code:100 userInfo:errDetails];
                                        
                                        if (handler) {
                                            handler(nil,twitterError);
                                        }
                                        
                                    }else{
                                        
                                        if (handler) {
                                            handler(responseArray,nil);
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }else{
                            
                            NSMutableDictionary*errDetails = [NSMutableDictionary dictionary];
                            [errDetails setValue:@"There was no response from the server." forKey:NSLocalizedDescriptionKey];
                            NSError*twitterError = [NSError errorWithDomain:@"https://api.twitter.com/1.1/statuses/home_timeline.json" code:101 userInfo:errDetails];
                            
                            if (handler) {
                                handler(nil,twitterError);
                            }
                            
                        }
                        
                    }];
                    
                    
                }else{
                    
                    NSMutableDictionary*errDetails = [NSMutableDictionary dictionary];
                    [errDetails setValue:@"App does not have a valid Twitter account." forKey:NSLocalizedDescriptionKey];
                    NSError*twitterError = [NSError errorWithDomain:@"https://api.twitter.com/1.1/statuses/home_timeline.json" code:102 userInfo:errDetails];
                    
                    if (handler) {
                        handler(nil,twitterError);
                    }
                    
                }
                
            }else{
                
                NSMutableDictionary*errDetails = [NSMutableDictionary dictionary];
                [errDetails setValue:@"The user did not accept the permission of the account of app." forKey:NSLocalizedDescriptionKey];
                NSError*twitterError = [NSError errorWithDomain:@"https://api.twitter.com/1.1/statuses/home_timeline.json" code:103 userInfo:errDetails];
                
                if (handler) {
                    handler(nil,twitterError);
                }
                
            }
        
    }];


}

@end
