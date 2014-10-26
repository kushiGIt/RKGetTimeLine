RKGetTimeLine
=============
This is a class to get the information of SNS.



#USAGE

    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
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
    
    }];
    
    RKGetFacebookTimeLine*testFacebook=[[RKGetFacebookTimeLine alloc]init];
    
    NSDictionary*readOnlyOptions=@{
                                   ACFacebookAppIdKey : @"878372405515997",
                                   ACFacebookAudienceKey : ACFacebookAudienceOnlyMe,
                                   ACFacebookPermissionsKey : @[@"email",@"read_stream"]
                                   };
    
    [testFacebook getFacebookTimelineFromServer:readOnlyOptions completion:^(NSArray*resultsArray,NSError*error){
        
        NSLog(@"=======FACEBOOK=======");
        NSLog(@"%lu",(unsigned long)resultsArray.count);
        NSLog(@"%@",error);
    
    }];*

#Warning
There are cases where part of the specification is changed,because since it has not been completed..
