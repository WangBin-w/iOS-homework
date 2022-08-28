//
//  WeatherConditionTableViewCell.m
//  BINWeatherApp
//
//  Created by Binw on 2022/8/28.
//

#import "WeatherConditionTableViewCell.h"

@implementation WeatherConditionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(20, 20, 120, 40);
        _titleLabel.text = @"title";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:25];
        [self.contentView addSubview:_titleLabel];
        
        _conditionLabel = [[UILabel alloc] init];
        _conditionLabel.frame = CGRectMake(130, 20, 240, 40);
        _conditionLabel.text = @"condition";
        _conditionLabel.textColor = [UIColor whiteColor];
        _conditionLabel.textAlignment = NSTextAlignmentRight;
        _conditionLabel.font = [UIFont systemFontOfSize:25];
        [self.contentView addSubview:_conditionLabel];
        
        
        
       
        
        
    }
    
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextStrokeRect(context, CGRectMake(20, rect.size.height, rect.size.width -40 , 1));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
