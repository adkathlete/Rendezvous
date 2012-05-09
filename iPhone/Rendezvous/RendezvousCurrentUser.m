//
//  CurrentUser.m
//  Rendezvous
//
//  Created by Bryce Kam on 4/29/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#define userDataURL @"http://rendezvous.cs147.org/getUserInfo.php?id="
#define userListURL @"http://rendezvous.cs147.org/getList.php?id="
#import "RendezvousCurrentUser.h"

@implementation RendezvousCurrentUser

static RendezvousCurrentUser *sharedInstance = nil;

@synthesize userId,userInfo,userInfoObjects,userInfoKeys,responseData,userResponseData, visitingId, listIDs, listUserInfo;

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
        checkLoad = 0;
        listUserInfo = [[NSMutableDictionary alloc] init];
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
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[userDataURL stringByAppendingString:userId]]];
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
}

-(void)loadUserList
{
    NSLog(@"loadUserList");
    checkLoad = 2;
	self.responseData = [NSMutableData data];
    NSString *requestString = [@"http://rendezvous.cs147.org/getList.php?id=" stringByAppendingString:[self userId]];
    NSLog(requestString);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark Process loan data
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    if (checkLoad == 1) {
        self.responseData = nil;
        userInfoObjects = [responseString componentsSeparatedByString:@","];
    
        userInfo=[NSMutableDictionary dictionaryWithObjects:userInfoObjects forKeys:userInfoKeys];
        [userInfo setObject:friends forKey:@"friends"];
    
        [self loadUserList];
    } else if (checkLoad == 2) {
        NSLog(@"Checkload is 2");
        NSLog(responseString);
        self.responseData = nil;
        listIDs = [responseString componentsSeparatedByString:@","];
        currentAPICall =  kLoadUserList;
        RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
        
        NSLog(@"sequence = %d",[listIDs count]);
        
        for (NSString *item in listIDs) {
            NSLog(item);
            [[delegate facebook] requestWithGraphPath:item andDelegate:self];
        }
    }
    
}

- (void)request:(FBRequest *)request didLoad:(id)result
{
    switch (currentAPICall) {
        case kLoadUserInformation:
        {
            NSLog(@"Loading User Id");
            userId=[result objectForKey:@"id"];
            
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
            [listUserInfo setObject:[result objectForKey:@"name"] forKey:[result objectForKey:@"id"]];
            if(listIDs.count==listUserInfo.count){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"DataModelComplete" object:nil];
            }
            break;
        }
    }
    
}


@end