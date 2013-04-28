//
//  JMSViewController.m
//  currencyExchange
//
//  Created by Joey Richardson on 3/18/13.
//  Copyright (c) 2013 Joey Richardson. All rights reserved.
//

#import "JMSMainCurrencyController.h"
#import "JMSDisplayExchangeViewController.h"
#define openExchangeLink [NSURL URLWithString:@"http://openexchangerates.org/api/latest.json?app_id=7cee29cb07c845578074d4cc8c087840"]
#define openExchangeLinkCurrency [NSURL URLWithString:@"http://openexchangerates.org/api/currencies.json?app_id=7cee29cb07c845578074d4cc8c087840"]

@interface JMSMainCurrencyController ()

@end

@implementation JMSMainCurrencyController



- (void)viewDidLoad
{
    
    
   
    [super viewDidLoad];
     
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
   
       NSData  *exchangeData = [NSData dataWithContentsOfURL:openExchangeLink];
       NSData  *exchangeDataCurrencies = [NSData dataWithContentsOfURL:openExchangeLinkCurrency];
        
       NSError* error;
    
    self.downloadedEnglishNames = [NSJSONSerialization JSONObjectWithData:exchangeDataCurrencies options:kNilOptions error:&error];
    
    self.downloadedExchangeRates = [NSJSONSerialization JSONObjectWithData:exchangeData options:kNilOptions error:&error];
    
    self.currency = [[self.downloadedEnglishNames allKeys]
                                   sortedArrayUsingComparator:^(id obj1, id obj2)
                                   {
                                       NSString *ob1 = obj1;
                                       NSString *ob2 = obj2;
                                       return [ob1 compare:ob2];
                                   }];
    self.countryISO = self.currency;
    self.selectedCountryISO = @"USD";
       
    
    self.flag.image = [UIImage imageNamed:@"USD"];
    NSMutableArray *new = [NSMutableArray arrayWithCapacity:[self.currency count]];
    
    for(NSString *ISO in self.currency)
    {
        [new addObject:[NSString stringWithFormat:@"%@ %@",ISO,[self.downloadedEnglishNames objectForKey:ISO]]];
    }
    self.currency = new;
       
}
-(void)dismissKeyboard
{
    [self.amount resignFirstResponder];
}
-(BOOL) testForDecimals:(NSString *)userEnteredAmount
{
    NSString * charToCount = @".";
    NSArray * array = [userEnteredAmount componentsSeparatedByString:charToCount];
    
    
    if((([array count] - 1) > 1) || [self.amount.text isEqualToString:@"."])
    {
        return NO;
    }
    return YES;
    
}
-(UIPickerView*) fillPicker
{
    return self.baseCurrency;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
 -(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.currency count];
}
- (IBAction)submit:(id)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid input!"
                                                    message:@" Please edit the amount you entered."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    
    if([self testForDecimals:self.amount.text])
        [self performSegueWithIdentifier:@"pushData" sender:self];
    else
        [alert show];
    
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.currency objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    self.selectedCurrency.text = self.currency[row];
    self.selectedCountryISO = [self.countryISO objectAtIndex:row ];
    self.symbol.text = [[self.downloadedEnglishNames valueForKey:self.currency[row]] description];
    self.flag.image = [UIImage imageNamed:self.selectedCountryISO];
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

-(IBAction)backgroundTouched:(id)sender
{
    [self.amount resignFirstResponder];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushData"])
    {
        [segue.destinationViewController setUserAmount:[[self.amount text] doubleValue]];
        [segue.destinationViewController setSegueCurrency:self.selectedCountryISO] ;
        [segue.destinationViewController setDownloadedEnglishNames:self.downloadedEnglishNames];
        [segue.destinationViewController setDownloadedExchangeRates:[self.downloadedExchangeRates valueForKey:@"rates"]];
        [segue.destinationViewController setLink:self.selectedCurrency.text];
    }
}

@end
