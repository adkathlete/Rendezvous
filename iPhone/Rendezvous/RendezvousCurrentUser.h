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


typedef enum apiCall {
    kLoadFriends,
    kLoadUserInformation,
} apiCall;


@interface RendezvousCurrentUser : NSObject <FBDialogDelegate,FBRequestDelegate>
{
    int currentAPICall;
    NSArray *userResponseData;
    NSMutableData *responseData;
    NSMutableArray *friends;
}

@property (retain, nonatomic) NSMutableData* responseData;
@property (retain, nonatomic) NSArray* userResponseData;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *visitingId;
@property(nonatomic,retain) NSMutableDictionary *userInfo;
@property(nonatomic,retain) NSArray *userInfoObjects;
@property(nonatomic,retain) NSArray *userInfoKeys;

+ (id)sharedInstance;

@end