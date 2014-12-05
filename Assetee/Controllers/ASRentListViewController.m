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

@interface ASRentListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) NSArray *rentItems;
@end

@implementation ASRentListViewController

@synthesize rentItems = _rentItems;


#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    [self reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
}

#pragma mark - Data

- (void) reloadData {
    // Show activity indicator
    [self.activityIndicator startAnimating];
    // Fetch rentItems from server
    __weak ASRentListViewController *weakSelf = self;
    ASAssetManager *rentItemsManager = [ASAssetManager sharedManager];
    [rentItemsManager fetchRentItemsWithComplete:^(NSArray *items) {
        weakSelf.rentItems = items;
        [weakSelf.activityIndicator stopAnimating];
    }];
}


#pragma mark - Tableview delegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.rentItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __block ASRentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentItemCell"];
    AVObject *rentItem = [self.rentItems objectAtIndex:indexPath.row];
    // set asset name
    cell.nameLabel.text = [rentItem valueForKey:@"name"];
    // set rent date
    NSDate *rentDate = [rentItem valueForKey:@"rentDate"];
    cell.rentDateLabel.text = [[ASDateFormatter zhDateFormatter] stringFromDate:rentDate];
    // set rent info
    cell.rentInfoLabel.text = [NSString stringWithFormat:@"借出给%@，电话%@",
                               [rentItem valueForKey:@"renterName"],
                               [rentItem valueForKey:@"renterPhone"]];
    AVFile *file = [rentItem objectForKey:@"snapshot"];
    
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            UIImage *image = [UIImage imageWithData:data];
            cell.snapshotImage.image = image;
    }];
    return cell;
}

@end
