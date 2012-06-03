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
    //UIBarButtonItem *addButton;
    RendezvousCurrentUser *sharedSingleton;
    IBOutlet UIButton*moveButton;
    UIImageView *slideImageView;
    BOOL isIn;
}

@property (retain, nonatomic) NSMutableData* responseData;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (retain,nonatomic) UITableView *listTableView;

@end
