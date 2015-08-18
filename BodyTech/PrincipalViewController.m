//
//  PrincipalViewController.m
//  BodyTech
//
//  Created by Marcelo Caser on 28/07/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import "PrincipalViewController.h"

#define urlWSBanco @"http://wsbodytech.ddns.net/smps-ws-banco/ws/buscarUltimosCuponsPorPeriodo.json?cpfCnpj=%@&dias=%d&chave=wssmpsistemasws"
#define urlWSBancoLocal @"http://%@:%@/smps-ws-banco/ws/buscarUltimosCuponsPorPeriodo.json?cpfCnpj=%@&dias=%d&chave=wssmpsistemasws"

@interface PrincipalViewController ()

@end

@implementation PrincipalViewController
//@synthesize jsonCupons, retornoCupons, retornoCuponsItens;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the title
    //self.title = @"Meu Consumo";
    self.ultimosDias.text = @"";
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    userDefaults = [NSUserDefaults standardUserDefaults];
    [self buscaDadosConexao];
    if ([userDefaults boolForKey:@"clienteAtivo"]) {
        _nomeDoCliente.text = [userDefaults objectForKey:@"nomeClien"];
        _valorSaldo.text = [userDefaults objectForKey:@"valoCredito"];
        _cnpjClien.text = [userDefaults objectForKey:@"cnpjClien"];
        NSLog(@"%@ - %@ - %@", _nomeDoCliente.text, _valorSaldo.text, _cnpjClien.text);
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

- (void)enableButtonsAndInputs {
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)disableButtonsAndInputs {
    alert = [[UIAlertView alloc] initWithTitle:@"Aguarde" message:mensagem delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)logout:(id)sender {
    [userDefaults setBool:NO forKey:@"clienteAtivo"];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)settings:(id)sender {
    [self performSegueWithIdentifier:@"ajustesViewController" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ajustesViewController"]) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
}

- (void)buscaDadosConexao {
    ipServidor = [userDefaults objectForKey:@"ipServidor"];
    portaServidor = [userDefaults objectForKey:@"portaServidor"];
}

- (void)buscaCupomPorPerido:(int)dias {
    [self disableButtonsAndInputs];
    [self buscaDadosConexao];
    //Define URL padrao do WS
    urlWs = [NSString stringWithFormat:urlWSBanco, _cnpjClien.text, dias];
    if ([userDefaults boolForKey:@"switchAcessoARedeInterna"]) {
        urlWs = [NSString stringWithFormat:urlWSBancoLocal, ipServidor, [portaServidor isEqualToString:@""] ? @"80" : portaServidor, _cnpjClien.text, dias];
    }
    NSURL *url = [NSURL URLWithString:urlWs];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (response == nil) {
             [self enableButtonsAndInputs];
             alert = [[UIAlertView alloc] initWithTitle:@"Ops..." message:@"Verifique sua conexão de internet e entre em contato com o administrador do sistema." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
             return;
         }
         
         if (connectionError != nil) {
             [self enableButtonsAndInputs];
             alert = [[UIAlertView alloc] initWithTitle:@"Ops..." message:@"Ocorreu um erro ao buscar conexão com o servidor. Tente novamente mais tarde." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
             return;
         }
         
         if (data == nil) {
             [self enableButtonsAndInputs];
             alert = [[UIAlertView alloc] initWithTitle:@"Ops,.." message:@"No momento não foi possível buscar as informações. Tente novamente mais tarde" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
             return;
             
         }
         
         jsonCupons = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
         if (jsonCupons == nil || jsonCupons.count == 0) {
             [self enableButtonsAndInputs];
             NSString *info = [NSString stringWithFormat:@"Não houveram lançamentos nos últimos %d dias", dias];
             alert = [[UIAlertView alloc] initWithTitle:@"Alerta" message:info delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
             //return;
         }
         
         retornoCupons = [[NSMutableArray alloc] init];
         for (int i = 0; i < jsonCupons.count; i++) {
             [self enableButtonsAndInputs];
             cupom = [[Cupom alloc] init];
             [cupom setNumrCupom:[[jsonCupons objectAtIndex:i] objectForKey:@"numrCupom"]];
             [cupom setEcfData:[[jsonCupons objectAtIndex:i] objectForKey:@"ecfData"]];
             [cupom setValrTotal:[[jsonCupons objectAtIndex:i] objectForKey:@"valrTotal"]];
             
             // Itens do Cupom
             retornoCuponsItens = [[jsonCupons objectAtIndex:i] objectForKey:@"cfrtvens"];
             jsonCupomItens = [[NSMutableArray alloc] init];
             for (int j = 0; j < retornoCuponsItens.count; j++) {
                 // Busca o Produto
                 cupomItem = [[CupomItem alloc] init];
                 produto = [[Produto alloc] init];
                 NSDictionary *prod = [[retornoCuponsItens objectAtIndex:j] objectForKey:@"codigoproduto"];
                 [produto setCodgProd:[[prod objectForKey:@"codgProd"] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]];
                 [produto setCodgBarra:[[prod objectForKey:@"codgBarra"] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]];
                 [produto setDescProd:[[prod objectForKey:@"descProd"] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]];
                 [produto setCodgUnid:[[prod objectForKey:@"codgUnid"] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]];
                 [cupomItem setProduto:produto];
                 [cupomItem setTotal:[[retornoCuponsItens objectAtIndex:j] objectForKey:@"total"]];
                 [cupomItem setUnitario:[[retornoCuponsItens objectAtIndex:j] objectForKey:@"unitario"]];
                 [cupomItem setSeqItem:[[retornoCuponsItens objectAtIndex:j] objectForKey:@"seqItem"]];
                 [cupomItem setQtde:[[retornoCuponsItens objectAtIndex:j] objectForKey:@"qtde"]];
                 [jsonCupomItens addObject:cupomItem];
                 
             }
             [cupom setCupomItens:jsonCupomItens];
             [retornoCupons addObject:cupom];
         }
         
         [self.tableView reloadData];
         
     }];
    
}

- (IBAction)extratoUltimos10Dias:(id)sender {
    mensagem = @"Buscando os dados dos últimos 10 dias...";
    _ultimosDias.text = @"Extrato 10 dias";
    [self buscaCupomPorPerido:10];
}

- (IBAction)extratoUltimos30Dias:(id)sender {
    mensagem = @"Buscando os dados dos últimos 30 dias...";
    _ultimosDias.text = @"Extrato 30 dias";
    [self buscaCupomPorPerido:30];
}

- (IBAction)extratoUltimos60Dias:(id)sender {
    mensagem = @"Buscando os dados dos últimos 60 dias...";
    _ultimosDias.text = @"Extrato 60 dias";
    [self buscaCupomPorPerido:360];
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
    return [retornoCupons count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CupomTableViewCell *cellPrincipal = [tableView dequeueReusableCellWithIdentifier:@"CellPrincipal" forIndexPath:indexPath];
    
    // Configure the cell...
    Cupom *cp;
    cp = [retornoCupons objectAtIndex:indexPath.row];
    
    cellPrincipal.numrCupom.text = cp.getNumrCupom;
    cellPrincipal.ecfData.text = cp.getEcfData;
    cellPrincipal.valrTotal.text = [NSString stringWithFormat:@"R$ %@,00", cp.getValrTotal];
    for (int i = 0; i < cp.getCupomItens.count; i++) {
        CupomItem *item = [cp.getCupomItens objectAtIndex:i];
        cellPrincipal.descProd.text = [[item getProduto] getDescProd];
        cellPrincipal.vlrtItem.text = [NSString stringWithFormat:@"R$ %@,00", [item getTotal]];
    }
    
    return cellPrincipal;
}

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
