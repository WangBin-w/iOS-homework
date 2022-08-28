//
//  WeatherModel.m
//  BINWeatherApp
//
//  Created by Binw on 2022/8/22.
//

#import "WeatherModel.h"
#import "FuturedayWeather.h"

@interface WeatherModel ()


@end

@implementation WeatherModel

- (instancetype)initWithData:(NSData *)data
{
    if (self = [super init]) {
        id nowContent = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        _weatherDescriptionString = nowContent[@"HeWeather6"][0][@"now"][@"cond_txt"];
        _currentTemperatureString = [NSString stringWithFormat:@"%@°", nowContent[@"HeWeather6"][0][@"now"][@"tmp"]];
        _sunriseTimeString = nowContent[@"HeWeather6"][0][@"daily_forecast"][0][@"sr"];
        _sunsetTimeString = nowContent[@"HeWeather6"][0][@"daily_forecast"][0][@"ss"];
        _probabilityOfPrecipitationString = [NSString stringWithFormat:@"%@%%", nowContent[@"HeWeather6"][0][@"daily_forecast"][0][@"pop"]];
        _humidityString = [NSString stringWithFormat:@"%@%%", nowContent[@"HeWeather6"][0][@"daily_forecast"][0][@"hum"]];
        _windDirectionAndSpeedString = [NSString stringWithFormat:@"%@ %@公里/小时", nowContent[@"HeWeather6"][0][@"daily_forecast"][0][@"wind_dir"], nowContent[@"HeWeather6"][0][@"daily_forecast"][0][@"wind_spd"]];
        _felAirTemperatureString = [NSString stringWithFormat:@"%@°", nowContent[@"HeWeather6"][0][@"now"][@"fl"]];
        _precipitationString = [NSString stringWithFormat:@"%@毫米", nowContent[@"HeWeather6"][0][@"daily_forecast"][0][@"pcpn"]];
        _airPressureString = [NSString stringWithFormat:@"%@百帕", nowContent[@"HeWeather6"][0][@"daily_forecast"][0][@"pres"]];
        _visibilityString = [NSString stringWithFormat:@"%@公里", nowContent[@"HeWeather6"][0][@"daily_forecast"][0][@"vis"]];
        
        _maximumTemperatureString = nowContent[@"HeWeather6"][0][@"daily_forecast"][0][@"tmp_max"];
        _minimumTemperatureString = nowContent[@"HeWeather6"][0][@"daily_forecast"][0][@"tmp_min"];
        
        _futuredayWeatherArray = [[NSArray alloc] init];
        _futurehourWeatherArray = [[NSArray alloc] init];
    }
    return self;
}

@end
