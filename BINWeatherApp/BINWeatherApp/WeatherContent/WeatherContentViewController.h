//
//  WeatherContentViewController.h
//  BINWeatherApp
//
//  Created by Binw on 2022/8/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WeatherModel;

@interface WeatherContentViewController : UIViewController

@property (nonatomic) NSMutableArray *locationNameMutableArray;
@property (nonatomic, assign) NSInteger locationIndex;
@property (nonatomic, strong) NSArray *weatherModelArray;

@end

NS_ASSUME_NONNULL_END
