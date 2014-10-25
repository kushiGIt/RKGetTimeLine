//
//  RKGetTimeLine.m
//  RKGetTimeLine
//
//  Created by RyousukeKushihata on 2014/10/25.
//  Copyright (c) 2014年 RyousukeKushihata. All rights reserved.
//

#import "RKGetTimeLine.h"
#import "RKGetFacebookTimeLine.h"

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

-(void)GetServerData_Type:(GetTimeLineAccountType)accountType{
    
    switch (accountType) {
        
        case GetTimeLineAccountType_FACEBOOK:{
            
            break;
            
        }case GetTimeLineAccountType_TWITTER:{
            
            break;
        
        }default:{
            NSException*exception=[[NSException alloc]initWithName:@"AccountTypeException"
                                                            reason:[NSString stringWithFormat:@"\nThis account type is an exception. \nIncorrect　Account type=%u\n",accountType]
                                                          userInfo:nil];
            NSLog(@"%@",exception);
            
            break;
        }
    }

}

@end
