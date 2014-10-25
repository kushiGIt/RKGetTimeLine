RKGetTimeLine
=============
This is a class to get the information of SNS.



############USAGE############

RKGetFacebookTimeLine*testFacebook=[[RKGetFacebookTimeLine alloc]init];
    
    [testFacebook getFacebookTimelineFromServer:nil completion:^(NSArray*resultsArray,NSError*error){
    
    //other process.....
    
    }];

############END############

##########Warning##########
There are cases where part of the specification is changed,because since it has not been completed..
