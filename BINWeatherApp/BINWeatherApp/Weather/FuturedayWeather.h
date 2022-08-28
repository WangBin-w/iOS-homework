//
//  FuturedayWeather.h
//  BINWeatherApp
//
//  Created by Binw on 2022/8/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FuturedayWeather : NSObject

@property(nonatomic, strong) NSString *dayInWeekString;
@property(nonatomic, strong) NSString *weatherIconString;
@property(nonatomic, strong) NSString *maximumTemperatureString;
@property(nonatomic, strong) NSString *minimumTemperatureString;

- (instancetype)initWithJSON:(id)weatherJSON index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
