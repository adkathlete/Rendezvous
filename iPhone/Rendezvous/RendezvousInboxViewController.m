//
//  RendezvousInboxViewController.m
//  Rendezvous
//
//  Created by akonig on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RendezvousInboxViewController.h"

@interface RendezvousInboxViewController ()

@end

@implementation RendezvousInboxViewController

@synthesize inboxTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    [self.navigationController setNavigationBarHidden: YES animated:YES];

    UINavigationBar *NavBar = [[self navigationController] navigationBar];
    UIImage *back = [UIImage imageNamed:@"BarFinal.png"];
    [NavBar setBackgroundImage:back forBarMetrics:UIBarMetricsDefault];
    
    UIImage *frameImage = [UIImage imageNamed:@"photoBrowserBackground4.png"];
    UIImageView *frameView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -92)];
    frameView.image = frameImage;
    [self.view addSubview:frameView];
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    self.view.backgroundColor = [UIColor colorWithPatternImage:s.backgroundImage];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    tableView.backgroundColor = [UIColor blackColor];
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Return the number of rows in the section.
    RendezvousCurrentUser *sharedSingleton=[RendezvousCurrentUser sharedInstance];
    return sharedSingleton.uniqueMessageUserIDs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UserMessageCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UIImage *background = [UIImage imageNamed:@"cellBackgroundUpdated.png"];
    //    UIImage *backgroundSelected = [UIImage imageNamed:@"cellBackgroundSelected.png"];
    cell.backgroundView = [[UIImageView alloc] initWithImage:background];
    // Get the cell label using its tag and set it
    //UILabel *mainCellLabel = (UILabel *)[cell viewWithTag:2];
    NSString *mainLabelText= [[s messageUserInfo] objectForKey:[[s uniqueMessageUserIDs] objectAtIndex:indexPath.row]];
    [cell.textLabel setText:mainLabelText];
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    //UILabel *subCellLabel = (UILabel *)[cell viewWithTag:3];
    NSArray *chatMessages=[s.messages objectForKey:[[s uniqueMessageUserIDs] objectAtIndex:indexPath.row]];
    NSString *subLabelText= [[[s.messages objectForKey:[[s uniqueMessageUserIDs] objectAtIndex:indexPath.row]] objectAtIndex:[chatMessages count]-1] objectForKey:@"message"];
    [cell.detailTextLabel setText:subLabelText];
     [[cell detailTextLabel] setBackgroundColor:[UIColor clearColor]];
    
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (UIImage *)imageForObject:(NSString *)objectID {
    // Get the object image
    NSString *url = [[NSString alloc] initWithFormat:@"https://graph.facebook.com/%@/picture",objectID];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    return image;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    s.visitingMessageId=[s.uniqueMessageUserIDs objectAtIndex:indexPath.row];
    NSLog(s.visitingMessageId);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"chat" sender: self];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
