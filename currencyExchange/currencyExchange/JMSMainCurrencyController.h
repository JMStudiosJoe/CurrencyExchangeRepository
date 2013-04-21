//
//  JMSViewController.h
//  currencyExchange
//
//  Created by Joey Richardson on 3/18/13.
//  Copyright (c) 2013 Joey Richardson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMSMainCurrencyController : UIViewController
<UIPickerViewDataSource,UIPickerViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *baseCurrency;
@property (strong, nonatomic) IBOutlet UILabel *selectedCurrency;
@property (strong, nonatomic) IBOutlet UITextField *amount;
@property (strong, nonatomic) IBOutlet UILabel *symbol;
@property (strong, nonatomic) IBOutlet UIButton *Submit;
@property (strong, nonatomic) NSArray *currency;
@property (strong, nonatomic) NSArray *countryISO;
@property (strong, nonatomic) NSString *selectedCountryISO;
@property (strong, nonatomic) NSDictionary *downloadedExchangeRates;
@property (strong, nonatomic) NSDictionary *downloadedEnglishNames;
@property (strong, nonatomic) IBOutlet UIImageView *flag;

//- (IBAction) goToRoot: (UIStoryboardSegue*) segue;



@end
