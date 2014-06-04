//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Satyajit Rai on 6/3/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *default1;
@property (weak, nonatomic) IBOutlet UITextField *default2;
@property (weak, nonatomic) IBOutlet UITextField *default3;

- (IBAction)onTap:(id)sender;

-(void) loadDefaults;
-(void) saveDefaults;
@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Settings";
    }
    return self;
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing: YES];
    [self saveDefaults];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadDefaults];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc]init] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"settings view will appear");
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"settings view did appear");
    [self loadDefaults];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"settings view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"settings view did disappear");
    [self saveDefaults];
}

+ (NSArray*) getDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *val1 = [defaults stringForKey:@"tip_percent1"];
    NSString *val2 = [defaults stringForKey:@"tip_percent2"];
    NSString *val3 = [defaults stringForKey:@"tip_percent3"];
    
    if (val1 == nil) {
        val1 = @"10";
    }
    
    if (val2 == nil) {
        val2 = @"20";
    }
    
    if (val3 == nil) {
        val3 = @"30";
    }
    NSArray * arr = @[val1, val2, val3];
    
    return arr;
}

-(void) loadDefaults {
    NSArray *arr = [SettingsViewController getDefaults];
    self.default1.text = arr[0];
    self.default2.text = arr[1];
    self.default3.text = arr[2];
}


-(void) saveDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.default1.text forKey: @"tip_percent1"];
    [defaults setObject:self.default2.text forKey: @"tip_percent2"];
    [defaults setObject:self.default3.text forKey: @"tip_percent3"];
    [defaults synchronize];
}

@end
