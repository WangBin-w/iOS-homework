//
//  WeatherContentView.m
//  BINWeatherApp
//
//  Created by Binw on 2022/8/21.
//

#import "WeatherContentView.h"
#import "WeatherModel.h"
#import "FuturedayWeather.h"
#import "FuturehourWeather.h"
#import "HourView.h"
#import "WeekTableViewCell.h"
#import "WeatherConditionTableViewCell.h"

@interface WeatherContentView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *conditionKeyPathNameArray;
@property (nonatomic, strong) NSArray *weatherModelArray;
@property(nonatomic, strong) WeatherModel *weatherModel;

@end


@implementation WeatherContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        _contentHeadView = [[WeatherContentHeadView alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 20, 260)];
        _contentHeadView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        [self addSubview:_contentHeadView];
        
        _contentTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.backgroundColor = [UIColor clearColor];
        [_contentTableView registerClass:[WeekTableViewCell class] forCellReuseIdentifier:@"WeekTableViewCellIndentifiy"];
        [_contentTableView registerClass:[WeatherConditionTableViewCell class] forCellReuseIdentifier:@"WeatherConditionTableViewCellIndentifiy"];
        
        _contentTableView.showsVerticalScrollIndicator = NO;
        [self addSubview:_contentTableView];
        // _contentTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        
        _hoursScrollView = [[UIScrollView alloc] init];
        _hoursScrollView.frame = CGRectMake(10, 265, self.frame.size.width -  20, 130);
        _hoursScrollView.layer.cornerRadius = 10;
        _hoursScrollView.contentSize = CGSizeMake(120 * 24, 130);
        _hoursScrollView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        _hoursScrollView.showsVerticalScrollIndicator = NO;
        _hoursScrollView.showsHorizontalScrollIndicator = NO;
        
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor clearColor];
        contentView.frame = CGRectMake(0, 0, self.frame.size.width, 400);
        [contentView addSubview:_contentHeadView];
        [contentView addSubview:_hoursScrollView];
        _contentTableView.tableHeaderView = contentView;
    }
    return self;
}

- (void)updateDataWithWeatherModel:(WeatherModel *)weatherModel atLocationString:(NSString *)locationString
{
    _weatherModel = [[WeatherModel alloc] init];
    _weatherModel = weatherModel;
    [_contentHeadView updateDataWithWeatherModel:weatherModel atLocationString:locationString];
    
    for (NSInteger index = 0; index < 24; index++) {
        HourView *hoursView = [[HourView alloc] initWithFrame:CGRectMake(120 * index, 0, 120, 130)];
        
        if (index < [_weatherModel.futurehourWeatherArray count]) {
            FuturehourWeather *futurehourWeather = [[FuturehourWeather alloc] init];
            futurehourWeather = _weatherModel.futurehourWeatherArray[index];
            
            hoursView.timeLabel.text = futurehourWeather.dateYmdh;
            hoursView.weatherImageView.image = [UIImage imageNamed:futurehourWeather.weatherIconString];
            hoursView.temperatureLabel.text = futurehourWeather.currentTemperatureString;
        }
        [_hoursScrollView addSubview:hoursView];
    }
}

- (NSArray *)currentWeatherCondintionArray
{
    if (!_currentWeatherCondintionArray) {
        _currentWeatherCondintionArray = @[@"日出", @"日落", @"降雨概率", @"湿度", @"风", @"体感温度", @"降水量", @"气压", @"能见度", @"紫外线指数"];
    }
    return _currentWeatherCondintionArray;
}

- (NSArray *)conditionKeyPathNameArray
{
    if (!_conditionKeyPathNameArray) {
        _conditionKeyPathNameArray = @[@"sunriseTimeString", @"sunsetTimeString", @"probabilityOfPrecipitationString", @"humidityString", @"windDirectionAndSpeedString", @"felAirTemperatureString", @"precipitationString", @"airPressureString", @"visibilityString"];
    }
    return _conditionKeyPathNameArray;
}
# pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 6;
    } else{
        return 9;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    } else {
        return 80;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        WeekTableViewCell *weekTableViewCell = [_contentTableView dequeueReusableCellWithIdentifier:@"WeekTableViewCellIndentifiy" forIndexPath:indexPath];
        FuturedayWeather *futuredayWeather = [[FuturedayWeather alloc] init];
        if ([_weatherModel.futuredayWeatherArray count] > indexPath.row) {
            futuredayWeather = [_weatherModel.futuredayWeatherArray objectAtIndex:indexPath.row];

            weekTableViewCell.dayInWeekLabel.text = futuredayWeather.dayInWeekString;
            weekTableViewCell.weatherIconImageView.image = [UIImage imageNamed:futuredayWeather.weatherIconString];
            weekTableViewCell.minimumTemperatureLabel.text = futuredayWeather.minimumTemperatureString;
            weekTableViewCell.maximumTemperatureLabel.text = futuredayWeather.maximumTemperatureString;
        }
        return weekTableViewCell;
    } else {
        WeatherConditionTableViewCell *cell = [_contentTableView dequeueReusableCellWithIdentifier:@"WeatherConditionTableViewCellIndentifiy" forIndexPath:indexPath];
        cell.titleLabel.text = self.currentWeatherCondintionArray[indexPath.row];
        cell.conditionLabel.text = [_weatherModel valueForKey:self.conditionKeyPathNameArray[indexPath.row]];
        return cell;
    }
}

@end
