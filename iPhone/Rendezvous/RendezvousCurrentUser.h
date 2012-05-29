//
//  CurrentUser.h
//  Rendezvous
//
//  Created by Bryce Kam on 4/29/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//



#import "JSON.h"
#import "SBJsonParser.h"
#import <Foundation/Foundation.h>
#import "RendezvousAppDelegate.h"



typedef enum apiCall {
    kLoadFriends,
    kLoadUserInformation,
    kLoadUserList,
    kLoadMatchName,
    kloadUserAlbums,
    kloadProfilePictures
} apiCall;


@interface RendezvousCurrentUser : NSObject <FBDialogDelegate,FBRequestDelegate>
{
    int currentAPICall;
    NSArray *userResponseData;
    NSMutableData *responseData;
    NSMutableArray *friends;
    NSMutableDictionary *listUserInfo;
    NSMutableArray *listIDs;
    NSString *matchName;
    NSString *matchedUserId;
    int checkLoad;
    NSMutableString *connectionCheck;
}

@property (nonatomic, retain) NSMutableString *connectionCheck;
@property (nonatomic, retain) NSMutableDictionary *listUserInfo;
@property (nonatomic, retain) NSMutableArray *listIDs;
@property (retain, nonatomic) NSMutableData* responseData;
@property (retain, nonatomic) NSArray* userResponseData;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSString *first_name;
@property (nonatomic, retain) NSString *last_name;
@property (nonatomic, retain) NSString *visitingId;
@property (nonatomic,retain) NSMutableDictionary *userInfo;
@property (nonatomic,retain) NSArray *userInfoObjects;
@property (nonatomic,retain) NSArray *userInfoKeys;
@property (retain, nonatomic) NSString *matchName;
@property (retain, nonatomic) NSString *matchedUserId;

+ (id)sharedInstance;

@end