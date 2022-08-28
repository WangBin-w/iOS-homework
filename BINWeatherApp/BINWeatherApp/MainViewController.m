//
//  MainViewController.m
//  BINWeatherApp
//
//  Created by Binw on 2022/8/22.
//

#import "MainViewController.h"
#import "SearchViewController.h"
#import "MainTableViewCell.h"
#import "WeatherContent/WeatherContentViewController.h"
#import "Weather/WeatherModel.h"
#import "Weather/FuturedayWeather.h"
#import "Weather/FuturehourWeather.h"

@interface MainViewController ()<SearchViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIButton *addLocationButton;

@property (nonatomic, copy) NSArray *cityNameArray;
@property (nonatomic, copy) NSArray *temperatureArray;
@property (nonatomic, copy) NSMutableDictionary *cityTemperatureMutableDictionary;
@property (nonatomic, copy) NSMutableArray *weatherMutableArray;

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    if ([_cityTemperatureMutableDictionary count] != 0) {
        _cityNameArray = [_cityTemperatureMutableDictionary allKeys];
        _temperatureArray = [_cityTemperatureMutableDictionary allValues];
        [_tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainBackground.png"]];
    [self.view addSubview:backgroundImageView];
    
    _cityTemperatureMutableDictionary = [[NSMutableDictionary alloc] init];
    _cityNameArray = [[NSArray alloc] init];
    _temperatureArray = [[NSArray alloc] init];
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 70)];
    _headerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_headerView];
    
    _addLocationButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 30)];
    [_addLocationButton setTitle:@"添加城市，即可查看天气" forState:UIControlStateNormal];
    [_addLocationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _addLocationButton.titleLabel.font= [UIFont systemFontOfSize:24];
    _addLocationButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_addLocationButton addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
    _addLocationButton.userInteractionEnabled = YES;
    [_headerView addSubview:_addLocationButton];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 114, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _cityTemperatureMutableDictionary = [[[NSUserDefaults standardUserDefaults] objectForKey:@"cityTemperatureMutableDictionary"] mutableCopy];
    _cityNameArray = [_cityTemperatureMutableDictionary allKeys];
    _temperatureArray = [_cityTemperatureMutableDictionary allValues];
    [self updateAllData];
}

- (void)WakeUpTheMainThread
{
    
}

#pragma mark -- UIButton
- (void)searchClick:(id)sender
{
    NSLog(@"searchClick:");
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    searchViewController.delegate = self;
    [self presentViewController:searchViewController animated:YES completion:nil];
}

#pragma mark --SearchViewControllerDelegate
- (void)searchWithLoacationString:(NSString *)locationString{
    NSArray *cityKey =  [_cityTemperatureMutableDictionary allKeys];
    if (![cityKey containsObject:locationString]) {
        [_cityTemperatureMutableDictionary setValue:@"" forKey:locationString];
        _cityNameArray = [_cityTemperatureMutableDictionary allKeys];
    } 

    [self updateAllData];
}

- (void)updateAllData
{
    _weatherMutableArray = [[NSMutableArray alloc] init];
    // contentView网页请求. 和风天气API
    for (NSString *location in _cityNameArray) {
        // 主界面网页请求
        NSString *urlString = [NSString stringWithFormat:@"https://free-api.heweather.com/s6/weather?location=%@&key=9f24a96156ad40cb9db5e064d698081e",location];
        NSURL *mainURL = [NSURL URLWithString:urlString];
        NSURLRequest *mainRequest = [NSURLRequest requestWithURL:mainURL];
        NSURLSession *mainSession = [NSURLSession sharedSession];
        NSURLSessionDataTask *mainDataTask = [mainSession dataTaskWithRequest:mainRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                id mainJSONSerialization = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *temperatureString = [NSString stringWithFormat:@"%@°", mainJSONSerialization[@"HeWeather6"][0][@"now"][@"tmp"]];
                [self->_cityTemperatureMutableDictionary setValue:temperatureString forKey:location];
                
                [[NSUserDefaults standardUserDefaults] setObject:[self->_cityTemperatureMutableDictionary copy] forKey:@"cityTemperatureMutableDictionary"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                self->_temperatureArray = [self->_cityTemperatureMutableDictionary allValues];
            }
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self->_tableView reloadData];
            }];
        }];
        [mainDataTask resume];
        
        __block WeatherModel *weatherModel = [[WeatherModel alloc] init];
        __weak typeof(self) weakSelf = self;
        NSString *nowContentString = [NSString stringWithFormat:@"https://free-api.heweather.com/s6/weather?location=%@&key=9f24a96156ad40cb9db5e064d698081e", location];
        
        NSURL *nowContentURL = [NSURL URLWithString:nowContentString];
        NSURLRequest *nowContentRequest = [NSURLRequest requestWithURL:nowContentURL];
        NSURLSession *nowContentSession = [NSURLSession sharedSession];
        NSURLSessionDataTask *nowContentDataTask = [nowContentSession dataTaskWithRequest:nowContentRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (error == nil) {
                WeatherModel *newWeatherModel = [[WeatherModel alloc] initWithData:data];
                weatherModel.location = location;
                if (weatherModel.futurehourWeatherArray != nil) {
                    newWeatherModel.futurehourWeatherArray = weatherModel.futurehourWeatherArray;
                }
                if (weatherModel.futuredayWeatherArray != nil) {
                    newWeatherModel.futuredayWeatherArray = weatherModel.futuredayWeatherArray;
                }
                [strongSelf->_weatherMutableArray addObject:newWeatherModel];
            } else {
                NSLog(@"网络请求失败！");
                [strongSelf->_cityTemperatureMutableDictionary removeObjectForKey:location];
            }
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self->_tableView reloadData];
            }];
        }];
        [nowContentDataTask resume];
        
        NSString *futureDayContentString = [NSString stringWithFormat:@"http://api.k780.com/?app=weather.realtime&weaId=%@&ag=today,futureDay,lifeIndex,futureHour&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json", location];
   
        futureDayContentString = [futureDayContentString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
        NSURL *futureDayContentURL = [NSURL URLWithString:futureDayContentString];
        NSURLRequest *futureDayContentRequest = [NSURLRequest requestWithURL:futureDayContentURL];
        NSURLSession *futureDayContentSession = [NSURLSession sharedSession];
        
        // Futureday
        NSURLSessionDataTask *futureDayContentDataTask = [futureDayContentSession dataTaskWithRequest:futureDayContentRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                id futuredayWeatherJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                NSMutableArray *futuredayMutableArray = [[NSMutableArray alloc] init];
                for (NSInteger index = 0; index < 6; index++) {
                    FuturedayWeather *futuredayWeather = [[FuturedayWeather alloc] initWithJSON:futuredayWeatherJSON index:index];
                    [futuredayMutableArray addObject:futuredayWeather];
                }
                weatherModel.futuredayWeatherArray = [futuredayMutableArray copy];
            }
        }];
        [futureDayContentDataTask resume];
        
        // FutureHourIndDay
        NSURLSessionDataTask *futureHourContentDataTask = [futureDayContentSession dataTaskWithRequest:futureDayContentRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                id futurehourJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSMutableArray *futurehourMutableArray = [[NSMutableArray alloc] init];
                
                for (NSInteger index = 0; index < 24; index++) {
                    FuturehourWeather *futurehourWeather = [[FuturehourWeather alloc] initWithJSON:futurehourJSON index:index];
                    [futurehourMutableArray addObject:futurehourWeather];
                }
                weatherModel.futurehourWeatherArray = [futurehourMutableArray copy];
            } else {
                NSLog(@"网络请求失败！");
            }
        }];
        [futureHourContentDataTask resume];
    }
}


#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_temperatureArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell *mainTableViewCell = [[MainTableViewCell alloc] init];
    mainTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    mainTableViewCell.locationLabel.text = _cityNameArray[indexPath.row];
    mainTableViewCell.temperatureLabel.text = _temperatureArray[indexPath.row];

    return mainTableViewCell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath: %ld", (long)indexPath.row);
    WeatherContentViewController * weatherContentViewController = [[WeatherContentViewController alloc] init];
    weatherContentViewController.locationNameMutableArray = [_cityNameArray mutableCopy];
    weatherContentViewController.locationIndex = indexPath.row;
    weatherContentViewController.weatherModelArray = _weatherMutableArray;
    
    //在跳转前唤醒主线程
    [self performSelectorOnMainThread:@selector(WakeUpTheMainThread) withObject:nil waitUntilDone:NO];
    [self.navigationController pushViewController:weatherContentViewController animated:YES];
    
}

@end
