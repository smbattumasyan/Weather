//
//  IntroViewController.m
//  Weather
//
//  Created by Smbat Tumasyan on 2/10/16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import "IntroViewController.h"
#import "WeatherMockService.h"
#import "WeatherWebService.h"
#import "ViewController.h"

@interface IntroViewController ()

//-------------------------------------------------------------------------------------------
#pragma mark - Properties IBOutlets
//-------------------------------------------------------------------------------------------
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;
@property (weak, nonatomic) IBOutlet UISwitch *demoSwitch;

@end

@implementation IntroViewController

//-------------------------------------------------------------------------------------------
#pragma mark - Lifecyrcle
//-------------------------------------------------------------------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterCountryButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"IntroViewController" sender:self];
}

//-------------------------------------------------------------------------------------------
#pragma mark - Navigation
//-------------------------------------------------------------------------------------------

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"IntroViewController"]) {
        ViewController *weatherViewController = [segue destinationViewController];
        if ([self.demoSwitch isOn]) {
            weatherViewController.service = [[WeatherMockService alloc] init];
        } else {
            weatherViewController.service = [[WeatherWebService alloc] init];
        }
        weatherViewController.countryName = self.countryTextField.text;
        
    }
}


@end
