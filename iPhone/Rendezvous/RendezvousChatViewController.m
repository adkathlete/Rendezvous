//
//  RendezvousChatViewController.m
//  Rendezvous
//
//  Created by akonig on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RendezvousChatViewController.h"
#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH 170.0f
#define CELL_CONTENT_MARGIN 10.0f


@interface RendezvousChatViewController ()

@end

@implementation RendezvousChatViewController

@synthesize chatTableView;
@synthesize composeMessageView;
@synthesize messageField;
@synthesize sendMessageButton,responseData;

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
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    NSLog([s visitingMessageId]);
    
    if([[s uniqueMessageUserIDs] containsObject:[s visitingMessageId]])
    {
        [self setTitle:[[s messageUserInfo] objectForKey:[s visitingMessageId]]];
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:([[[s messages] objectForKey:[s visitingMessageId]] count] - 1) inSection:0];
        [[self chatTableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }else{
        [self setTitle:[[s listUserInfo] objectForKey:[s visitingMessageId]]];
    }
    [self registerForKeyboardNotifications];

}

- (void)viewDidUnload
{

    
    [self setChatTableView:nil];
    [self setComposeMessageView:nil];
    [self setMessageField:nil];
    [self setSendMessageButton:nil];
    [super viewDidUnload];

    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect r=[composeMessageView frame];
    r.origin.y=r.origin.y-kbSize.height+self.tabBarController.tabBar.frame.size.height;
    [composeMessageView setFrame:r];
    
    CGRect chatWindow=[chatTableView frame];
    chatWindow.size.height=chatWindow.size.height-kbSize.height+self.tabBarController.tabBar.frame.size.height;
    [chatTableView setFrame:chatWindow];
    
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    if([[s uniqueMessageUserIDs] containsObject:[s visitingMessageId]])
    {
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:([[[s messages] objectForKey:[s visitingMessageId]] count] - 1) inSection:0];
    [[self chatTableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    if([[s uniqueMessageUserIDs] containsObject:[s visitingMessageId]])
    {
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:([[[s messages] objectForKey:[s visitingMessageId]] count] - 1) inSection:0];
    [[self chatTableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    CGRect r=[composeMessageView frame];
    //r.origin.y=self.tabBarController.tabBar.frame.origin.y-self.tabBarController.tabBar.frame.size.height-r.size.height;
    r.origin.y=r.origin.y+kbSize.height-self.tabBarController.tabBar.frame.size.height;
    [composeMessageView setFrame:r];
    
    CGRect chatWindow=[chatTableView frame];
    chatWindow.size.height=[composeMessageView frame].origin.y-chatWindow.origin.y;
    [chatTableView setFrame:chatWindow];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)sendMessage:(id)sender {
    [self textFieldShouldReturn:messageField];
    NSLog(@"Send Message");
    self.responseData = [NSMutableData data];
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    
    //Add Message To Database
    newMessage=[self messageField].text;
    newMessageToID=[s visitingMessageId];
    NSString *urlString = [NSString stringWithFormat:@"http://rendezvousnow.me/addMessage.php?from_id=%@&to_id=%@&message=%@",[s userId],newMessageToID,[newMessage stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    [self messageField].text=nil;
}

#pragma mark - Server Connection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	self.responseData = nil;
    NSLog(@"Network Bad Request");
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Data Error"
                                                      message:@"Network Error. Try sending again later."
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [message show];
}


#pragma mark Process loan data
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];

    NSMutableDictionary *newMessageDictionary=[[NSMutableDictionary alloc] init];
    [newMessageDictionary setValue:newMessage forKey:@"message"];
    [newMessageDictionary setValue:newMessageToID forKey:@"to_id"];
    [newMessageDictionary setValue:[s userId] forKey:@"from_id"];
    
    [[[s messages] objectForKey:[s visitingMessageId]] addObject:newMessageDictionary];
    [chatTableView reloadData];
    
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:([[[s messages] objectForKey:[s visitingMessageId]] count] - 1) inSection:0];
    [[self chatTableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];

    
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    return [[[s messages] objectForKey:[s visitingMessageId]] count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    NSArray *chatMessages=[[s messages] objectForKey:[s visitingMessageId]];
    NSString *text= [[chatMessages objectAtIndex:indexPath.row] objectForKey:@"message"];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 44.0f);
    
    return height + (CELL_CONTENT_MARGIN * 2);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    NSArray *chatMessages=[[s messages] objectForKey:[s visitingMessageId]];
    NSString *mainLabelText= [[chatMessages objectAtIndex:indexPath.row] objectForKey:@"message"];
    
    static NSString *CellIdentifier=nil;
    if([[[chatMessages objectAtIndex:indexPath.row] objectForKey:@"from_id"] isEqualToString:[s userId]])
    {
        CellIdentifier= @"toCellIdentifier";   
    } else {
        CellIdentifier = @"fromCellIdentifier";
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
        
    }
    
    UILabel *label = (UILabel *)[cell viewWithTag:1];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH, 20000.0f);
    
    CGSize size = [mainLabelText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    [label setText:mainLabelText];
    
    if([[[chatMessages objectAtIndex:indexPath.row] objectForKey:@"from_id"] isEqualToString:[s userId]])
    {
        label.textAlignment=UITextAlignmentRight;  
        [label setFrame:CGRectMake(320-CELL_CONTENT_MARGIN-CELL_CONTENT_WIDTH,CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH, MAX(size.height, 44.0f))];  
    } else {
        [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH, MAX(size.height, 44.0f))];
    }
    
    
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
 // Override to support editing the table view.
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
 
@end
