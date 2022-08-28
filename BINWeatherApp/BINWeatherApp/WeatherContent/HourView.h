//
//  HourView.h
//  BINWeatherApp
//
//  Created by Binw on 2022/8/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HourView : UIView

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *weatherImageView;
@property (nonatomic, strong) UILabel *temperatureLabel;

@end

NS_ASSUME_NONNULL_END
