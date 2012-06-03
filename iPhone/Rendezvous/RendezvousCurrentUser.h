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
    kloadProfilePictures,
    kloadMessageUserList
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
    NSArray *_photos;
}

@property (nonatomic, retain) NSMutableString *connectionCheck;
@property (nonatomic, retain) NSMutableDictionary *listUserInfo;
@property (nonatomic, retain) NSMutableArray *listIDs;
@property (nonatomic, retain) NSMutableArray *matchIDs;
@property (nonatomic, retain) NSMutableArray *uniqueMessageUserIDs;
@property (retain, nonatomic) NSMutableData* responseData;
@property (nonatomic, retain) NSMutableDictionary *messages;
@property (nonatomic, retain) NSMutableDictionary *messageUserInfo;
@property (retain, nonatomic) NSArray* userResponseData;
@property (nonatomic, retain) NSString *userId;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSString *first_name;
@property (nonatomic, retain) NSString *last_name;
@property (nonatomic, retain) NSString *visitingId;
@property (nonatomic, retain) NSString *visitingMessageId;
@property (nonatomic,retain) NSMutableDictionary *userInfo;
@property (nonatomic,retain) NSArray *userInfoObjects;
@property (nonatomic,retain) NSArray *userInfoKeys;
@property (retain, nonatomic) NSMutableDictionary *matchInfo;
@property (retain, nonatomic) NSString *matchedUserId;
@property (nonatomic, retain) NSArray *photos;

+ (id)sharedInstance;

@end