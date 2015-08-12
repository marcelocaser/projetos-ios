//
//  CupomTableViewCell.h
//  BodyTech
//
//  Created by Marcelo Caser on 07/08/15.
//  Copyright (c) 2015 SMP Sistemas LTDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CupomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numrCupom;
@property (weak, nonatomic) IBOutlet UILabel *ecfData;
@property (weak, nonatomic) IBOutlet UILabel *descProd;
@property (weak, nonatomic) IBOutlet UILabel *valrTotal;

@end
