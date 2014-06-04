//
//  TipViewController.m
//  tipcalculator
//
//  Created by Satyajit Rai on 6/3/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)onSettingsButton;
- (void)updateTipPercentages;
@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self updateValues];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing: YES];
    [self updateValues];
}

-(void) updateValues {
    float billAmount = [self.billTextField.text floatValue];
    
    NSArray *tipValues = @[ @(0.1), @(0.15), @(0.2) ];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex]floatValue];
    float totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    [self updateTipPercentages];
}

- (void)updateTipPercentages {
    NSArray * arr = [SettingsViewController getDefaults];
    NSString *val1 = arr[0];
    NSString *val2 = arr[1];
    NSString *val3 = arr[2];
    
    [self.tipControl setTitle: [val1 stringByAppendingString: @"%"] forSegmentAtIndex:0];
    [self.tipControl setTitle: [val2 stringByAppendingString: @"%"] forSegmentAtIndex:1];
    [self.tipControl setTitle: [val3 stringByAppendingString: @"%"] forSegmentAtIndex:2];
    
}

-(void) onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc]init] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    [self updateTipPercentages];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
    [self updateTipPercentages];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view did disappear");
}

@end
