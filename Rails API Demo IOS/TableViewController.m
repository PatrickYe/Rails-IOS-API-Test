//
//  TableViewController.m
//  Rails API Demo IOS
//
//  Created by DX066-XL on 2014-03-10.
//  Copyright (c) 2014 DX066-XL. All rights reserved.
//

#import "TableViewController.h"
#import "user.h"
#import "HTTPHelper.h"

@interface TableViewController ()
@property NSMutableArray* users;
@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.users = [[NSMutableArray alloc] init];
    NSString * response = [HTTPHelper getResponse:@"http://192.168.10.176:3000/users.json"];
    
    NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    for (int i = 0; i < jsonObject.count; i++) {
        User *user = [[User alloc] init];
        NSDictionary *curuser = [jsonObject objectAtIndex:i];
        user.firstName = [curuser objectForKey:@"first_name"];
        user.lastName = [curuser objectForKey:@"last_name"];
        [self.users addObject:user];
    }
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    User *curUser = (User *)[self.users objectAtIndex:indexPath.row];
    
    cell.textLabel.text = curUser.firstName;
    cell.detailTextLabel.text = curUser.lastName;
    
    return cell;
}

@end
