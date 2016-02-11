//
//  WeatherWebService.m
//  Weather
//
//  Created by Smbat Tumasyan on 2/10/16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import "WeatherWebService.h"

@implementation WeatherWebService

//-------------------------------------------------------------------------------------------
#pragma mark - Protocol Methods
//-------------------------------------------------------------------------------------------

- (void)currentWeatherRequest:(NSString *)country completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler {
    NSURLSession *session          = [NSURLSession sharedSession];
    NSString *urlString            = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&units=metric&APPID=51e509f1096a2fb8e739ed1e51b4ac8c",country];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:completionHandler];
    [dataTask resume];
}

- (void)weekWeatherRequest:(NSString *)country completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler {
    NSURLSession *session          = [NSURLSession sharedSession];
    NSString *urlString            = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&units=metric&APPID=51e509f1096a2fb8e739ed1e51b4ac8c",country];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:completionHandler];
    [dataTask resume];
}

@end
