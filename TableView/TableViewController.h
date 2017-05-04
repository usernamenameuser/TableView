//
//  TableViewController.h
//  TableView
//
//  Created by user on 04.04.17.
//  Copyright © 2017 iPodium. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Person;

@interface TableViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)addPerson:(Person *)person;

@end
