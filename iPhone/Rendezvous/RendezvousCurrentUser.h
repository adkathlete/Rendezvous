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

@property (nonatomic) NSMutableString *connectionCheck;
@property (nonatomic) NSMutableDictionary *listUserInfo;
@property (nonatomic) NSMutableArray *listIDs;
@property (nonatomic) NSMutableArray *matchIDs;
@property (nonatomic) NSMutableArray *uniqueMessageUserIDs;
@property ( nonatomic) NSMutableData* responseData;
@property (nonatomic) NSMutableDictionary *messages;
@property (nonatomic) NSMutableDictionary *messageUserInfo;
@property ( nonatomic) NSArray* userResponseData;
@property (nonatomic) NSString *token;
@property (nonatomic) NSString *userId;
@property (nonatomic) NSString *gender;
@property (nonatomic) NSString *first_name;
@property (nonatomic) NSString *last_name;
@property (nonatomic) NSString *visitingId;
@property (nonatomic) NSString *visitingMessageId;
@property (nonatomic) NSMutableDictionary *userInfo;
@property (nonatomic) NSArray *userInfoObjects;
@property (nonatomic) NSArray *userInfoKeys;
@property ( nonatomic) NSMutableDictionary *matchInfo;
@property ( nonatomic) NSString *matchedUserId;
@property (nonatomic) NSArray *photos;
@property (nonatomic) UIImage *backgroundImage;
@property (nonatomic) NSString *shouldSegueMessages;

+ (id)sharedInstance;

@end