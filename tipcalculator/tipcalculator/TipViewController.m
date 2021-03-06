//
//  TipViewController.m
//  tipcalculator
//
//  Created by Ali YAZDAN PANAH on 10/6/14.
//  Copyright (c) 2014 Ali YAZDAN PANAH. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

- (IBAction)onTap:(id)sender;
- (void) updateValues;

@end

@implementation TipViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"Tip Calculator";
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];

  [self.billTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
  
  [self.billTextField becomeFirstResponder];
  
  [self.clearButton addTarget:self action:@selector(clearButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  [[self.clearButton layer] setBorderWidth:1.0f];
  [[self.clearButton layer] setBorderColor:[UIColor redColor].CGColor];
  [[self.clearButton layer] setCornerRadius:5.0f];
  
  [self updateValues];
}

-(void)textFieldDidChange :(UITextField *)theTextField{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:self.billTextField.text forKey:@"billTextField"];
  [self force2Decimal];
  [self updateValues];
}

-(void)force2Decimal{
  NSArray *floatStringComps = [self.billTextField.text componentsSeparatedByString:@"."];
  NSUInteger numberOfDecimalPlaces = 0;
  NSUInteger numberOfIntegerPlaces = 0;
  if ([floatStringComps count]>1){
    numberOfDecimalPlaces =  [[floatStringComps objectAtIndex:1] length];
    numberOfIntegerPlaces =  [[floatStringComps objectAtIndex:0] length];
  }
  
  //NSLog(@"%lu,%lu",(unsigned long)numberOfIntegerPlaces,(unsigned long)numberOfDecimalPlaces);
  
  if (numberOfDecimalPlaces>1)
    self.billTextField.text = [NSString stringWithFormat:@"%@.%@",[floatStringComps objectAtIndex:0],[[floatStringComps objectAtIndex:1] substringToIndex:2] ];
}


- (void)viewDidAppear:(BOOL)animated {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  self.billTextField.text = [defaults objectForKey:@"billTextField"];
  NSInteger defaultTipIndex =  [[defaults objectForKey:@"settingsDefaultTip"] integerValue];
  self.tipControl.selectedSegmentIndex = defaultTipIndex;
  
  [self force2Decimal];
  [self updateValues];
}

- (void)viewWillDisappear:(BOOL)animated {
  
}

- (void)viewDidDisappear:(BOOL)animated {
  
}

-(void)onSettingsButton{
  [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)clearButtonPressed:(id)sender{
  self.billTextField.text = @"";
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:self.billTextField.text forKey:@"billTextField"];
  [self updateValues];
}

- (IBAction)onTap:(id)sender {
  [self.view endEditing:YES];
  [self updateValues];
}

- (void)updateValues {
  
  NSString *billAmountstr =self.billTextField.text;
  
  float billAmount = [self.billTextField.text floatValue];
  
  NSArray *tipValues = @[@(0.1),@(0.15),@(0.2)];
  float tipAmount = billAmount*[tipValues[self.tipControl.selectedSegmentIndex] floatValue];
  float totalAmount = tipAmount+billAmount;
  self.tipLabel.text = [NSString stringWithFormat:@"%0.2f",tipAmount];
  self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f",totalAmount];
  [self.billTextField becomeFirstResponder];
  self.billTextField.text = billAmountstr;
  
}


@end
