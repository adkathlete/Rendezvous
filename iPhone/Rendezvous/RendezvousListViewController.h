//
//  RendezvousListViewController.h
//  Rendezvous
//
//  Created by Jack Reidy on 5/31/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RendezvousCurrentUser.h"

#define deleteListURL @"http:/www.rendezvousnow.me/deleteList.php?from_id="
#define updatePositionURL @"http://www.rendezvousnow.me/updatePosition.php?from_id="

@interface RendezvousListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,FBDialogDelegate,FBRequestDelegate>
{
    IBOutlet UITableView *listTableView;
    NSMutableData *responseData;
    RendezvousCurrentUser *sharedSingleton;
    IBOutlet UIButton*moveButton;
    UIImageView *slideImageView;
    UIButton *editButton;
    UIButton *addButton;
    BOOL isIn;
    BOOL editing;
}

@property ( nonatomic) NSMutableData* responseData;
@property ( nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (nonatomic) UITableView *listTableView;

@end
