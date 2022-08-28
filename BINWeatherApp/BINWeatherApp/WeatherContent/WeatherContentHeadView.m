//
//  WeatherContentHeadView.m
//  BINWeatherApp
//
//  Created by Binw on 2022/8/21.
//

#import "WeatherContentHeadView.h"
#import "WeatherModel.h"
#import "Masonry.h"

@implementation WeatherContentHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 10;
        [self addSubview:self.locationLabel];
        [self addSubview:self.temperatureLabel];
        [self addSubview:self.weatherLabel];
        [self addSubview:self.weekdayLabel];
        [self addSubview:self.todayLabel];
        [self addSubview:self.maxMinTemperatureLable];
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(200, 50));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(0);
    }];
    [self.temperatureLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(200, 130));
        make.centerX.equalTo(self);
        make.top.mas_equalTo(self.locationLabel.mas_bottom);
    }];
    [self.weatherLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.centerX.equalTo(self);
        make.top.mas_equalTo(self.temperatureLabel.mas_bottom);
    }];
    [self.weekdayLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.left.equalTo(self).offset(5);
        make.top.mas_equalTo(self.weatherLabel.mas_bottom).offset(15);
    }];
    [self.todayLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.left.mas_equalTo(self.weekdayLabel.mas_right);
        make.top.equalTo(self.weekdayLabel);
    }];
    [self.maxMinTemperatureLable mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.left.mas_equalTo(self.todayLabel.mas_right).offset(15);
        make.top.equalTo(self.weekdayLabel);
    }];
}

- (void)updateDataWithWeatherModel:(WeatherModel *)weatherModel atLocationString:(NSString *)locationString
{
    _locationLabel.text = locationString;
    _temperatureLabel.text = [NSString stringWithFormat:@"%@", weatherModel.currentTemperatureString];
    _weatherLabel.text = weatherModel.weatherDescriptionString;
    
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitWeekday;
    NSDateComponents *dateComponents = [gregorian components:unitFlags fromDate:date];
    NSArray *weekArray = @[@"星期六", @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五"];
    NSString *weekdayString = [NSString stringWithFormat:@"%@",weekArray[dateComponents.weekday % 7]];
    _weekdayLabel.text = weekdayString;
    
    _maxMinTemperatureLable.text = [NSString stringWithFormat:@"最高%@° 最低%@°",weatherModel.maximumTemperatureString, weatherModel.minimumTemperatureString];
}

- (UILabel *)locationLabel
{
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.textColor = [UIColor orangeColor];
        _locationLabel.textAlignment = NSTextAlignmentCenter;
        _locationLabel.font = [UIFont systemFontOfSize:35];
        _locationLabel.text = @"locationLabel";
//        _locationLabel.backgroundColor = [UIColor orangeColor];
    }
    return _locationLabel;
}

- (UILabel *)temperatureLabel
{
    if (!_temperatureLabel) {
        _temperatureLabel = [[UILabel alloc] init];
        _temperatureLabel.textColor = [UIColor orangeColor];
        _temperatureLabel.textAlignment = NSTextAlignmentCenter;
        _temperatureLabel.font = [UIFont systemFontOfSize:90];
        _temperatureLabel.text = @"temperatureLabel";
    }
    return _temperatureLabel;
}

- (UILabel *)weatherLabel
{
    if (!_weatherLabel) {
        _weatherLabel = [[UILabel alloc] init];
        _weatherLabel.textColor = [UIColor orangeColor];
        _weatherLabel.textAlignment = NSTextAlignmentCenter;
        _weatherLabel.font = [UIFont systemFontOfSize:25];
        _weatherLabel.text = @"weatherLabel";
    }
    return  _weatherLabel;
}

- (UILabel *)weekdayLabel
{
    if (!_weekdayLabel) {
        _weekdayLabel = [[UILabel alloc] init];
        _weekdayLabel.text = @"weekdayLabel";
        _weekdayLabel.textColor = [UIColor orangeColor];
        _weekdayLabel.textAlignment = NSTextAlignmentCenter;
        _weekdayLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
    }
    
    return _weekdayLabel;
}

- (UILabel *)todayLabel
{
    if (!_todayLabel) {
        _todayLabel = [[UILabel alloc] init];
        _todayLabel.textColor = [UIColor orangeColor];
        _todayLabel.textAlignment = NSTextAlignmentCenter;
        _todayLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
        _todayLabel.text = @"今天";
    }
    return  _todayLabel;
}

- (UILabel *)maxMinTemperatureLable
{
    if (!_maxMinTemperatureLable) {
        _maxMinTemperatureLable = [[UILabel alloc] init];
        _maxMinTemperatureLable.font = [UIFont fontWithName:@"Helvetica" size:25];
        _maxMinTemperatureLable.textColor = [UIColor orangeColor];
        _maxMinTemperatureLable.text = @"maxMinTemperatureLable";
    }
    return _maxMinTemperatureLable;
}

@end
