//
//  MainTableViewCell.h
//  BINWeatherApp
//
//  Created by Binw on 2022/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *temperatureLabel;

@end

NS_ASSUME_NONNULL_END
