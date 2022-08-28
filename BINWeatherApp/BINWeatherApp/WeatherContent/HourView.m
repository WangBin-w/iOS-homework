//
//  HourView.m
//  BINWeatherApp
//
//  Created by Binw on 2022/8/28.
//

#import "HourView.h"

@implementation HourView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.frame = CGRectMake(0, 0, frame.size.width, 50);
        _timeLabel.text = @"现在";
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:25];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_timeLabel];
        
        _weatherImageView = [[UIImageView alloc] init];
        _weatherImageView.frame = CGRectMake(35, 50, 40, 30);
        [self addSubview:_weatherImageView];
        
        _temperatureLabel = [[UILabel alloc] init];
        _temperatureLabel.frame = CGRectMake(0, 90, frame.size.width, 40);
        _temperatureLabel.text = @"10°";
        _temperatureLabel.textColor = [UIColor whiteColor];
        _temperatureLabel.font = [UIFont fontWithName:@"Arial" size:25];
        _temperatureLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_temperatureLabel];
    }
    return self;
}

@end
