//
//  Person.h
//  TableView
//
//  Created by user on 03.04.17.
//  Copyright © 2017 iPodium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *country;

+ (Person *)personWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;

@end
