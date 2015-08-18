//
//  ViewController.h
//  BodyTech
//
//  Created by Marcelo Caser on 03/07/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrincipalViewController.h"
#import "AjusteTableViewController.h"

@interface ViewController : UIViewController <UITextFieldDelegate> {
    
    Cliente *cliente;
    UIAlertView *alert;
    NSString *mensagem;
    NSString *urlWs;
    NSUserDefaults *userDefaults;
    NSString *ipServidor;
    NSString *portaServidor;
}
- (IBAction)efetuarLogin:(id)sender;
- (IBAction)settings:(id)sender;

@property (nonatomic, strong) IBOutlet UITextField *cpfCnpj;
@property (nonatomic, strong) IBOutlet UITextField *senha;

@end

