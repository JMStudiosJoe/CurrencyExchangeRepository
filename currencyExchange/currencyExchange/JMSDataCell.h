//
//  JMSDataCell.h
//  currencyExchange
//
//  Created by Joey Richardson on 3/29/13.
//  Copyright (c) 2013 Joey Richardson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMSDataCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *exchangeCurrency;

@property (strong, nonatomic) IBOutlet UIImageView *flag;

@property (strong, nonatomic) IBOutlet UILabel *amount;

@end
