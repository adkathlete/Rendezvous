//
//  CurrentUser.h
//  Rendezvous
//
//  Created by Bryce Kam on 4/29/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//



#import "JSON.h"
#import <Foundation/Foundation.h>
#import "RendezvousAppDelegate.h"


@interface RendezvousCurrentUser : NSObject <FBDialogDelegate,FBRequestDelegate>
{
NSArray *userResponseData;
NSMutableData *responseData;
}

@property (retain, nonatomic) NSMutableData* responseData;
@property (retain, nonatomic) NSArray* userResponseData;
@property (nonatomic, retain) NSString *userId;
@property(nonatomic,retain) NSDictionary *userInfo;
@property(nonatomic,retain) NSArray *userInfoObjects;
@property(nonatomic,retain) NSArray *userInfoKeys;

+ (id)sharedInstance;

@end