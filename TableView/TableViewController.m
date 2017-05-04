//
//  TableViewController.m
//  TableView
//
//  Created by user on 04.04.17.
//  Copyright © 2017 iPodium. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "Person.h"
#import "PersonCell.h"
#import "TableViewCell.h"

@interface TableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *persons;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.persons = [@[] mutableCopy];
}

- (IBAction)backToTable:(UIStoryboardSegue *)segue {
    
}

- (void)addPerson:(Person *)person {
    [self.persons addObject:person];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.persons.count -1 inSection:0];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

#pragma mark - UITableView Data Sourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.persons.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.persons.count) {
        NSString *identifier = NSStringFromClass([PersonCell class]);
        PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        Person *person = self.persons[indexPath.row];
        [cell fillWithPerson:person];
        
        return cell;
    } else {
        return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableViewCell class])];
    }
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.persons.count) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
