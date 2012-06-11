//
//  RendezvousInboxViewController.h
//  Rendezvous
//
//  Created by akonig on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RendezvousCurrentUser.h"
#import "PullToRefreshView.h"
#import "JSON.h"
#import "SBJsonParser.h"

@interface RendezvousInboxViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *inboxTableView;
    NSMutableData *responseData;
    PullToRefreshView *pull;
}

@property ( nonatomic) IBOutlet UITableView *inboxTableView;
@property ( nonatomic) NSMutableData* responseData;

@end
