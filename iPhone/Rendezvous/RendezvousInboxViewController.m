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
@synthesize responseData;

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
    RendezvousCurrentUser *star = [RendezvousCurrentUser sharedInstance];
    if ([star.shouldSegueMessages isEqualToString:@"Yes"]) {
        [self performSegueWithIdentifier:@"seguingFromMatch" sender: self];
    }
    
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 640, 640/11)];
    [label setFont:[UIFont fontWithName:@"Verdana-Bold" size:27.0]];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1.0];
    label.shadowColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1.0];
    label.shadowOffset = CGSizeMake(0, 1.3);
    label.text = @"MY INBOX";
    self.navigationItem.titleView = label;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    [self.navigationController setNavigationBarHidden: YES animated:YES];

    UINavigationBar *NavBar = [[self navigationController] navigationBar];
    UIImage *back = [UIImage imageNamed:@"BarFinal2.png"];
    [NavBar setBackgroundImage:back forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stripeBack.png"]];
    
    
    pull = [[PullToRefreshView alloc] initWithScrollView:(UIScrollView *) self.inboxTableView];
    [pull setDelegate:self];
    [self.inboxTableView addSubview:pull];
    
//    UIImage *frameImage = [UIImage imageNamed:@"photoBrowserBackground4.png"];
//    UIImageView *frameView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -92)];
//    frameView.image = frameImage;
//    [self.view addSubview:frameView];
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


- (void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view;
{
    [self performSelectorInBackground:@selector(reloadTableData) withObject:nil];
}


-(void) reloadTableData
{
    
    [self.inboxTableView reloadData];
    [pull finishedLoading];

}

#pragma mark Reload Message Data
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
    NSLog(@"Recieved Response");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"Appending Data");
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	self.responseData = nil;
    NSLog(@"Network Bad Request");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
        RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
        NSLog(@"Reload Message Data");
        NSString *responseString4 = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        //NSLog(responseString4);
        SBJsonParser *parser=[[SBJsonParser alloc] init];
        NSMutableArray *messageData=[parser objectWithString:responseString4];
        
        for (NSDictionary *message in messageData)
        {
            
            //NSLog([message objectForKey:@"message"]);
            if((![[s uniqueMessageUserIDs] containsObject:[message objectForKey:@"from_id"]]) && ![[s userId] isEqualToString:[message objectForKey:@"from_id"]])
            {
                [[s uniqueMessageUserIDs] addObject:[message objectForKey:@"from_id"]];
                
            } else if((![[s uniqueMessageUserIDs] containsObject:[message objectForKey:@"to_id"]]) && ![[s userId] isEqualToString:[message objectForKey:@"to_id"]])
            {
                [[s uniqueMessageUserIDs] addObject:[message objectForKey:@"to_id"]];   
            }
            
        }
        
        for (NSString *messageId in [s uniqueMessageUserIDs])
        {
            NSMutableArray *userMessages=[[NSMutableArray alloc] init];
            for (NSDictionary *message in messageData)
            {
                if ([messageId isEqualToString:[message objectForKey:@"from_id"]] || [messageId isEqualToString:[message objectForKey:@"to_id"]]) {
                    [userMessages addObject:message];
                }
                
            }
            
            [[s messages] setObject:userMessages forKey:messageId];
            
        }
    
    [self.inboxTableView reloadData];
    [pull finishedLoading];
        
        
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    tableView.backgroundColor = [UIColor clearColor];
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
    UIImage *background = [UIImage imageNamed:@"cellBackgroundUpdatedDark.png"];
    //    UIImage *backgroundSelected = [UIImage imageNamed:@"cellBackgroundSelected.png"];
    cell.backgroundView = [[UIImageView alloc] initWithImage:background];
    // Get the cell label using its tag and set it
    //UILabel *mainCellLabel = (UILabel *)[cell viewWithTag:2];
    NSString *mainLabelText= [[s messageUserInfo] objectForKey:[[s uniqueMessageUserIDs] objectAtIndex:indexPath.row]];
    [cell.textLabel setText:mainLabelText];
    [cell.textLabel setTextColor:[UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1.0]];
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    //UILabel *subCellLabel = (UILabel *)[cell viewWithTag:3];
    NSArray *chatMessages=[s.messages objectForKey:[[s uniqueMessageUserIDs] objectAtIndex:indexPath.row]];
    NSString *subLabelText= [[[s.messages objectForKey:[[s uniqueMessageUserIDs] objectAtIndex:indexPath.row]] objectAtIndex:0] objectForKey:@"message"];
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
