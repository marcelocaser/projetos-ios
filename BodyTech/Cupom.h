//
//  Cupom.h
//  BodyTech
//
//  Created by Marcelo Caser on 04/08/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cupom : NSObject {
 
    @public
    NSString *_numrCupom;
    NSString *_ecfData;
    NSNumber *_valrTotal;
}

- (void)setNumrCupom:(NSString *)numrCupom;
- (void)setEcfData:(NSString *)ecfData;
- (void)setValrTotal:(NSString *)valrTotal;
- (NSString *)getNumrCupom;
- (NSString *)getEcfData;
-( NSNumber *)getValrTotal;

@end
