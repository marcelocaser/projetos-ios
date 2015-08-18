//
//  ViewController.m
//  BodyTech
//
//  Created by Marcelo Caser on 03/07/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import "ViewController.h"

#define urlWSClient @"http://wsbodytech.ddns.net/smps-ws-client/ws/efetuarLogin.json?cpfCnpj=%@&senha=%@&chave=wssmpsistemasws"
#define urlWSClientLocal @"http://%@:%@/smps-ws-client/ws/efetuarLogin.json?cpfCnpj=%@&senha=%@&chave=wssmpsistemasws"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _cpfCnpj.delegate = self;
    _senha.delegate = self;
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    //ipServidor = [userDefaults objectForKey:@"ipServidor"];
    //portaServidor = [userDefaults objectForKey:@"portaServidor"];
    if ([userDefaults boolForKey:@"clienteAtivo"]) {
        [self performSegueWithIdentifier:@"principalViewController" sender:self];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController setToolbarHidden:YES animated:NO];
    
}

- (IBAction)efetuarLogin:(id)sender {
    //[_btnLogin setEnabled:NO];
    if ([self validaCPFCNPJ] && [self validaSenha]) {
        mensagem = @"Verificando conexão...";
        [self disableButtonsAndInputs];
        //Define URL padrao do WS
        ipServidor = [userDefaults objectForKey:@"ipServidor"];
        portaServidor = [userDefaults objectForKey:@"portaServidor"];
        urlWs = [NSString stringWithFormat:urlWSClient, _cpfCnpj.text, _senha.text];
        if ([userDefaults boolForKey:@"switchAcessoARedeInterna"]) {
            urlWs = [NSString stringWithFormat:urlWSClientLocal, ipServidor, [portaServidor isEqualToString:@""] ? @"80" : portaServidor, _cpfCnpj.text, _senha.text];
        }
        NSURL *url = [NSURL URLWithString:urlWs];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self enableButtonsAndInputs];
        mensagem = @"Consultando servidor...";
        [self disableButtonsAndInputs];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             [self enableButtonsAndInputs];
             mensagem = @"Buscando cliente...";
             [self disableButtonsAndInputs];
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
             
             if (data.length == 0) {
                 [self enableButtonsAndInputs];
                 alert = [[UIAlertView alloc] initWithTitle:@"Ops..." message:@"Cliente não encontrado ou senha inválida." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alert show];
                 return;
                 
             }
             
             [self enableButtonsAndInputs];
             
             if (data.length > 0 && connectionError == nil)
             {
                 NSDictionary *cli = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                 cliente = [[Cliente alloc] init];
                 [cliente setNomeClien:[[cli objectForKey:@"nomeClien"] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]];
                 [cliente setCodgClien:[[cli objectForKey:@"codgClien"] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]];
                 [cliente setValoCredito:[[cli objectForKey:@"valoCredito"] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]];
                 [cliente setCnpjClien:[[cli objectForKey:@"cnpjClien"] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]];
                 [cliente setPassword:[[cli objectForKey:@"password"] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]];
                 [cliente setSituacao:[[cli objectForKey:@"situacao"] stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]]];
                 mensagem = @"Verificando cliente ativo";
                 if (![@"L" isEqualToString:cliente.situacao])
                 {
                     [userDefaults setBool:NO forKey:@"clienteAtivo"];
                     [self enableButtonsAndInputs];
                     alert = [[UIAlertView alloc] initWithTitle:@"Alerta" message:@"É necessário estar ativo para acessar o sistema." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                     [alert show];
                 } else {
                     [userDefaults setObject:cliente.nomeClien forKey:@"nomeClien"];
                     [userDefaults setObject:cliente.cnpjClien forKey:@"cnpjClien"];
                     [userDefaults setObject:cliente.valoCredito forKey:@"valoCredito"];
                     [userDefaults setBool:YES forKey:@"clienteAtivo"];
                     _senha.text = nil;
                     [_senha resignFirstResponder];
                     [self performSegueWithIdentifier:@"principalViewController" sender:self];
                     
                 }
             }
             
         }];
    }
}

- (IBAction)settings:(id)sender {
    [self performSegueWithIdentifier:@"ajustesViewController" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"principalViewController"]) {
        //PrincipalViewController *pvc = (PrincipalViewController *)segue.destinationViewController;
        //pvc.cliente = cliente;
    }
    
    if ([segue.identifier isEqualToString:@"ajustesViewController"]) {
        //AjusteTableViewController *svc = (AjusteTableViewController *)segue.destinationViewController;
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
}

- (BOOL)validaCPFCNPJ {
    if ([_cpfCnpj.text isEqualToString:@""]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Alerta" message:@"Por favor, informe o CPF ou CNPJ" delegate:self cancelButtonTitle:@"Continuar" otherButtonTitles:nil];
        [alert show];
        [_cpfCnpj becomeFirstResponder];
        return false;
    }
    return true;
}

- (BOOL)validaSenha {
    if ([_senha.text isEqualToString:@""]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Alerta" message:@"Por favor, informe a senha" delegate:self cancelButtonTitle:@"Continuar" otherButtonTitles:nil];
        [alert show];
        [_senha becomeFirstResponder];
        return false;
    }
    return true;
}

/*
 Metodo responsavel por esconder o teclado quando precionada a tecla "retornar"
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField) {
        [textField resignFirstResponder];
    }
    return NO;
}

/*
 Metodo responsavel por esconder o teclado ao clicar na tela
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

/*
 */
/*- (NSUInteger)supportedInterfaceOrientations {
 return UIInterfaceOrientationIsPortrait(YES);
 }*/

/*
 Metodo responsavel por "travar" auto rotação
 */
/*- (BOOL)shouldAutorotate {
 return NO;
 }*/

- (void)enableButtonsAndInputs {
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)disableButtonsAndInputs {
    alert = [[UIAlertView alloc] initWithTitle:@"Aguarde" message:mensagem delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alert show];
}

@end
