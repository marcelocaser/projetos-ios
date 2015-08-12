//
//  Produto.h
//  BodyTech
//
//  Created by Marcelo Caser on 10/08/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Produto : NSObject {
    
    @public
    NSString *_codgProd;
    NSString *_codgBarra;
    NSString *_descProd;
    NSString *_codgUnid;
    
}

- (void)setCodgProd:(NSString *)codgProd;
- (void)setCodgBarra:(NSString *)codgBarra;
- (void)setDescProd:(NSString *)descProd;
- (void)setCodgUnid:(NSString *)codgUnid;
- (NSString *)getCodgProd;
- (NSString *)getCodgBarra;
- (NSString *)getDescProd;
- (NSString *)getCodgUnid;

@end
