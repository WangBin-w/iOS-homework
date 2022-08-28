//
//  WeatherContentViewController.m
//  BINWeatherApp
//
//  Created by Binw on 2022/8/27.
//

#import "WeatherContentViewController.h"
#import "WeatherContentView.h"
#import "WeatherModel.h"
#import "Masonry.h"

@interface WeatherContentViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIView *contentFootView;
@property (nonatomic, strong) UIPageControl *contentPageControl;

@property (nonatomic, assign) NSInteger screenWidth;
@property (nonatomic, assign) NSInteger screenHeight;

@end

@implementation WeatherContentViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.view.backgroundColor = [UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _screenWidth = self.view.frame.size.width;
    _screenHeight = self.view.frame.size.height;
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [self.view addSubview:backgroundImageView];

    [self setupView];
}

- (void)setupView
{
    [self.view addSubview:self.contentScrollView];
    [self.view addSubview:self.contentFootView];
    [self.contentFootView addSubview:self.contentPageControl];

    [self.contentFootView mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(self.screenWidth, 60));
        make.left.bottom.equalTo(self.view);
    }];
    [self.contentPageControl mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(300, 32));
        make.left.equalTo(self.contentFootView).offset((self.screenWidth - 300) / 2);
        make.top.equalTo(self.contentFootView).offset(5);
    }];


    for (NSInteger index = 0; index < [_locationNameMutableArray count]; index++) {
        WeatherContentView *weatherContentView = [[WeatherContentView alloc] initWithFrame:CGRectMake(_screenWidth * index, 0, _screenWidth, _screenHeight - 60)];
        [weatherContentView updateDataWithWeatherModel:_weatherModelArray[index] atLocationString:_locationNameMutableArray[index]];
        [self.contentScrollView addSubview:weatherContentView];
    }
}

- (NSMutableArray *)locationNameMutableArray
{
    if (!_locationNameMutableArray) {
        _locationNameMutableArray = [[NSMutableArray alloc] init];
    }
    return _locationNameMutableArray;
}

- (UIView *)contentFootView
{
    if (!_contentFootView) {
        _contentFootView = [[UIView alloc] init];
        _contentFootView.backgroundColor = [UIColor grayColor];
        _contentFootView.alpha = 0.5;
    }
    return _contentFootView;
}

- (UIPageControl *)contentPageControl
{
    if (!_contentPageControl) {
        _contentPageControl = [[UIPageControl alloc] init];
        _contentPageControl.numberOfPages = [_locationNameMutableArray count];
        _contentPageControl.currentPage = _locationIndex;
        [_contentPageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    }
    return _contentPageControl;
}

- (UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _contentScrollView.delegate = self;
        _contentScrollView.contentSize = CGSizeMake(_contentScrollView.frame.size.width * [_locationNameMutableArray count], _contentScrollView.frame.size.height - 60);
        _contentScrollView.tag = 11;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        
        [_contentScrollView setContentOffset:CGPointMake(_contentScrollView.frame.size.width * _locationIndex, 0) animated:YES];
    }
    return _contentScrollView;
}

- (void)changePage:(id)sender
{
    [UIView animateWithDuration:0.3f animations:^{
        NSInteger whichPage = self.contentPageControl.currentPage;
        self.contentScrollView.contentOffset = CGPointMake(self.screenWidth * whichPage, 0);
    }];
}

# pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag == 11) {
        CGPoint offset = scrollView.contentOffset;
        self.contentPageControl.currentPage = offset.x / _screenWidth;
    }
}

@end
