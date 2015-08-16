//
//  AjusteTableViewController.m
//  BodyTech
//
//  Created by Marcelo Caser on 12/08/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import "AjusteTableViewController.h"

@interface AjusteTableViewController ()

@end

@implementation AjusteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults boolForKey:@"switchAcessoARedeInterna"]) {
        [self.switchAcessoARede setOn:TRUE animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController setToolbarHidden:YES animated:NO];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (IBAction)switchAcessoARede:(id)sender {
    //switchAcessoARede = sender;
    if (_switchAcessoARede.on) {
        [userDefaults setBool:YES forKey:@"switchAcessoARedeInterna"];
    } else {
        [userDefaults setBool:NO forKey:@"switchAcessoARedeInterna"];
    }
}

- (IBAction)hostConnect:(id)sender {
    NSLog(@"%s",__FUNCTION__);
}

BOOL hasLeadingNumberInString(NSString* s) {
    if (s)
        return [s length] && isnumber([s characterAtIndex:0]);
    else
        return NO;
}

-(BOOL)networkConnected: (NSString *)ipAdress Port:(int)port {
    SCNetworkReachabilityFlags  flags = 0;
    SCNetworkReachabilityRef    netReachability;
    BOOL                        retrievedFlags = NO;
    
    // added the "if" and first part of if statement
    //
    if (hasLeadingNumberInString(ipAdress)) {
        struct sockaddr_in the_addr;
        memset((void *)&the_addr, 0, sizeof(the_addr));
        the_addr.sin_family = AF_INET;
        the_addr.sin_port = htons(port);
        const char* server_addr = [ipAdress UTF8String];
        unsigned int ip_addr = inet_addr(server_addr);
        the_addr.sin_addr.s_addr = ip_addr;
        netReachability =    SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (struct sockaddr*)&the_addr);
    } else {
        netReachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, [ipAdress UTF8String]);
    }
    if (netReachability) {
        retrievedFlags = SCNetworkReachabilityGetFlags(netReachability, &flags);
        CFRelease(netReachability);
    }
    if (!retrievedFlags || !flags) {
        return NO;
    }
    return YES;
}

/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellAjustes" forIndexPath:indexPath];
 
 // Configure the cell...
 
 
 return cell;
 }*/

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
