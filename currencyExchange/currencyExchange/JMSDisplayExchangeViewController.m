//
//  JMSDisplayExchangeControllerViewController.m
//  currencyExchange
//
//  Created by Joey Richardson on 3/19/13.
//  Copyright (c) 2013 Joey Richardson. All rights reserved.
//

#import "JMSDisplayExchangeViewController.h"
#import "JMSDataCell.h"


@interface JMSDisplayExchangeViewController ()                        
@end

@implementation JMSDisplayExchangeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.currencyISO =[[self.downloadedEnglishNames allKeys]
                       sortedArrayUsingComparator:^(id obj1, id obj2)
                       {
                           NSString *ob1 = obj1;
                           NSString *ob2 = obj2;
                           return [ob1 compare:ob2];
                       }];

    [super viewDidLoad];
    
	NSString *temp = [NSString stringWithFormat:@"%@ Amount: %.2lf",[self.downloadedEnglishNames valueForKey:self.segueCurrency] ,self.userAmount];
    
    self.segueISOFlag.image = [UIImage imageNamed:self.segueCurrency];
    
    self.userBaseCurrency.text = [self.segueCurrency stringByAppendingString:temp] ;

}



-(IBAction )backButton:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.downloadedEnglishNames count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JMSDataCell *cell = (JMSDataCell *)[tableView cellForRowAtIndexPath:indexPath ];
    
    self.link = [NSString stringWithFormat:@"http://m.wikipedia.org/wiki/Special:Search/%@", [cell.exchangeCurrency.text stringByReplacingOccurrencesOfString:@" " withString:@"_"]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.link]];
}

- (double)exchangeFunction:(NSString*)baseCurrency exchangeCurrency:(NSString*)exchangeCurrency
{
    double  exchangeRate;
    
    exchangeRate = [[self.downloadedExchangeRates valueForKey:exchangeCurrency]doubleValue] / [[self.downloadedExchangeRates valueForKey:baseCurrency] doubleValue];

    return exchangeRate;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"exchangeData";
       
    JMSDataCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.exchangeCurrency.text = [NSString stringWithFormat:@"%@ %@",[self.currencyISO objectAtIndex:indexPath.row],[self.downloadedEnglishNames objectForKey:[self.currencyISO objectAtIndex:indexPath.row]]];
    
    cell.flag.image = [UIImage imageNamed:[self.currencyISO objectAtIndex:indexPath.row]];
    
    double exchangeRate = [self exchangeFunction:self.segueCurrency exchangeCurrency:[self.currencyISO objectAtIndex:indexPath.row]];
    
    NSString *displayAmount = [[NSString alloc] initWithFormat:@"%.2lf", self.userAmount * exchangeRate];
    
    cell.amount.text = displayAmount;        
    
    return cell;
}


@end
