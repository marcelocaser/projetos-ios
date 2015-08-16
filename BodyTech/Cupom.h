//
//  Cupom.h
//  BodyTech
//
//  Created by Marcelo Caser on 04/08/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CupomItem.h"

@interface Cupom : NSObject {
 
    NSString *_numrCupom;
    NSString *_ecfData;
    NSNumber *_valrTotal;
    NSMutableArray *_cupomItens;
}

- (void)setNumrCupom:(NSString *)numrCupom;
- (void)setEcfData:(NSString *)ecfData;
- (void)setValrTotal:(NSString *)valrTotal;
- (void)setCupomItens:(NSMutableArray *)cupomItens;
- (NSString *)getNumrCupom;
- (NSString *)getEcfData;
- (NSNumber *)getValrTotal;
- (NSMutableArray *)getCupomItens;

@end
