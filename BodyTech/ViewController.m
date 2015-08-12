//
//  ViewController.m
//  BodyTech
//
//  Created by Marcelo Caser on 03/07/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import "ViewController.h"

#define urlWSClient @"http://wsbodytech.ddns.net/smps-ws-client/ws/efetuarLogin.json?cpfCnpj=%@&senha=%@&chave=wssmpsistemasws"
#define urlWSClientTeste @"http://192.168.0.12/smps-ws-client/ws/efetuarLogin.json?cpfCnpj=%@&senha=%@&chave=wssmpsistemasws"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self fetchGreeting];
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
        NSString *urlWs = [NSString stringWithFormat:urlWSClient, self.cpfCnpj.text, self.senha.text];
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
                 /*NSLog(@"%@", cliente.nomeClien);
                  NSLog(@"%@", cliente.codgClien);
                  NSLog(@"%@", cliente.valoCredito);
                  NSLog(@"%@", cliente.password);
                  NSLog(@"%@", cliente.situacao);*/
                 mensagem = @"Verificando cliente ativo";
                 if (![@"L" isEqualToString:cliente.situacao])
                 {
                     [self enableButtonsAndInputs];
                     alert = [[UIAlertView alloc] initWithTitle:@"Alerta" message:@"É necessário estar ativo para acessar o sistema." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                     [alert show];
                     // Get the new view controller using [segue destinationViewController].
                     // Pass the selected object to the new view controller.
                     /*PrincipalController *pc = (PrincipalController *)segue.destinationViewController;
                      pc.nomeCliente.text = cliente.nomeClien;*/
                 } else {
                     //[self performSegueWithIdentifier:@"principalController" sender:self];
                     /*NSString *sucesso = [NSString stringWithFormat:@"%@ - %@ - %@ - %@", cliente.nomeClien, cliente.codgClien, cliente.valoCredito, cliente.situacao];
                      alert = [[UIAlertView alloc] initWithTitle:@"Sucesso" message:sucesso delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                      [alert show];*/
                     _senha.text = nil;
                     [self performSegueWithIdentifier:@"principalViewController" sender:self];
                     
                 }
             }
             
         }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"principalViewController"]) {
        PrincipalViewController *pvc = (PrincipalViewController *)segue.destinationViewController;
        //pvc.nomeDoCliente = cliente.nomeClien;
        pvc.cliente = cliente;
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
    [_senha resignFirstResponder];
    [_cpfCnpj resignFirstResponder];
    return YES;
}

/*
 Metodo responsavel por esconder o teclado ao clicar na tela
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

/*
 Metodo responsavel por "travar" a app na horizontal
 */
- (BOOL)shouldAutorotate {
    return NO;
}

- (void)enableButtonsAndInputs {
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)disableButtonsAndInputs {
    /*activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];*/
    alert = [[UIAlertView alloc] initWithTitle:@"Aguarde" message:mensagem delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    ///[alert addSubview:activity];
    //activity.center = CGPointMake(10,5);
    //activity.color = [UIColor blackColor];
    //[activity startAnimating];
    [alert show];
}

@end
