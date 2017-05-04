//
//  PersonCell.h
//  TableView
//
//  Created by user on 05.04.17.
//  Copyright © 2017 iPodium. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Person;

@interface PersonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;

- (void)fillWithPerson:(Person *)person;

@end
