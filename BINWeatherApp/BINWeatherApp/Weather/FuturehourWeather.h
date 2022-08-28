//
//  FuturehourWeather.h
//  BINWeatherApp
//
//  Created by Binw on 2022/8/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FuturehourWeather : NSObject

@property NSString *dateYmdh;
@property(nonatomic, strong) NSString *weatherIconString;
@property(nonatomic, strong) NSString *currentTemperatureString;

- (instancetype)initWithJSON:(id)weatherJSON index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
