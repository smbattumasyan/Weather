//
//  ViewController.m
//  Weather
//
//  Created by Smbat Tumasyan on 1/8/16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import "ViewController.h"
#import "WeatherMockService.h"
#import "WeatherWebService.h"

@interface ViewController ()
//-------------------------------------------------------------------------------------------
#pragma mark - IBOutlates
//-------------------------------------------------------------------------------------------

@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *barometerLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherStatusLabel;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *weeksLabelCollection;

//-------------------------------------------------------------------------------------------
#pragma mark - Properties
//-------------------------------------------------------------------------------------------

@property (strong, nonatomic) NSDictionary *json;

@end

@implementation ViewController

//-------------------------------------------------------------------------------------------
#pragma mark - Lifecyrcle
//-------------------------------------------------------------------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self weatherRequest:self.countryName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-------------------------------------------------------------------------------------------
#pragma mark - Private Methods
//-------------------------------------------------------------------------------------------

-(void)weatherRequest:(NSString *)country {

        [self.service currentWeatherRequest:country completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self setLabels:dict];
                        });
        }];
        
        [self.service weekWeatherRequest:country completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setWeekDaysLabel:dict];
            });
        }];
}

- (NSString *)jsonStringWithPrettyPrint:(NSDictionary *)dictionary
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    if (!jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint:error:%@",error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

-(void)setLabels:(NSDictionary *)json
{
    self.countryLabel.text       = [NSString stringWithFormat:@"%@",[json valueForKey:@"name"]];
    self.windLabel.text          = [NSString stringWithFormat:@"Wind %@ kmh", [json valueForKeyPath:@"wind.speed"]];
    self.tempLabel.text          = [NSString stringWithFormat:@"%d^", [[json valueForKeyPath:@"main.temp"] integerValue]];
    self.humidityLabel.text      = [NSString stringWithFormat:@"Humidity %d%%", [[json valueForKeyPath:@"main.humidity"] integerValue]];
    self.barometerLabel.text     = [NSString stringWithFormat:@"Barometer %d", [[json valueForKeyPath:@"main.pressure"] integerValue]];
    NSArray *weatherStatus       = [NSArray arrayWithObject:[json valueForKeyPath:@"weather.main"]];
    self.weatherStatusLabel.text = [NSString stringWithFormat:@"%@", [weatherStatus[0] objectAtIndex:0]];
}

- (void)setWeekDaysLabel:(NSDictionary *)json
{
    NSDictionary *dayList  = [json valueForKey:@"list"];
    NSArray *daysTempMax   = [dayList valueForKeyPath:@"temp.max"];
    NSArray *daysTempMin   = [dayList valueForKeyPath:@"temp.min"];

    for (int i = 0; i < [daysTempMax count]; i++) {
        UILabel *label = [self.weeksLabelCollection objectAtIndex:i];
        
        NSString *maxTemp;
        NSString *minTemp;
        if ((long)[daysTempMax[i] integerValue] < 0) {
            maxTemp = [NSString stringWithFormat:@"%ld",(long)[daysTempMax[i] integerValue]];
            minTemp = [NSString stringWithFormat:@"%ld",(long)[daysTempMin[i] integerValue]];
        } else {
            maxTemp = [NSString stringWithFormat:@" %ld",(long)[daysTempMax[i] integerValue]];
            minTemp = [NSString stringWithFormat:@" %ld",(long)[daysTempMin[i] integerValue]];
        }

        label.text = [NSString stringWithFormat:@"%@^      %@^",maxTemp, minTemp];
    }
}



@end
