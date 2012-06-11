//
//  RendezvousChatViewController.m
//  Rendezvous
//
//  Created by akonig on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RendezvousChatViewController.h"
#import <QuartzCore/QuartzCore.h>
#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH 170.0f
#define CELL_CONTENT_MARGIN 10.0f


@interface RendezvousChatViewController ()

@end

@implementation RendezvousChatViewController

@synthesize hideKeyboard;
@synthesize chatTableView;
@synthesize composeMessageView;
@synthesize messageField;
@synthesize sendMessageButton,responseData;
@synthesize currentId;

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
    currentId = [s visitingMessageId];
    newMessageToID=[s visitingMessageId];
    NSLog(newMessageToID);
    

    [sendMessageButton setTitle:@"send" forState:UIControlStateNormal];
//    [sendMessageButton setTitleColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0] forState:UIControlStateNormal];
//    sendMessageButton.layer.borderWidth = 2;
//    sendMessageButton.layer.cornerRadius = 5;
//    sendMessageButton.layer.borderColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0].CGColor;
//    sendMessageButton.tintColor = [UIColor blackColor];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"stripeBack.png"]]];
//    UIImage *frameImage = [UIImage imageNamed:@"photoBrowserBackground5.png"];
//    UIImageView *frameView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -92)];
//    frameView.image = frameImage;
//    [self.view addSubview:frameView];
    [chatTableView setBackgroundColor:[UIColor clearColor]];
    if([[s uniqueMessageUserIDs] containsObject:newMessageToID])
    {
        [self setTitle:[[s messageUserInfo] objectForKey:newMessageToID]];
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:([[[s messages] objectForKey:newMessageToID] count] - 1) inSection:0];
        [[self chatTableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }else{
        [self setTitle:[[s listUserInfo] objectForKey:newMessageToID]];
    }
    [self registerForKeyboardNotifications];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIColor clearColor],UITextAttributeTextColor,[UIColor clearColor], 
      UITextAttributeTextShadowColor, nil] forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIColor clearColor],UITextAttributeTextColor,[UIColor clearColor], 
      UITextAttributeTextShadowColor, nil] forState:UIControlStateHighlighted];
    
    UIImage *buttonBack = [[UIImage imageNamed:@"backButton2.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,5,0,5)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack
                                                      forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

}

- (void)viewDidUnload
{

    
    [self setChatTableView:nil];
    [self setComposeMessageView:nil];
    [self setMessageField:nil];
    [self setSendMessageButton:nil];
    [self setHideKeyboard:nil];
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

- (IBAction)hideKeyboard:(id)sender {
    [sender resignFirstResponder];
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
    if([[s uniqueMessageUserIDs] containsObject:newMessageToID])
    {
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:([[[s messages] objectForKey:newMessageToID] count] - 1) inSection:0];
    [[self chatTableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    if([[s uniqueMessageUserIDs] containsObject:newMessageToID])
    {
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:([[[s messages] objectForKey:newMessageToID] count] - 1) inSection:0];
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
    if([@"" compare:[self messageField].text]!=NSOrderedSame){
        [self textFieldShouldReturn:messageField];
        NSLog(@"Send Message");
        self.responseData = [NSMutableData data];
        RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
        
        //Add Message To Database
        newMessage=[self messageField].text;
        NSString *urlString = [NSString stringWithFormat:@"http://rendezvousnow.me/addMessage.php?from_id=%@&to_id=%@&message=%@",[s userId],newMessageToID,[newMessage stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
        [self messageField].text=nil;
    }
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
    
    if(![[s uniqueMessageUserIDs] containsObject:newMessageToID])
    {
        [[s uniqueMessageUserIDs] insertObject:newMessageToID atIndex:0];
        [[s messageUserInfo] setObject:[[s listUserInfo] objectForKey:newMessageToID] forKey:newMessageToID]; 
        NSMutableArray *newChat=[[NSMutableArray alloc] init];
        [[s messages] setObject:newChat forKey:newMessageToID];
    }else{
        [[s uniqueMessageUserIDs] removeObject:newMessageToID];
        [[s uniqueMessageUserIDs] insertObject:newMessageToID atIndex:0];
    }
    NSMutableDictionary *newMessageDictionary=[[NSMutableDictionary alloc] init];
    [newMessageDictionary setValue:newMessage forKey:@"message"];
    [newMessageDictionary setValue:newMessageToID forKey:@"to_id"];
    [newMessageDictionary setValue:[s userId] forKey:@"from_id"];
    
    [[[s messages] objectForKey:newMessageToID] insertObject:newMessageDictionary atIndex:0];
    [chatTableView reloadData];
    
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:([[[s messages] objectForKey:newMessageToID] count] - 1) inSection:0];
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
    return [[[s messages] objectForKey:newMessageToID] count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    NSArray *chatMessages=[[s messages] objectForKey:newMessageToID];
    NSString *text= [[chatMessages objectAtIndex:indexPath.row] objectForKey:@"message"];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 44.0f);
    
    return height + (CELL_CONTENT_MARGIN * 2);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    NSArray *chatMessages=[[s messages] objectForKey:newMessageToID];
    NSString *mainLabelText= [[chatMessages objectAtIndex:[chatMessages count]-1-indexPath.row] objectForKey:@"message"];
    
    static NSString *CellIdentifier=nil;
    if([[[chatMessages objectAtIndex:[chatMessages count]-1-indexPath.row] objectForKey:@"from_id"] isEqualToString:[s userId]])
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
    
    UILabel *label = (UILabel *)[cell viewWithTag:2];
    UILabel *label2 = (UILabel *)[cell viewWithTag:1];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH, 20000.0f);
    
    CGSize size = [mainLabelText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    [label setText:mainLabelText];
    
    if([[[chatMessages objectAtIndex:[chatMessages count]-1-indexPath.row] objectForKey:@"from_id"] isEqualToString:[s userId]])
    {
        label.textAlignment=UITextAlignmentRight;  
        [label setFrame:CGRectMake(320-CELL_CONTENT_MARGIN-CELL_CONTENT_WIDTH -7,CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH, MAX(size.height, 44.0f))];  
        [label2 setFrame:CGRectMake(320-CELL_CONTENT_MARGIN-CELL_CONTENT_WIDTH,CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH + 7, MAX(size.height, 44.0f))];
    } else {
        [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH + 13, MAX(size.height, 44.0f))];
         [label2 setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH+7, MAX(size.height, 44.0f))];
    }
    
    if ([@"fromCellIdentifier" compare:CellIdentifier]==NSOrderedSame) {
        //blue
        label.backgroundColor = [UIColor clearColor];
        label2.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6];
        
    } else {
        label.backgroundColor = [UIColor clearColor];
        label2.backgroundColor = [UIColor colorWithRed:0.0 green:0.6 blue:0.6 alpha:0.6];
    }
    
    [label.layer setCornerRadius:6];
    [label.layer setMasksToBounds:YES];
    
    [label2.layer setCornerRadius:6];
    [label2.layer setMasksToBounds:YES];
    label2.layer.borderColor = [UIColor whiteColor].CGColor;
    label2.layer.borderWidth = 4.0;
    
//    CGRect frame = label.frame;
//    frame.origin.x -= 10;
//    label.frame = frame;
    
    cell.backgroundColor = [UIColor clearColor];
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
