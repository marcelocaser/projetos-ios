//
//  PrincipalViewController.h
//  BodyTech
//
//  Created by Marcelo Caser on 28/07/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cliente.h"
#import "CupomItem.h"
#import "CupomTableViewCell.h"

@interface PrincipalViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    
    CupomItem *cupomItem;
    Produto *produto;
    UIAlertView *alert;
    UIActivityIndicatorView *activity;
    NSMutableArray *jsonCupons;
    NSMutableArray *retornoCupons;
    NSMutableArray *retornoCuponsItens;
    NSString *mensagem;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *nomeDoCliente;
@property (strong, nonatomic) IBOutlet UILabel *valorSaldo;
@property (strong, nonatomic) Cliente *cliente;
@property (strong, nonatomic) IBOutlet UILabel *ultimosDias;

- (void)buscaCupomPorPerido:(int)dias;
- (IBAction)extratoUltimos10Dias:(id)sender;
- (IBAction)extratoUltimos30Dias:(id)sender;
- (IBAction)extratoUltimos60Dias:(id)sender;

@end
