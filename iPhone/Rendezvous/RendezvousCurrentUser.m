//
//  CurrentUser.m
//  Rendezvous
//
//  Created by Bryce Kam on 4/29/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#define userDataURL @"http://rendezvousnow.me/getUserInfo.php?id="
#define userListURL @"http://rendezvousnow.me/getList.php?id="
#define checkUserURL @"http://rendezvousnow.me/checkUser.php?id="
#define userMessagesURL @"http://rendezvousnow.me/getMessages.php?id="

#import "RendezvousCurrentUser.h"

@implementation RendezvousCurrentUser

static RendezvousCurrentUser *sharedInstance = nil;

@synthesize userId,userInfo,userInfoObjects,userInfoKeys,responseData,userResponseData, visitingId, visitingMessageId, listIDs, listUserInfo, matchInfo, matchedUserId, gender, first_name, last_name, connectionCheck,messages,uniqueMessageUserIDs,messageUserInfo,matchIDs, backgroundImage;
@synthesize photos = _photos;

// Get the shared instance and create it if necessary.
+ (RendezvousCurrentUser *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{ 
    self = [super init];
    
    if (self) {
        visitingId = @"";
        connectionCheck = @"Good";
        NSLog(@"Connection Check");
        NSLog(connectionCheck);
        backgroundImage = [UIImage imageNamed:@"BlackBackground.png"];
        checkLoad = 0;
        listUserInfo = [[NSMutableDictionary alloc] init];
        messageUserInfo = [[NSMutableDictionary alloc] init];
        matchInfo = [[NSMutableDictionary alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateFriends) name:@"fbLoadingComplete" object:nil];
        currentAPICall=kLoadUserInformation;
        RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
        [[delegate facebook] requestWithGraphPath:@"me" andDelegate:self];
    }
    
    return self;
}

// Your dealloc method will never be called, as the singleton survives for the duration of your app.
// However, I like to include it so I know what memory I'm using (and incase, one day, I convert away from Singleton).
-(void)dealloc
{
    // I'm never called!
}

// We don't want to allocate a new instance, so return the current one.
+ (id)allocWithZone:(NSZone*)zone {
    return [self sharedInstance];
}

// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

-(void)updateFriends
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserData) name:@"fbFriendsComplete" object:nil];
    currentAPICall=kLoadFriends;
    RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:@"me/friends" andDelegate:self];
}

-(void)updateUserData
{
     NSLog(@"updating userData!");
     userInfoKeys=[NSArray arrayWithObjects:@"firstName",@"lastName",@"phone",@"id",@"gender",@"rendezvous?",nil];
    [self loadUserData];
}


#pragma mark - Backend Data Loading

-(void)loadUserData
{
    checkLoad = 1;
	self.responseData = [NSMutableData data];
    
    NSString *string1 = [userDataURL stringByAppendingString: userId];
    NSString *string2 = [string1 stringByAppendingString: @"&first_name="];
    NSString *string3 = [string2 stringByAppendingString: first_name];
    NSString *string4 = [string3 stringByAppendingString: @"&last_name="];
    NSString *string5 = [string4 stringByAppendingString: last_name];
    NSString *string6 = [string5 stringByAppendingString: @"&gender="];
    NSString *string7 = [string6 stringByAppendingString: gender];

    NSLog(string7);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:string7]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	self.responseData = nil;
    NSLog(@"Network Bad Request");
    connectionCheck = @"Bad";
}

-(void)loadUserList
{
    NSLog(@"loadUserList");
    checkLoad = 2;
	self.responseData = [NSMutableData data];
    NSString *requestString = [@"http://www.rendezvousnow.me/getList.php?id=" stringByAppendingString:[self userId]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    NSLog(requestString);
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)loadMatch
{
    NSLog(@"loadMatches");
    NSLog(connectionCheck);
    checkLoad = 3;
    self.responseData = [NSMutableData data];
    NSString *urlString = [@"http://rendezvousnow.me/getOldMatches.php?id=" stringByAppendingString:userId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)loadMessages
{
    NSLog(@"loadMessages");
    NSLog(connectionCheck);
    checkLoad = 4;
    self.responseData = [NSMutableData data];
    NSString *urlString = [@"http://rendezvousnow.me/getMessages.php?id=" stringByAppendingString:userId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
#pragma mark fix check for bad requests!
    NSLog(@"Facebook Bad Request");
    connectionCheck = @"Bad";
}


#pragma mark Process loan data
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    if (checkLoad == 1) {
        NSString *responseString1 = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(responseString1);
        self.responseData = nil;
        userInfoObjects = [responseString1 componentsSeparatedByString:@","];
        userInfo=[NSMutableDictionary dictionaryWithObjects:userInfoObjects forKeys:userInfoKeys];
        [userInfo setObject:friends forKey:@"friends"];
        [self loadMatch];
    } else if (checkLoad == 2) {
        NSLog(@"checkLoad is 2");
        NSString *responseString2 = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(responseString2);
        self.responseData = nil;

        listIDs = [[NSMutableArray alloc] init];
        currentAPICall =  kLoadUserList;
        
        SBJsonParser* parser = [[SBJsonParser alloc] init];
        NSArray *arr = [parser objectWithString:responseString2];
        
        for (NSDictionary* dict in arr) {
            [listIDs addObject:[dict objectForKey:@"to_id"]];
            NSLog(@"HERE");
            NSLog([dict objectForKey:@"to_id"]);
        }

        RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
        if([listIDs count]!=0){
            for (NSString *item in listIDs) {
                NSLog(@"apicalls");
                [[delegate facebook] requestWithGraphPath:item andDelegate:self];
            }
        }else {
            currentAPICall=kloadUserAlbums;
            RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
            NSString *path=[NSString stringWithFormat:@"%@/albums",userId];
            [[delegate facebook] requestWithGraphPath:path andDelegate:self];
        } 
    } else if (checkLoad == 3) {
        NSLog(@"checkLoad is 3");
        NSString *responseString3 = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(responseString3);
        self.responseData = nil;
        matchIDs = [[NSMutableArray alloc] init];
        
        SBJsonParser* parser = [[SBJsonParser alloc] init];
        NSArray *arr = [parser objectWithString:responseString3];
        
        for (NSDictionary* dict in arr) {
            [matchIDs addObject:[dict objectForKey:@"to_id"]];
            NSLog(@"HERE");
            NSLog([dict objectForKey:@"to_id"]);
        }
        
        for (NSString *userID in matchIDs){
            NSLog(userID);
        }
        
        
        if ([matchIDs count] == 0)
        {
            matchName = nil;
            [self loadUserList];
        }
        else
        {
            matchedUserId = [matchIDs objectAtIndex:0];
            for (NSString *user in matchIDs)
            {
                [self getFacebookName:user];
            }
        }
    } else if (checkLoad==4)
    {
        NSLog(@"checkLoad is 4");
        NSString *responseString4 = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        //NSLog(responseString4);
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        NSMutableArray *messageData=[parser objectWithString:responseString4];
        uniqueMessageUserIDs=[[NSMutableArray alloc] init];

        for (NSDictionary *message in messageData)
        {
            
            //NSLog([message objectForKey:@"message"]);
            if((![uniqueMessageUserIDs containsObject:[message objectForKey:@"from_id"]]) && ![userId isEqualToString:[message objectForKey:@"from_id"]])
            {
                [uniqueMessageUserIDs addObject:[message objectForKey:@"from_id"]];
                
            } else if((![uniqueMessageUserIDs containsObject:[message objectForKey:@"to_id"]]) && ![userId isEqualToString:[message objectForKey:@"to_id"]])
            {
                [uniqueMessageUserIDs addObject:[message objectForKey:@"to_id"]];   
            }
            
        }
    
        messages=[[NSMutableDictionary alloc] init];
        currentAPICall =  kloadMessageUserList;
        RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
        for (NSString *messageId in uniqueMessageUserIDs)
        {
            NSMutableArray *userMessages=[[NSMutableArray alloc] init];
            for (NSDictionary *message in messageData)
            {
                if ([messageId isEqualToString:[message objectForKey:@"from_id"]] || [messageId isEqualToString:[message objectForKey:@"to_id"]]) {
                    [userMessages addObject:message];
                }

            }
            
            [messages setObject:userMessages forKey:messageId];
            
        }
        
        if([uniqueMessageUserIDs count]!=0){
            for (NSString *item in uniqueMessageUserIDs) {
                NSLog(@"MessageAPIcalls");
                [[delegate facebook] requestWithGraphPath:item andDelegate:self];
            }
        }else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DataModelComplete" object:nil];
        }
        
    }
}

- (void) getFacebookName: (NSString *) userID {
    currentAPICall = kLoadMatchName;
    RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:userID andDelegate:self]; 
}

- (void)request:(FBRequest *)request didLoad:(id)result
{
    switch (currentAPICall) {
        case kLoadUserInformation:
        {
            NSLog(@"Loading User Id");
            userId=[result objectForKey:@"id"];
            first_name = [result objectForKey:@"first_name"];
            last_name = [result objectForKey:@"last_name"];
            gender = [result objectForKey:@"gender"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"fbLoadingComplete" object:nil];
            break;
        }
        case kLoadFriends:
        {
            NSLog(@"Loading Friends");
            friends = [[NSMutableArray alloc] initWithCapacity:1];
            NSArray *resultData = [result objectForKey:@"data"];
            if ([resultData count] > 0) {
                for (NSUInteger i=0; i<[resultData count]; i++) {
                    [friends addObject:[resultData objectAtIndex:i]];
                }
            }
            
            NSLog(@"Friends Done!");

            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"fbFriendsComplete" object:nil];
            break;
        }
        case kLoadUserList:
        {
            NSLog(@"kloading");
            [listUserInfo setObject:[result objectForKey:@"name"] forKey:[result objectForKey:@"id"]];
            if(listIDs.count==listUserInfo.count){
                NSLog(@"kLoadUserList");
                currentAPICall=kloadUserAlbums;
                RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
                NSString *path=[NSString stringWithFormat:@"%@/albums",userId];
                [[delegate facebook] requestWithGraphPath:path andDelegate:self];
            }
            break;
        }
        case kLoadMatchName:
        {
            NSLog(@"Loading Match Name");
            NSLog(@"Match: %@, ID:%@",[result objectForKey:@"name"],[result objectForKey:@"id"]);
            [matchInfo setObject:[result objectForKey:@"name"] forKey:[result objectForKey:@"id"]];
            NSLog(@"ID Count:%d, Info Count: %d",matchIDs.count,matchInfo.count);
            if(matchIDs.count==matchInfo.count){
                [self loadUserList];
            }
            
            break;
        }
        case kloadUserAlbums:
        {
            NSLog(@"Facebook request %@ loaded", [request url]);
            NSArray *resultData = [result objectForKey:@"data"];
            for (NSDictionary *album in resultData) {
                NSLog([album   objectForKey:@"name"]);
                
                if([@"Profile Pictures" compare:[album objectForKey:@"name"]] ==NSOrderedSame)
                {
                    NSLog(@"Matched Album");
                    currentAPICall=kloadProfilePictures;
                    RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
                    NSString *path=[NSString stringWithFormat:@"%@/photos",[album objectForKey:@"id"]];
                    [[delegate facebook] requestWithGraphPath:path andDelegate:self];
                }
                
            }
            
            break;

        }
        case kloadProfilePictures:
        {
            NSLog(@"Facebook request %@ loaded", [request url]);
            NSArray *resultData = [result objectForKey:@"data"];
            
            NSLog(@"Loading Photos");
            // Create browser
            NSMutableArray *photos = [[NSMutableArray alloc] init];
            
            for (NSDictionary *photo in resultData) {
                [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[photo objectForKey:@"source"]]]];
            }
            
            NSLog(@"done Adding Photos");
            
            self.photos = photos;
            
            [self loadMessages];
            //[[NSNotificationCenter defaultCenter] postNotificationName:@"UserPhotosLoaded" object:nil];
            break;

        }
        case kloadMessageUserList:
        {
            NSLog(@"kloading Message User Info");
            NSLog([result objectForKey:@"name"]);
            [messageUserInfo setObject:[result objectForKey:@"name"] forKey:[result objectForKey:@"id"]];
            NSLog(@"%d",uniqueMessageUserIDs.count);
            NSLog(@"%d",messageUserInfo.count);
#pragma mark FIX COUNT BELOW WORK AROUND FOR ERROR
            
            if(uniqueMessageUserIDs.count==(messageUserInfo.count)){
                            NSLog(@"Matched User: %@",[matchInfo objectForKey:matchedUserId]);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"DataModelComplete" object:nil];
            }
            break;
        }

    }
    
}


@end