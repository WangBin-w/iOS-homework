//
//  SearchViewController.m
//  BINWeatherApp
//
//  Created by Binw on 2022/8/22.
//

#import "SearchViewController.h"

@interface SearchViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *searchTableView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchMutableArray = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 80)];
    _searchBar.showsCancelButton = YES;
    _searchBar.delegate = self;
    _searchBar.enablesReturnKeyAutomatically = NO;
    _searchBar.barTintColor = [UIColor clearColor];
    _searchBar.tintColor = [UIColor whiteColor];
    _searchBar.placeholder = @"搜索城市";
    
    UITextField *searchTextField = [_searchBar valueForKey:@"searchField"];
    searchTextField.backgroundColor = [UIColor colorWithRed:0.17f green:0.17f blue:0.15f alpha:1.00f];
    searchTextField.textColor = [UIColor whiteColor];
    
    UIButton *cancelButton = [_searchBar valueForKey:@"cancelButton"];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    
    [_searchBar becomeFirstResponder];
    [self.view addSubview:_searchBar];
    
    _searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 124, self.view.frame.size.width, 500) style:UITableViewStylePlain];
    [_searchTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"searchResultCell"];
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    _searchTableView.backgroundColor = [UIColor clearColor];
    _searchTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_searchTableView];
}

# pragma mark -- UISearchBarDelegate
//当文字改变时触发
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.searchMutableArray removeAllObjects];
    NSString *searchString = [NSString stringWithFormat:@"https://search.heweather.net/find?location=%@&key=9f24a96156ad40cb9db5e064d698081e", searchText];
    NSURL *searchURL = [NSURL URLWithString:searchString];
    NSURLRequest *searchRequest = [NSURLRequest requestWithURL:searchURL];
    NSURLSession *searchSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *searchDataTask = [searchSession dataTaskWithRequest:searchRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id searchObjc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            for (int i = 0; i < [searchObjc[@"HeWeather6"][0][@"basic"] count]; i++) {
                [self.searchMutableArray addObject:searchObjc[@"HeWeather6"][0][@"basic"][i][@"location"]];
            }
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.searchTableView reloadData];
        }];
    }];
    [searchDataTask resume];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
# pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_searchMutableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_searchTableView dequeueReusableCellWithIdentifier:@"searchResultCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [_searchMutableArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];

    return cell;
}

# pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(searchWithLoacationString:)]) {
        [_delegate searchWithLoacationString:_searchMutableArray[indexPath.row]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    [_searchBar resignFirstResponder];
}

@end
