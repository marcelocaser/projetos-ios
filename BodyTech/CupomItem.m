//
//  CupomItem.m
//  BodyTech
//
//  Created by Marcelo Caser on 10/08/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import "CupomItem.h"

@implementation CupomItem

- (void)setSeqItem:(NSString *)seqItem {
    seqItem = _seqItem;
}

- (void)setQtde:(NSString *)qtde {
    _qtde = qtde;
}

-(void)setUnitario:(NSString *)unitario {
    _unitario = unitario;
}

- (void)setTotal:(NSString *)total {
    _total = total;
}

- (void)setProduto:(Produto *)produto {
    _produto = [[Produto alloc] init];
    _produto = produto;
    /*[_produto setCodgProd:[produto getCodgProd]];
    [_produto setCodgBarra:[produto getCodgBarra]];
    [_produto setDescProd:[produto getDescProd]];
    [_produto setCodgUnid:[produto getCodgUnid]];*/
}

- (NSString *)getSeqItem {
    return _seqItem;
}

- (NSString *)getQtde {
    return _qtde;
}

- (NSString *)getUnitario {
    return _unitario;
}

- (NSString *)getTotal {
    return _total;
}

- (Produto *)getProduto {
    return _produto;
}

@end
