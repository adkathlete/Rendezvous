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
    NSMutableData *responseData;
    //UIBarButtonItem *addButton;
    RendezvousCurrentUser *sharedSingleton;
}

@property (retain, nonatomic) NSMutableData* responseData;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;


@end
