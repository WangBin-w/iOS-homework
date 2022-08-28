//
//  weekTableViewCell.m
//  BINWeatherApp
//
//  Created by Binw on 2022/8/22.
//

#import "WeekTableViewCell.h"

@implementation WeekTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _dayInWeekLabel = [[UILabel alloc] init];
        _dayInWeekLabel.frame = CGRectMake(20, 5, 80, 40);
        _dayInWeekLabel.text = @"今天";
        _dayInWeekLabel.textColor = [UIColor orangeColor];
        _dayInWeekLabel.font = [UIFont systemFontOfSize:25];
        [self.contentView addSubview:_dayInWeekLabel];
        
        _weatherIconImageView = [[UIImageView alloc] init];
        _weatherIconImageView.frame = CGRectMake( 147.5, 10, 40, 30);
        [self.contentView addSubview:_weatherIconImageView];
        
        _minimumTemperatureLabel = [[UILabel alloc] init];
        _minimumTemperatureLabel.frame = CGRectMake(235, 5, 50, 40);
        _minimumTemperatureLabel.text = @"10°";
        _minimumTemperatureLabel.textColor = [UIColor orangeColor];
        _minimumTemperatureLabel.font = [UIFont systemFontOfSize:25];
        [self.contentView addSubview:_minimumTemperatureLabel];
        
        _maximumTemperatureLabel = [[UILabel alloc] init];
        _maximumTemperatureLabel.frame = CGRectMake(305, 5, 50, 40);
        _maximumTemperatureLabel.text = @"25°";
        _maximumTemperatureLabel.textColor = [UIColor orangeColor];
        _maximumTemperatureLabel.font = [UIFont systemFontOfSize:25];
        [self.contentView addSubview:_maximumTemperatureLabel];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
