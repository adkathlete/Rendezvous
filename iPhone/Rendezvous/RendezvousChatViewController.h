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

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *hideKeyboard;
@property (retain, nonatomic) IBOutlet UITableView *chatTableView;
@property (retain, nonatomic) IBOutlet UIView *composeMessageView;
@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UIButton *sendMessageButton;
@property (retain, nonatomic) NSMutableData* responseData;
@property (retain, nonatomic) NSString* currentId;

@end
