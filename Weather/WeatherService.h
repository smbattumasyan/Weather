//
//  WeatherService.h
//  Weather
//
//  Created by Smbat Tumasyan on 2/9/16.
//  Copyright © 2016 EGS. All rights reserved.
//

#ifndef WeatherDataManager_h
#define WeatherDataManager_h

#import <UIKit/UIKit.h>


#endif /* WeatherService */

@protocol WeatherServiceProtocol <NSObject>

#pragma mark - Protocol Methods

@optional

- (void)currentWeatherRequest:(nullable NSString *)country completionHandler:(nullable void (^)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler;
- (void)weekWeatherRequest:(nonnull NSString *)country completionHandler:(nullable void (^)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler;

@end
