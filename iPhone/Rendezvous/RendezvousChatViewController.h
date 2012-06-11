//
//  RendezvousChatViewController.h
//  Rendezvous
//
//  Created by akonig on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RendezvousCurrentUser.h"


@interface RendezvousChatViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *chatTableView;
    NSString *newMessage;
    NSString *newMessageToID;
}

@property ( nonatomic) IBOutlet UITableView *chatTableView;
@property ( nonatomic) IBOutlet UIView *composeMessageView;
@property ( nonatomic) IBOutlet UITextField *messageField;
@property ( nonatomic) IBOutlet UIButton *sendMessageButton;
@property ( nonatomic) NSMutableData* responseData;
@property ( nonatomic) NSString* currentId;

@end
