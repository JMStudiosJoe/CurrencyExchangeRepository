//
//  JMSDisplayExchangeControllerViewController.h
//  currencyExchange
//
//  Created by Joey Richardson on 3/19/13.
//  Copyright (c) 2013 Joey Richardson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMSDisplayExchangeViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *userBaseCurrency;
@property (strong, nonatomic) IBOutlet UIImageView *segueISOFlag;
@property double userAmount;
@property NSString *segueCurrency;
@property NSString *link;
@property (strong, nonatomic) NSArray *currencyISO;
@property (strong, nonatomic) NSArray *excangeCurrencyRates;
@property (strong, nonatomic) NSDictionary *downloadedExchangeRates;
@property (strong, nonatomic) NSDictionary *downloadedEnglishNames;

- (IBAction)backButton:(UIButton *)sender;



@end
