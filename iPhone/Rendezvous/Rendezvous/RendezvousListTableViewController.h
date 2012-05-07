//
//  RendezvousListTableViewController.h
//  Rendezvous
//
//  Created by akonig on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RendezvousCurrentUser.h"

@interface RendezvousListTableViewController : UITableViewController <FBDialogDelegate,FBRequestDelegate>
{
    int checkLoad;
    NSMutableDictionary *listUserInfo;
    NSMutableArray *listIDs;
    NSMutableData *responseData;
    //UIBarButtonItem *addButton;
}

@property (retain, nonatomic) NSMutableData* responseData;
@property (retain, nonatomic) NSMutableArray* listIDs;
@property (retain, nonatomic) NSMutableDictionary* listUserInfo;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;


@end
