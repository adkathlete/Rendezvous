//
//  RendezvousInboxViewController.h
//  Rendezvous
//
//  Created by akonig on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RendezvousCurrentUser.h"

@interface RendezvousInboxViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *inboxTableView;
}

@property (retain, nonatomic) IBOutlet UITableView *inboxTableView;
@property (retain, nonatomic) NSMutableData* responseData;

@end
