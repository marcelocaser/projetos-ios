//
//  Cliente.m
//  BodyTech
//
//  Created by Marcelo Caser on 15/07/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import "Cliente.h"

@implementation Cliente
//@synthesize _codgClien, _nomeClien, _valoCredito, _cnpjClien, _password, _situacao;

/*- (id)init:(NSString *)codgClien nomeClien: (NSString *)nomeClien valoCredito: (NSString *)valoCredito cnpjClien: (NSString *)cnpjClien password: (NSString *)password situacao: (NSString *)situacao {
    
    self = [super init];
    if (self) {
        _codgClien = codgClien;
        _nomeClien = nomeClien;
        _valoCredito = valoCredito;
        _cnpjClien = cnpjClien;
        _password = password;
        _situacao = situacao;
    }
    return self;
}*/

-(void)setCodgClien:(NSString *)codgClien {
    _codgClien = codgClien;
}

-(void)setNomeClien:(NSString *)nomeClien {
    _nomeClien = nomeClien;
}

-(void)setValoCredito:(NSString *)valoCredito {
    _valoCredito = valoCredito;
}

-(void)setCnpjClien:(NSString *)cnpjClien {
    _cnpjClien = cnpjClien;
}

-(void)setPassword:(NSString *)password {
    _password = password;
}

-(void)setSituacao:(NSString *)situacao {
    _situacao = situacao;
}

-(NSString *)codgClien {
    return _codgClien;
}

-(NSString *)nomeClien {
    return _nomeClien;
}

-(NSString *)valoCredito {
    return _valoCredito;
}

-(NSString *)cnpjClien {
    return _cnpjClien;
}

-(NSString *)password {
    return _password;
}

-(NSString *)situacao {
    return _situacao;
}



@end
