//
//  CupomItem.h
//  BodyTech
//
//  Created by Marcelo Caser on 10/08/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Produto.h"

@interface CupomItem : NSObject {
    
    NSString *_seqItem;
    NSString *_qtde;
    NSString *_unitario;
    NSString *_total;
    Produto *_produto;
}
- (void)setSeqItem:(NSString *)seqItem;
- (void)setQtde:(NSString *)qtde;
- (void)setUnitario:(NSString *)unitario;
- (void)setTotal:(NSString *)total;
- (void)setProduto:(Produto *)produto;
- (NSString *)getSeqItem;
- (NSString *)getQtde;
- (NSString *)getUnitario;
- (NSString *)getTotal;
- (Produto *)getProduto;

@end
