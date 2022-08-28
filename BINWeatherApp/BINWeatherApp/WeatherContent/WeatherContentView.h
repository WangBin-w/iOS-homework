//
//  WeatherContentView.h
//  BINWeatherApp
//
//  Created by Binw on 2022/8/21.
//

#import <UIKit/UIKit.h>
#import "WeatherContentHeadView.h"

@class WeatherModel;
NS_ASSUME_NONNULL_BEGIN

@interface WeatherContentView : UIView

@property (nonatomic, strong) WeatherContentHeadView *contentHeadView;
@property (nonatomic, strong) UITableView *contentTableView;
@property (nonatomic, strong) UIScrollView *hoursScrollView;

@property (nonatomic, strong) NSArray *currentWeatherCondintionArray;

- (void)updateDataWithWeatherModel:(WeatherModel *)weatherModel atLocationString:(NSString *)locationString;

@end

NS_ASSUME_NONNULL_END
