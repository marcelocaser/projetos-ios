//
//  Produto.m
//  BodyTech
//
//  Created by Marcelo Caser on 10/08/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import "Produto.h"

@implementation Produto

- (void)setCodgProd:(NSString *)codgProd {
    _codgProd = codgProd;
}

- (void)setCodgBarra:(NSString *)codgBarra {
    _codgBarra = codgBarra;
}

- (void)setDescProd:(NSString *)descProd {
    _descProd = descProd;
}

- (void)setCodgUnid:(NSString *)codgUnid {
    _codgBarra = codgUnid;
}

- (NSString *)getCodgProd {
    return _codgProd;
}

- (NSString *)getCodgBarra {
    return _codgBarra;
}

- (NSString *)getDescProd {
    return _descProd;
}

- (NSString *)getCodgUnid {
    return _codgUnid;
}

@end

