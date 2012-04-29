//
//  RendezvousListTableViewController.h
//  Rendezvous
//
//  Created by akonig on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RendezvousListTableViewController : UITableViewController
{
    NSMutableArray *myData;
    NSArray *listData;
    NSMutableData *responseData;
}

@property (retain, nonatomic) NSMutableData* responseData;

@property (retain, nonatomic) NSArray* listData;


@end
