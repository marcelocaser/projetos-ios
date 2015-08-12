//
//  Cliente.h
//  BodyTech
//
//  Created by Marcelo Caser on 15/07/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cliente : NSObject {

    NSString *_codgClien;
    NSString *_nomeClien;
    NSString *_valoCredito;
    NSString *_cnpjClien;
    NSString *_password;
    NSString *_situacao;
    
}

/*@property (nonatomic, strong) NSString *_codgClien;
@property (nonatomic, strong) NSString *_nomeClien;
@property (nonatomic, strong) NSString *_valoCredito;
@property (nonatomic, strong) NSString *_cnpjClien;
@property (nonatomic, strong) NSString *_password;
@property (nonatomic, strong) NSString *_situacao;

- (id)init:(NSString *)codgClien nomeClien: (NSString *)nomeClien valoCredito: (NSString *)valoCredito cnpjClien: (NSString *)cnpjClien password: (NSString *)password situacao: (NSString *)situacao;*/

-(void)setCodgClien:(NSString *)codgClien;
-(void)setNomeClien:(NSString *)nomeClien;
-(void)setValoCredito:(NSString *)valoCredito;
-(void)setCnpjClien:(NSString *)cnpjClien;
-(void)setPassword:(NSString *)password;
-(void)setSituacao:(NSString *)situacao;
-(NSString *)codgClien;
-(NSString *)nomeClien;
-(NSString *)valoCredito;
-(NSString *)cnpjClien;
-(NSString *)password;
-(NSString *)situacao;
@end
