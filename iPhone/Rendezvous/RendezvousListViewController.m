//
//  RendezvousListViewController.m
//  Rendezvous
//
//  Created by Jack Reidy on 5/31/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import "RendezvousListViewController.h"

@interface RendezvousListViewController ()

@end

@implementation RendezvousListViewController

@synthesize listTableView;
@synthesize responseData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
}

- (void)viewDidLoad
{
    
    isIn = true;
    editing=false;
    UINavigationBar *NavBar = [[self navigationController] navigationBar];
    UIImage *back = [UIImage imageNamed:@"BarFinal.png"];
    [NavBar setBackgroundImage:back forBarMetrics:UIBarMetricsDefault];
    
    sharedSingleton = [RendezvousCurrentUser sharedInstance];
    [super viewDidLoad];
    
    UIImage *selectedImage0 = [UIImage imageNamed:@"list.png"];
    UIImage *unselectedImage0 = [UIImage imageNamed:@"list.png"];
    
    UIImage *selectedImage1 = [UIImage imageNamed:@"heart.png"];
    UIImage *unselectedImage1 = [UIImage imageNamed:@"heart.png"];
    
    UIImage *selectedImage2 = [UIImage imageNamed:@"messageIcon2.png"];
    UIImage *unselectedImage2 = [UIImage imageNamed:@"messageIcon2.png"];
    
    UITabBar *tabBar = self.tabBarController.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    
    [item0 setFinishedSelectedImage:selectedImage0 withFinishedUnselectedImage:unselectedImage0];
    [item1 setFinishedSelectedImage:selectedImage1 withFinishedUnselectedImage:unselectedImage1];
    [item2 setFinishedSelectedImage:selectedImage2 withFinishedUnselectedImage:unselectedImage2];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.listTableView.rowHeight = 70;
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stripeBack.png"]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stripeBack.png"]];
    self.listTableView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 640, 640/11)];
    [label setFont:[UIFont fontWithName:@"Verdana-Bold" size:27.0]];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1.0];
    label.shadowColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1.0];
    label.shadowOffset = CGSizeMake(0, 1.3);
    label.text = @"MY LIST";
    self.navigationItem.titleView = label;
    
    UIImage *frameImage = [UIImage imageNamed:@"photoBrowserBackground4.png"];
    UIImageView *frameView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 92)];
    frameView.image = frameImage;
    [self.view addSubview:frameView];
    
//    UIImage *slideImage = [UIImage imageNamed:@"timeMove.png"];
//    slideImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, slideImage.size.width, slideImage.size.height)];
//    slideImageView.image = slideImage;
//    [self.view addSubview:slideImageView];
//    NSLog(@"%f", slideImage.size.width);
//    slideImageView.center = CGPointMake(self.view.frame.size.width + slideImage.size.width/2 -30, 35);
//    
//    moveButton =  [UIButton buttonWithType:UIButtonTypeCustom];
//    [moveButton setImage:[UIImage imageNamed:@"clock.png"] forState:UIControlStateNormal];
//    [moveButton addTarget:self action:@selector(ButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [moveButton setFrame:CGRectMake(10, 285, 60, 60)];
//    [moveButton setCenter:CGPointMake(self.view.frame.size.width - 13, 20)];
//    [self.view addSubview:moveButton];
//    
//    
//    UIButton *addButton =  [UIButton buttonWithType:UIButtonTypeCustom];
//    [addButton setImage:[UIImage imageNamed:@"clock.png"] forState:UIControlStateNormal];
//    [addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
//    [addButton setFrame:CGRectMake(10, 10, 60, 60)];
//    [addButton setCenter:CGPointMake(self.view.frame.size.width - 13, 200)];
//    [self.view addSubview:addButton];
    
    editButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [editButton setImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(toggleEdit) forControlEvents:UIControlEventTouchUpInside];
    [editButton setFrame:CGRectMake(0, 0, 60, 60)];
    [editButton setCenter:CGPointMake(self.view.frame.size.width - 13, 10)];
//    [self.view addSubview:editButton];
    
    UIBarButtonItem *editButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editButton];
    self.navigationItem.leftBarButtonItem = editButtonItem;
//    self.navigationItem.leftBarButtonItem.width = 100;
    
    addButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [addButton setFrame:CGRectMake(0, 0, 60, 60)];
    [addButton setCenter:CGPointMake(self.view.frame.size.width - 13, 10)];
//    [self.view addSubview:addButton];
    
    UIBarButtonItem * addButtonItem= [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.rightBarButtonItem = addButtonItem;
    
    
    
//    self.navigationItem.rightBarButtonItems =[NSArray arrayWithObjects:editButtonItem, addButtonItem, nil];
    
    
    
//    self.navigationItem.leftBarButtonItem=self.editButtonItem;
    
//    UIButton *bb = [UIButton buttonWithType:UIButtonTypeCustom];
//    [bb addTarget:self action:@selector(setEditing:) forControlEvents:UIControlEventTouchUpInside];
//    [bb setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
//    [bb setFrame:CGRectMake(0, 0, 50, 50)];
//    [self.view addSubview:bb];
    
//    [self.navigationController setNavigationBarHidden: YES animated:YES];
    
}

//-(IBAction)ButtonPressed:(id)sender
//{
//    //    UIButton *extendButton = (UIButton *) sender;
//    if (isIn) {
//        isIn = false;
//        slideImageView.center = CGPointMake(self.view.frame.size.width + 185/2 -160, 35);
//        [moveButton setCenter:CGPointMake(self.view.frame.size.width - 140, 20)];
//        //        [extendButton setCenter:CGPointMake(40, 285)];
//    } else {
//        isIn = true;
//        slideImageView.center = CGPointMake(self.view.frame.size.width + 185/2 -30, 35);
//        [moveButton setCenter:CGPointMake(self.view.frame.size.width - 13, 20)];
//        //        [extendButton setCenter:CGPointMake(5, 285)];
//    }
//    
//}
//
//
//
//
-(void) add {
    [self performSegueWithIdentifier:@"add" sender: self];
}

//-(IBAction)setEditing:(id)sender
//{
//    NSLog(@"set editing!");
//    
//}

//-(void) setEditing:(BOOL)editing animated:(BOOL)animated
//{
//    
//    [super setEditing:editing animated:animated];
//    if(editing)
//    {
//        [self.listTableView setEditing:YES animated:animated];
//        self.navigationItem.rightBarButtonItem.enabled=FALSE;
//    }else {
//        self.navigationItem.rightBarButtonItem.enabled=TRUE;
//        [self.listTableView setEditing:NO animated:animated];
//
//    }
//    
//}

-(void) toggleEdit
{
    if(self.editing)
    {
        self.editing=false;
        [editButton setImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
        [self.listTableView setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem.enabled=TRUE;
    }else {
        self.editing=true;
        [editButton setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
//        self.navigationItem.rightBarButtonItem.enabled=FALSE;
        [self.listTableView setEditing:YES animated:YES];
        
    }
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIImage *)imageForObject:(NSString *)objectID {
    // Get the object image
    NSString *url = [[NSString alloc] initWithFormat:@"https://graph.facebook.com/%@/picture",objectID];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    return image;
}

#pragma mark - Add New


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    tableView.rowHeight = 38;
    tableView.separatorStyle = NO;
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    return [[s listIDs] count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    
    static NSString *CellIdentifier = @"ListCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    
    UIImage *background = [UIImage imageNamed:@"cellBackgroundUpdatedDark.png"];
//    UIImage *backgroundSelected = [UIImage imageNamed:@"cellBackgroundSelected.png"];
    cell.backgroundView = [[UIImageView alloc] initWithImage:background];
//    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:backgroundSelected];
    
    // Get the cell label using its tag and set it
  
    NSString *listNumer; 
    if (indexPath.row == 9) {
        listNumer=[[NSString alloc] initWithFormat:@"%d",indexPath.row+1];
    } else {
        listNumer=[[NSString alloc] initWithFormat:@"  %d",indexPath.row+1];
    }
    NSString *spacer = [[@" " stringByAppendingString: listNumer] stringByAppendingString:@"        "];
    NSString *labelText= [spacer stringByAppendingString: [[s listUserInfo] objectForKey:[[s listIDs] objectAtIndex:indexPath.row]]];
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 3, 30, 30)];
    numberLabel.text = listNumer;
    [numberLabel setBackgroundColor:[UIColor clearColor]];
    numberLabel.tag = 1;
    //[cell.contentView addSubview: numberLabel];
    [cell.textLabel setText:labelText];
    [[cell textLabel] setTextColor:[UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1.0]];
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    
    
    // The object's image
//    cell.imageView.image = [self imageForObject:[[s listIDs] objectAtIndex:indexPath.row]];
    
    
    return cell;
}

#pragma mark - Backend Data Loading

-(void) updateTableInfo{
    NSLog(@"Time To Update!");
    [self.listTableView reloadData];
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NSString *deleteString1 = [deleteListURL stringByAppendingString:([sharedSingleton userId])];
        NSString *deleteString2 = [deleteString1 stringByAppendingString:(@"&to_id=")];
        NSString *deleteString3 = [deleteString2 stringByAppendingString:([[sharedSingleton listIDs] objectAtIndex:indexPath.row])];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:([NSURL URLWithString:deleteString3])];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        NSLog(deleteString3);
        [[sharedSingleton listIDs] removeObjectAtIndex:indexPath.row];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

        
        //[listUserInfo removeObjectForKey:[listIDs objectAtIndex:indexPath.row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [listTableView reloadData];        
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSString *temp1 = [[sharedSingleton listIDs] objectAtIndex:fromIndexPath.row];
    [[sharedSingleton listIDs] removeObjectAtIndex:fromIndexPath.row];
    [[sharedSingleton listIDs] insertObject:temp1 atIndex:toIndexPath.row];
    
    int position = 1;
    for (NSString *item in [sharedSingleton listIDs]) {
        NSString *updateString1 = [updatePositionURL stringByAppendingString:([sharedSingleton userId])];
        NSString *updateString2 = [updateString1 stringByAppendingString:(@"&to_id=")];
        NSString *updateString3 = [updateString2 stringByAppendingString: item];
        NSString *updateString4 = [updateString3 stringByAppendingString:(@"&position=")];
        NSString *pos = [NSString stringWithFormat:@"%d", position];
        NSString *updateString5 = [updateString4 stringByAppendingString: pos];
        NSLog(updateString5);
        NSURLRequest *request = [NSURLRequest requestWithURL:([NSURL URLWithString:updateString5])];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
        position++;
    }
    
    [listTableView reloadData];
}


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    NSLog(@"LIST");
    sharedSingleton.visitingId = [[sharedSingleton listIDs] objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"listToDetailPage" sender: self];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"loadingUserPage" object:nil];
    
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


@end