//
//  RendezvousAppDelegate.h
//  Rendezvous
//
//  Created by Aaron Konigsberg on 4/21/12.
//  Copyright (c) 2012 Stanford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "RendezvousCurrentUser.h"
#import "MWPhotoBrowser.h"

@interface RendezvousAppDelegate : NSObject <UIApplicationDelegate, FBSessionDelegate>
{
    Facebook *facebook;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) Facebook *facebook;

@end
