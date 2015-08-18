//
//  PrincipalViewController.h
//  BodyTech
//
//  Created by Marcelo Caser on 28/07/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cliente.h"
#import "Cupom.h"
#import "CupomItem.h"
#import "CupomTableViewCell.h"

@interface PrincipalViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    
    Cupom *cupom;
    CupomItem *cupomItem;
    Produto *produto;
    //Cliente *cliente;
    UIAlertView *alert;
    NSMutableArray *jsonCupons;
    NSMutableArray *jsonCupomItens;
    NSMutableArray *retornoCupons;
    NSMutableArray *retornoCuponsItens;
    NSUserDefaults *userDefaults;
    NSString *mensagem;
    NSString *ipServidor;
    NSString *portaServidor;
    NSString *urlWs;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *nomeDoCliente;
@property (strong, nonatomic) IBOutlet UILabel *valorSaldo;
@property (weak, nonatomic) IBOutlet UILabel *cnpjClien;
@property (strong, nonatomic) IBOutlet UILabel *ultimosDias;

- (IBAction)logout:(id)sender;
- (IBAction)settings:(id)sender;
- (void)buscaCupomPorPerido:(int)dias;
- (IBAction)extratoUltimos10Dias:(id)sender;
- (IBAction)extratoUltimos30Dias:(id)sender;
- (IBAction)extratoUltimos60Dias:(id)sender;

@end
