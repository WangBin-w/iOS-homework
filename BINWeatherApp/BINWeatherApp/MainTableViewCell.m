//
//  MainTableViewCell.m
//  BINWeatherApp
//
//  Created by Binw on 2022/8/22.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        _timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_timeLabel];
        
        _locationLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_locationLabel];
        
        _temperatureLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_temperatureLabel];
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    NSDate *dt = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *dateComponents = [gregorian components:unitFlags fromDate:dt];
    
    NSString *dataString  = [self stringWithTransformDateComponents:dateComponents];
    
    _locationLabel.frame = CGRectMake(20, 10, 260, 50);
    _locationLabel.textColor = [UIColor whiteColor];
    _locationLabel.font = [UIFont systemFontOfSize:35];
    
    _timeLabel.frame = CGRectMake(20, 70, 260, 30);
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.text = dataString;
    _timeLabel.font = [UIFont systemFontOfSize:23];
    
    _temperatureLabel.frame = CGRectMake(260, 10, 135, 90);
    _temperatureLabel.textColor = [UIColor whiteColor];
    _temperatureLabel.font = [UIFont systemFontOfSize:55];
}

- (NSString *)stringWithTransformDateComponents:(NSDateComponents *)dateComponents
{
    NSString *dateString = [[NSString alloc] init];
    if (dateComponents.hour < 13) {
        dateString = [NSString stringWithFormat:@"上午%02ld:%02ld", dateComponents.hour, dateComponents.minute];
    } else {
        dateComponents.hour -= 12;
        dateString = [NSString stringWithFormat:@"下午%02ld:%02ld", dateComponents.hour, dateComponents.minute];
    }
    return dateString;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
