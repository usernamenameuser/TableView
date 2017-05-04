//
//  ViewController.h
//  TableView
//
//  Created by user on 31.03.17.
//  Copyright © 2017 iPodium. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSDate *eventDate;

@end

