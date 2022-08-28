//
//  FuturehourWeather.m
//  BINWeatherApp
//
//  Created by Binw on 2022/8/27.
//

#import "FuturehourWeather.h"

@implementation FuturehourWeather

- (instancetype)initWithJSON:(id)weatherJSON index:(NSInteger)index
{
    if (self = [super init]) {
        NSDate *date = [NSDate date];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        unsigned unitFlags = NSCalendarUnitHour;
        NSDateComponents *dateComponents = [gregorian components:unitFlags fromDate:date];
        NSInteger sumHour = dateComponents.hour - 1 + index;
        
        if (index == 0) {
            _dateYmdh = [NSString stringWithFormat:@"现在"];
        } else {
            _dateYmdh = [NSString stringWithFormat:@"%ld时", sumHour % 24];
        }
        
        _weatherIconString = weatherJSON[@"result"][@"futureHour"][index][@"wtIcon"];
        _currentTemperatureString = weatherJSON[@"result"][@"futureHour"][index][@"wtTemp"];
    }
    return self;
}

@end
