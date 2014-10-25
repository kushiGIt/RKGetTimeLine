//
//  RKGetTimeLine.m
//  RKGetTimeLine
//
//  Created by RyousukeKushihata on 2014/10/25.
//  Copyright (c) 2014年 RyousukeKushihata. All rights reserved.
//

#import "RKGetTimeLine.h"

@implementation RKGetTimeLineData{
    NSUserDefaults*defaults;
}


#pragma mark - initialize
-(id)init{
    self=[super init];
    
    if (self==nil) {
        
        defaults=[NSUserDefaults standardUserDefaults];
    
    }
    
    return self;
}
#pragma merk - Set Account type

-(void)SetAccountType:(RKGetTimeLineAccountType)accountType{
    
    switch (accountType) {
        
        case GetTimeLineAccountType_FACEBOOK:{
            
            break;
            
        }case GetTimeLineAccountType_TWITTER:{
            
            break;
        
        }default:{
            
            NSDictionary *errorDic = @{
                                       NSLocalizedDescriptionKey:@"Number cannot be divided by zero.",
                                       NSLocalizedRecoverySuggestionErrorKey:@"You can set numberB except zero"
                                       };
            NSException*exception=[[NSException alloc]initWithName:@"AccountTypeException"
                                                            reason:[NSString stringWithFormat:@"This account type is an exception. \nIncorrect　Account type=%u",accountType]
                                                          userInfo:nil];
            
            break;
        }
    }

}

@end
