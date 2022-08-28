//
//  weekTableViewCell.h
//  BINWeatherApp
//
//  Created by Binw on 2022/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeekTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *dayInWeekLabel;
@property (nonatomic, strong) UIImageView *weatherIconImageView;
@property (nonatomic, strong) UILabel *minimumTemperatureLabel;
@property (nonatomic, strong) UILabel *maximumTemperatureLabel;

@end

NS_ASSUME_NONNULL_END
