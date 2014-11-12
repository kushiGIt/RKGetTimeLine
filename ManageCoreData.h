//
//  ManageCoreData.h
//  RKDataDownloader
//
//  Created by RyousukeKushihata on 2014/11/11.
//  Copyright (c) 2014年 RyousukeKushihata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DataLifeTime.h"

@class ManageCoreData;

@protocol ManageCoreDataDelegate;

@interface ManageCoreData : NSObject<NSURLSessionDelegate>{
    
}

@property id<ManageCoreDataDelegate>delegate;

-(void)setContextData:(NSData*)originalData forKey:(NSString*)keyStr WithObjectLifeTime:(NSDate*)objectLongevityDate ischeckDupulicationInEntity:(BOOL)ischeckDupulication;
-(void)deleteCoreDataObjectInEntity:(NSString *)entityName withKey:(NSString *)keyString;
-(void)deleteEntityData:(NSString *)entityName;
-(NSArray*)getContextInEntity:(NSString *)entityName withKey:(NSString *)keyString;
@end
