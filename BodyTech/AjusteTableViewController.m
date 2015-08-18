//
//  AjusteTableViewController.m
//  BodyTech
//
//  Created by Marcelo Caser on 12/08/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import "AjusteTableViewController.h"
//#import "CocoaAsyncSocket.h"
#import "GCDAsyncSocket.h"

@interface AjusteTableViewController ()

@end

@implementation AjusteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _portaServidor.delegate = self;
    _ipServidor.delegate = self;
    userDefaults = [NSUserDefaults standardUserDefaults];
    _ipServidor.text = [userDefaults objectForKey:@"ipServidor"];
    _portaServidor.text = [userDefaults objectForKey:@"portaServidor"];
    [self validaServidorAtivo];
    if ([userDefaults boolForKey:@"switchAcessoARedeInterna"] && ![[userDefaults objectForKey:@"ipServidor"] isEqualToString:@""]) {
        [_switchAcessoARede setOn:TRUE animated:YES];
    } else {
        [_switchAcessoARede setOn:FALSE animated:YES];
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
    if (_switchAcessoARede.on) {
        //[_ipServidor becomeFirstResponder];
        return 3;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //[_ipServidor becomeFirstResponder];
    /*if (_switchAcessoARede.on && section > 0) {
        return 2;
    }*/
    return 1;
}

- (IBAction)switchAcessoARede:(id)sender {
    if (_switchAcessoARede.on) {
        [userDefaults setBool:YES forKey:@"switchAcessoARedeInterna"];
    } else {
        //_ipServidor.text = @"";
        //_portaServidor.text = @"";
        [userDefaults setBool:NO forKey:@"switchAcessoARedeInterna"];
        //[userDefaults setObject:_ipServidor.text forKey:@"ipServidor"];
        //[userDefaults setObject:_portaServidor.text forKey:@"portaServidor"];
    }
    
    [self validaServidorAtivo];
    
    [[super tableView] reloadData];
}

- (IBAction)editingDidEnd:(id)sender {
    [userDefaults setObject:_ipServidor.text forKey:@"ipServidor"];
    [userDefaults setObject:_portaServidor.text forKey:@"portaServidor"];
    if ([_ipServidor.text isEqualToString:@""]) {
        [userDefaults setBool:NO forKey:@"switchAcessoARedeInterna"];
        //[userDefaults setObject:_ipServidor.text forKey:@"ipServidor"];
        //[userDefaults setObject:_portaServidor.text forKey:@"portaServidor"];
    }
    
    [self validaServidorAtivo];
}

- (void)validaServidorAtivo {
    [self showActivityIndicator];
    if ([self networkConnected:_ipServidor.text port:[_portaServidor.text intValue]]) {
        _status.text = @"Conectado";
        _status.textColor = [UIColor greenColor];
    } else {
        _status.text = @"Desconectado";
        _status.textColor = [UIColor redColor];
    }
    [self hideActivityIndicator];
}

- (void) showActivityIndicator {
    [UIView animateWithDuration:0.3 animations:^{_activityStatusRede.alpha = 1.0;} completion:^(BOOL finished) {
        [_activityStatusRede startAnimating];
    }];
}

- (void) hideActivityIndicator {
    [UIView animateWithDuration:0.3 animations:^{_activityStatusRede.alpha = 0.0;} completion:^(BOOL finished) {
        [_activityStatusRede stopAnimating];
    }];
}

/*
 Metodo responsavel por esconder o teclado quando precionada a tecla "retornar"
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField) {
        [textField resignFirstResponder];
    }
    [self validaServidorAtivo];
    return YES;
}

-(BOOL)networkConnected: (NSString *)ipAdress port:(int)port {
    NSError *error = nil;
    asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    //[asyncSocket readDataWithTimeout:5 tag:1];
    if (![asyncSocket connectToHost:ipAdress onPort:port error:&error]) {
        NSLog(@"%@", error);
    }
    if ([asyncSocket connectedHost]) {
        return TRUE;
    }
    
    if ([asyncSocket isConnected]) {
        return TRUE;
    }
    return FALSE;
}

/*
 Metodo responsavel por esconder o teclado ao clicar na tela
 */
/*- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
 [_ipServidor resignFirstResponder];
 [_portaServidor resignFirstResponder];
 }*/

BOOL hasLeadingNumberInString(NSString* s) {
    if (s)
        return [s length] && isnumber([s characterAtIndex:0]);
    else
        return NO;
}

/*-(BOOL)networkConnected: (NSString *)ipAdress port:(int)port {
    NSLog(@"%s",__FUNCTION__);
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
        the_addr.sin_len = sizeof(the_addr);
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
}*/

/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellServidorPorta" forIndexPath:indexPath];
 
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
