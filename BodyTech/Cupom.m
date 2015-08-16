//
//  Cupom.m
//  BodyTech
//
//  Created by Marcelo Caser on 04/08/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import "Cupom.h"

@implementation Cupom

- (void)setNumrCupom:(NSString *)numrCupom {
    _numrCupom = numrCupom;
}

- (void)setEcfData:(NSString *)ecfData {
    _ecfData = ecfData;
}

- (void)setValrTotal:(NSNumber *)valrTotal {
    _valrTotal = valrTotal;
}

- (void)setCupomItens:(NSMutableArray *)cupomItens {
    _cupomItens = cupomItens;
}

- (NSMutableArray *)getCupomItens {
    return _cupomItens;
}

- (NSString *)getNumrCupom {
    return _numrCupom;
}

- (NSString *)getEcfData {
    return _ecfData;
}

- (NSNumber *)getValrTotal {
    return _valrTotal;
}

@end
