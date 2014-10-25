//
//  RKGetFacebookTimeLine.m
//  RKGetTimeLine
//
//  Created by RyousukeKushihata on 2014/10/25.
//  Copyright (c) 2014年 RyousukeKushihata. All rights reserved.
//

#import "RKGetFacebookTimeLine.h"

@implementation RKGetFacebookTimeLine{
    
}
-(void)getFacebookTimelineFromServer:(NSDictionary*)permissionDic completion:(CallbackHandlerForServer)handler{
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    [accountStore requestAccessToAccountsWithType:accountType options:permissionDic completion:^(BOOL granted, NSError *accountsError){
        
        if (granted==YES) {
            
            NSArray *facebookAccounts = [accountStore accountsWithAccountType:accountType];
            
            if (facebookAccounts!=nil&&facebookAccounts.count!=0) {
                
                ACAccount *facebookAccount = [facebookAccounts lastObject];
                
                ACAccountCredential *facebookCredential = [facebookAccount credential];
                NSString *accessToken = [facebookCredential oauthToken];
                
                NSURL*url=[NSURL URLWithString:@"https://graph.facebook.com/me/home"];
                NSDictionary*parametersDic=[[NSDictionary alloc]initWithObjectsAndKeys:accessToken,@"access_token",@500,@"limit", nil];
                
                SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodGET URL:url parameters:parametersDic];
                request.account = facebookAccount;
                
                [request performRequestWithHandler:^(NSData*responseData,NSHTTPURLResponse*urlResponse,NSError*error){
                        
                        if (error) {
                            NSLog(@"Facebook error==>%@",error);
                        }
                        
                        if (urlResponse) {
                            
                            NSError *jsonError;
                            NSLog(@"Completion of receiving Facebook timeline data. Byte=%lu byte.",(unsigned long)responseData.length);
                            
                            NSArray*responseArray=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&jsonError];
                            
                            if (jsonError) {
                                
                                NSLog(@"%s,%@",__func__,jsonError);
                                
                            }else{
                                
                                if ([[responseArray valueForKey:@"error"]valueForKey:@"message"]) {
                                    
                                    NSDictionary*facebookErrorDic=[[NSDictionary alloc]initWithDictionary:[responseArray valueForKey:@"error"]];
                                    
                                    NSString*errorCode=[NSString stringWithFormat:@"%@",[facebookErrorDic objectForKey:@"code"]];
                                    NSString*errorMessege=[NSString stringWithFormat:@"%@",[facebookErrorDic objectForKey:@"message"]];
                                    
                                    NSMutableDictionary*errDetails = [NSMutableDictionary dictionary];
                                    [errDetails setValue:errorMessege forKey:NSLocalizedDescriptionKey];
                                    
                                    NSError*resultsError = [NSError errorWithDomain:@"https://graph.facebook.com/me/home" code:[errorCode integerValue] userInfo:errDetails];
                                    
                                    if (handler) {
                                        handler(nil,resultsError);
                                    }
                                    
                                }else{
                                    
                                    if ([[responseArray valueForKey:@"data"]count]==0) {
                                        
                                        NSMutableDictionary*errDetails = [NSMutableDictionary dictionary];
                                        [errDetails setValue:@"There is no new data." forKey:NSLocalizedDescriptionKey];
                                        NSError*resultsError = [NSError errorWithDomain:@"https://graph.facebook.com/me/home" code:200 userInfo:errDetails];
                                        
                                        if (handler) {
                                            handler(nil,resultsError);
                                        }
                                        
                                    }else{
                                        
                                        if (handler) {
                                            handler([responseArray valueForKey:@"data"],nil);
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            
                            
                        }else{
                            
                            NSMutableDictionary*errDetails = [NSMutableDictionary dictionary];
                            [errDetails setValue:@"There was no response from the server." forKey:NSLocalizedDescriptionKey];
                            NSError*resultsError = [NSError errorWithDomain:@"https://graph.facebook.com/me/home" code:201 userInfo:errDetails];
                            
                            if (handler) {
                                handler(nil,resultsError);
                            }
                            
                        }
                    
                }];
            
            }else{
                
                NSMutableDictionary*errDetails = [NSMutableDictionary dictionary];
                [errDetails setValue:@"App does not have a valid facebook account." forKey:NSLocalizedDescriptionKey];
                NSError*resultsError = [NSError errorWithDomain:@"https://graph.facebook.com/me/home" code:202 userInfo:errDetails];
                
                if (handler) {
                    handler(nil,resultsError);
                }
                
            }
        }else{
            
            NSMutableDictionary*errDetails = [NSMutableDictionary dictionary];
            [errDetails setValue:@"The user did not accept the permission of the account of app." forKey:NSLocalizedDescriptionKey];
            NSError*resultsError = [NSError errorWithDomain:@"https://graph.facebook.com/me/home" code:203 userInfo:errDetails];
            
            if (handler) {
                handler(nil,resultsError);
            }
        }
        
    }];
}

@end
