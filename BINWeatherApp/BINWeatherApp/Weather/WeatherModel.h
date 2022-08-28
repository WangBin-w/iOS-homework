//
//  WeatherModel.h
//  BINWeatherApp
//
//  Created by Binw on 2022/8/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherModel : NSObject

@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *weatherDescriptionString;
@property (nonatomic, strong) NSString *currentTemperatureString;
@property (nonatomic, strong) NSString *sunriseTimeString;
@property (nonatomic, strong) NSString *sunsetTimeString;
@property (nonatomic, strong) NSString *probabilityOfPrecipitationString;
@property (nonatomic, strong) NSString *humidityString;
@property (nonatomic, strong) NSString *windDirectionAndSpeedString;
@property (nonatomic, strong) NSString *felAirTemperatureString;
@property (nonatomic, strong) NSString *precipitationString;
@property (nonatomic, strong) NSString *airPressureString;
@property (nonatomic, strong) NSString *visibilityString;

@property (nonatomic, strong) NSString *maximumTemperatureString;
@property (nonatomic, strong) NSString *minimumTemperatureString;

@property (nonatomic, strong) NSArray *futuredayWeatherArray;
@property (nonatomic, strong) NSArray *futurehourWeatherArray;

- (instancetype)initWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
