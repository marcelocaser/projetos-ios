//
//  AjusteTableViewController.h
//  BodyTech
//
//  Created by Marcelo Caser on 12/08/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import <UIKit/UIKit.h>
@import SystemConfiguration;
#import <netdb.h>
#import <arpa/inet.h>

@interface AjusteTableViewController : UITableViewController {
    
    NSUserDefaults *userDefaults;
    
    
}

@property (strong, nonatomic) IBOutlet UISwitch *switchAcessoARede;

- (IBAction)switchAcessoARede:(id)sender;

@end
