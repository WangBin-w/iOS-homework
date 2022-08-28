//
//  WeatherContentHeadView.h
//  BINWeatherApp
//
//  Created by Binw on 2022/8/21.
//

#import <UIKit/UIKit.h>

@class WeatherModel;

NS_ASSUME_NONNULL_BEGIN

@interface WeatherContentHeadView : UIView

@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *temperatureLabel;
@property (nonatomic, strong) UILabel *weatherLabel;
@property (nonatomic, strong) UILabel *weekdayLabel;
@property (nonatomic, strong) UILabel *todayLabel;
@property (nonatomic, strong) UILabel *maxMinTemperatureLable;

- (void)updateDataWithWeatherModel:(WeatherModel *)weatherModel atLocationString:(NSString *)locationString;

@end

NS_ASSUME_NONNULL_END
