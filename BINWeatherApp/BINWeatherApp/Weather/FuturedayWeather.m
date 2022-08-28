//
//  FuturedayWeather.m
//  BINWeatherApp
//
//  Created by Binw on 2022/8/27.
//

#import "FuturedayWeather.h"

@implementation FuturedayWeather

- (instancetype)initWithJSON:(id)weatherJSON index:(NSInteger)index
{
    if (self = [super init]) {
        _dayInWeekString = weatherJSON[@"result"][@"futureDay"][index][@"week"];
        _weatherIconString = weatherJSON[@"result"][@"futureDay"][index][@"wtIcon1"];
        _maximumTemperatureString = weatherJSON[@"result"][@"futureDay"][index][@"wtTemp1"];
        _minimumTemperatureString = weatherJSON[@"result"][@"futureDay"][index][@"wtTemp2"];
    }
    return self;
}

@end
