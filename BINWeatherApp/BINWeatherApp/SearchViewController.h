//
//  SearchViewController.h
//  BINWeatherApp
//
//  Created by Binw on 2022/8/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SearchViewControllerDelegate <NSObject>

- (void)searchWithLoacationString:(NSString *)locationString;

@end

@interface SearchViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *searchMutableArray;
@property (nonatomic, weak) id<SearchViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
