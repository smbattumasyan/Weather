//
//  WeatherMockService.m
//  Weather
//
//  Created by Smbat Tumasyan on 2/10/16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import "WeatherMockService.h"

@implementation WeatherMockService

//-------------------------------------------------------------------------------------------
#pragma mark - Protocol Methods
//-------------------------------------------------------------------------------------------

- (void)currentWeatherRequest:(NSString *)country completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"WeatherCurrent" ofType:@"json"];
    NSData *data       = [NSData dataWithContentsOfFile:filePath];
    completionHandler(data,nil,nil);
}

- (void)weekWeatherRequest:(nonnull NSString *)country completionHandler:(nullable void (^)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"WeatherWeek" ofType:@"json"];
    NSData *data       = [NSData dataWithContentsOfFile:filePath];
    completionHandler(data,nil,nil);
}

@end
