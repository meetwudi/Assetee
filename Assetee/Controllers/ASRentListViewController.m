//
//  ASRentListViewController.m
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import "ASRentListViewController.h"
#import "ASAssetManager.h"
#import "ASRentListCell.h"
#import "ASDateFormatter.h"
#import <AVOSCloud/AVOSCloud.h>
#import "CoreDataManager.h"

@interface ASRentListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) NSArray *rentItems;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation ASRentListViewController

@synthesize rentItems = _rentItems;


#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureTableView];
}

-(void)viewDidAppear:(BOOL)animated {
    [self reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI
- (void)configureTableView {
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 100.0f)];
    [self.refreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    self.tableView.tableHeaderView = [[UIView alloc] init];
    [self.tableView.tableHeaderView addSubview:self.refreshControl];
}

#pragma mark - Getter & Setter
-(NSArray *)rentItems {
    if (!_rentItems) {
        _rentItems = [NSArray array];
    }
    return _rentItems;
}

-(void)setRentItems:(NSArray *)rentItems {
    _rentItems = rentItems;
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

#pragma mark - Data
- (void)refreshData:(__unused id)sender {
    // Clear local data
    [[CoreDataManager sharedManager] clearData];
    
    // Fetch data from server
    __weak ASRentListViewController *weakSelf = self;
    ASAssetManager *rentItemsManager = [ASAssetManager sharedManager];
    [rentItemsManager fetchRentItemsWithComplete:^(NSArray *items) {
        // Synchronize
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",[NSDate timeIntervalSinceReferenceDate]] forKey:@"updateDate"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        weakSelf.rentItems = items;
        
        // Write new data to local database
        [[CoreDataManager sharedManager] writeData:items];
    }];
}

- (void)reloadData {
    // Show activity indicator
    [self.refreshControl beginRefreshing];
    
//    NSString *updateDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"updateDate"];
    NSString *updateDate = nil;
    if (!updateDate) {
        // The first time
        [self refreshData:nil];
    } else {
        NSTimeInterval update = updateDate.doubleValue;
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        if ((now - update) > 3 * 60 * 60) {
            // Refresh
            [self refreshData:nil];
        } else {
            // Read local data
            self.rentItems = [[CoreDataManager sharedManager] readData];
        }
    }
}

#pragma mark - Tableview delegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.rentItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __block ASRentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentItemCell"];
    
    // Not a good solution
    // TODO: unify format
    id rentItem = [self.rentItems objectAtIndex:indexPath.row];
    if ([rentItem isKindOfClass:[AVObject class]]) {
        rentItem = (AVObject *)rentItem;
        [cell configureCellWithDictionary:@{
                                            @"name": [rentItem valueForKey:@"name"],
                                            @"rentDate": [[ASDateFormatter zhDateFormatter] stringFromDate:[rentItem valueForKey:@"rentDate"]],
                                            @"renterName": [rentItem valueForKey:@"renterName"],
                                            @"renterPhone": [rentItem valueForKey:@"renterPhone"],
                                            @"snapshot": [[rentItem objectForKey:@"snapshot"] getData:nil]}];
    } else if ([rentItem isKindOfClass:[NSDictionary class]]) {
        [cell configureCellWithDictionary:rentItem];
    }
    
    return cell;
}

@end
