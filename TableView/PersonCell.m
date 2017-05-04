//
//  PersonCell.m
//  TableView
//
//  Created by user on 05.04.17.
//  Copyright © 2017 iPodium. All rights reserved.
//

#import "PersonCell.h"
#import "Person.h"

@implementation PersonCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)fillWithPerson:(Person *)person {
    self.firstNameLabel.text = person.firstName;
    self.lastNameLabel.text = person.lastName;
}

@end
