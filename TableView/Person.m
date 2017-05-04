//
//  Person.m
//  TableView
//
//  Created by user on 03.04.17.
//  Copyright © 2017 iPodium. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (Person *)personWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    return [[Person alloc] initWithFirstName:firstName lastName:lastName];
}

- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    self = [super init];
    if (self) {
        _firstName = firstName;
        _lastName = lastName;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Имя: %@\n Фамилия: %@\n Пол: %@\n День Рождения: %@\n Страна: %@\n", self.firstName, self.lastName, self.sex, self.age, self.country];
}

@end
