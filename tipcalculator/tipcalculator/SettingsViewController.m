//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Ali YAZDAN PANAH on 10/8/14.
//  Copyright (c) 2014 Ali YAZDAN PANAH. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTip;

@end

@implementation SettingsViewController


- (void)viewDidLoad {
  [super viewDidLoad];
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSInteger defaultTipIndex =  [[defaults objectForKey:@"settingsDefaultTip"] integerValue];
  self.defaultTip.selectedSegmentIndex = defaultTipIndex;
  // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
  //do nothing!
}

- (void)viewWillDisappear:(BOOL)animated {
  int defaultTipIndex =  (int) self.defaultTip.selectedSegmentIndex;
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setInteger:defaultTipIndex forKey:@"settingsDefaultTip"];
  [defaults synchronize];
}

@end
