//
//  AjusteTableViewController.h
//  BodyTech
//
//  Created by Marcelo Caser on 12/08/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import <UIKit/UIKit.h>
/*@import SystemConfiguration;
#import <netdb.h>
#import <arpa/inet.h>*/

@class GCDAsyncSocket;

@interface AjusteTableViewController : UITableViewController <UITextFieldDelegate> {
    
    NSUserDefaults *userDefaults;
    GCDAsyncSocket *asyncSocket;
    
}

@property (strong, nonatomic) IBOutlet UITextField *ipServidor;
@property (strong, nonatomic) IBOutlet UITextField *portaServidor;
@property (strong, nonatomic) IBOutlet UISwitch *switchAcessoARede;
@property (strong, nonatomic) IBOutlet UILabel *statusDaRede;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityStatusRede;

- (IBAction)switchAcessoARede:(id)sender;
- (IBAction)editingDidEnd:(id)sender;

@end
