//
//  ViewController.h
//  Weather
//
//  Created by Smbat Tumasyan on 1/8/16.
//  Copyright © 2016 EGS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherService.h"

@interface ViewController : UIViewController <WeatherServiceProtocol>

@property (strong, nonatomic)  id<WeatherServiceProtocol>service;
@property (strong, nonatomic) NSString *countryName;

@end

