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

- (IBAction)onTap:(id)sender;
- (void) updateValues;

@end

@implementation TipViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"Tip Calculator";
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
  
  
  [self updateValues];
}


- (void)viewDidAppear:(BOOL)animated {
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSInteger defaultTipIndex =  [[defaults objectForKey:@"settingsDefaultTip"] integerValue];
  self.tipControl.selectedSegmentIndex = defaultTipIndex;
  [self updateValues];
  
}

- (void)viewWillDisappear:(BOOL)animated {
  NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
  NSLog(@"view did disappear");
}

-(void) onSettingsButton{
  [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)onTap:(id)sender {
  [self.view endEditing:YES];
  [self updateValues];
}

- (void)updateValues {
  float billAmount = [self.billTextField.text floatValue];
  
  NSArray *tipValues = @[@(0.1),@(0.15),@(0.2)];
  float tipAmount = billAmount*[tipValues[self.tipControl.selectedSegmentIndex] floatValue];
  float totalAmount = tipAmount+billAmount;
  self.tipLabel.text = [NSString stringWithFormat:@"%0.2f",tipAmount];
  self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f",totalAmount];
  
}

@end
