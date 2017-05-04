//
//  ViewController.m
//  TableView
//
//  Created by user on 31.03.17.
//  Copyright © 2017 iPodium. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "TableViewController.h"

@interface ViewController ()

@property (strong, nonatomic) Person *person;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *firstNamePersonField;
@property (weak, nonatomic) IBOutlet UITextField *lastNamePersonField;
@property (weak, nonatomic) IBOutlet UITextField *sexPersonField;
@property (weak, nonatomic) IBOutlet UITextField *agePersonField;
@property (weak, nonatomic) IBOutlet UITextField *countryPersonField;

@property (strong, nonatomic) NSArray *sex;
@property (strong, nonatomic) NSArray *countries;

@property (weak, nonatomic) IBOutlet UIView *sexPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *sexPicker;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sexPickerViewBottom;

@property (weak, nonatomic) IBOutlet UIView *agePickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *agePicker;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *agePickerViewBottom;

@property (weak, nonatomic) IBOutlet UIView *countryPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *countryPicker;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *countryPickerViewBottom;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Добавление";
    
    self.person = [[Person alloc] init];
    
    self.sex = [[NSArray alloc] initWithObjects:@"Мужской", @"Женский", nil];
    
    self.agePicker.maximumDate = [NSDate date];
    [self.agePicker addTarget:self action:@selector(pickerAgeValueChanged) forControlEvents:UIControlEventValueChanged];
    self.countries = [NSLocale ISOCountryCodes];
    
    self.sexPickerViewBottom.constant = -256;
    self.agePickerViewBottom.constant = -256;
    self.countryPickerViewBottom.constant = -256;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"backToTable"]) {
        self.person.firstName = self.firstNamePersonField.text;
        self.person.lastName = self.lastNamePersonField.text;
        self.person.sex = self.sexPersonField.text;
        self.person.age = self.agePersonField.text;
        self.person.country = self.countryPersonField.text;
        
        TableViewController *dest = [segue destinationViewController];
        [dest addPerson: self.person];
    }
}

- (IBAction)addPersonButton:(id)sender {
    if (self.firstNamePersonField.text.length) {
        self.person.firstName = self.firstNamePersonField.text;
        self.person.lastName = self.lastNamePersonField.text;
        self.person.sex = self.sexPersonField.text;
        self.person.age = self.agePersonField.text;
        self.person.country = self.countryPersonField.text;
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Keyboard Notifications

- (void)subscribeToKeyboardNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(keyboarDidChange:)
                               name:UIKeyboardWillShowNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(keyboarDidChange:)
                               name:UIKeyboardWillChangeFrameNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(keyboardDidHide:)
                               name:UIKeyboardWillHideNotification
                             object:nil];
}

- (void)unsubscribeFromKeyboardNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self
                                  name:UIKeyboardWillShowNotification
                                object:nil];
    [notificationCenter removeObserver:self
                                  name:UIKeyboardWillChangeFrameNotification
                                object:nil];
    [notificationCenter removeObserver:self
                                  name:UIKeyboardWillHideNotification
                                object:nil];
}

- (void)keyboarDidChange:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.size.height, 0);
    [UIView animateWithDuration:duration animations:^{
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.contentSize.width - 1,
                                                        self.scrollView.contentSize.height - 1, 1, 1) animated:YES];
    }];
}

- (void)keyboardDidHide:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.scrollView.contentInset = UIEdgeInsetsZero;
    }];
}

#pragma mark - Text Fields

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.sexPersonField || textField == self.agePersonField || textField == self.countryPersonField) {
        if ([textField isEqual:self.sexPersonField]) {
            self.sexPickerViewBottom.constant = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.scrollView.contentInset = UIEdgeInsetsZero;
                [self.view layoutIfNeeded];
            }];
        }
        else if ([textField isEqual:self.agePersonField]) {
            self.agePickerViewBottom.constant = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.scrollView.contentInset = UIEdgeInsetsZero;
                [self.view layoutIfNeeded];
            }];
        }
        else if ([textField isEqual:self.countryPersonField]) {
            self.countryPickerViewBottom.constant = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.scrollView.contentInset = UIEdgeInsetsZero;
                [self.view layoutIfNeeded];
            }];
        }
        [self.view endEditing:YES];
        return NO;
    }
    else {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.firstNamePersonField]) {
        [self.lastNamePersonField becomeFirstResponder];
    } else if ([textField isEqual:self.lastNamePersonField]) {
        [self.sexPersonField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isEqual:self.firstNamePersonField] || [textField isEqual:self.lastNamePersonField]) {
        NSCharacterSet *tolkoBukvy = [[NSCharacterSet letterCharacterSet] invertedSet];
        NSArray *chek = [string componentsSeparatedByCharactersInSet:tolkoBukvy];
        if ([chek count] > 1) return NO;
        NSString *ogranichitel = [textField.text stringByReplacingCharactersInRange:range withString:string];
        return [ogranichitel length] <= 20;
    }
    return YES;
}


#pragma mark - Pickers

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.sexPicker) {
        return self.sex.count;
    }
    else {
        return self.countries.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.sexPicker) {
        return self.sex[row];
    }
    else {
        return [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:self.countries[row]];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.sexPicker) {
        self.sexPersonField.text = self.sex[row];
    }
    else {
        self.countryPersonField.text = [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:self.countries[row]];
    }
}

- (void) pickerAgeValueChanged {
    self.eventDate = self.agePicker.date;
    NSString *dateString = [NSDateFormatter localizedStringFromDate:self.eventDate dateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterNoStyle];
    self.agePersonField.text = [NSString stringWithFormat:@"%@", dateString];
}

- (IBAction)sexPickerHideButton:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.sexPickerViewBottom.constant = -256;
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentInset = UIEdgeInsetsZero;
        [self.view layoutIfNeeded];
    }];
    [UIView commitAnimations];
}
- (IBAction)agePickerHideButton:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.agePickerViewBottom.constant = -256;
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentInset = UIEdgeInsetsZero;
        [self.view layoutIfNeeded];
    }];
    [UIView commitAnimations];
}

- (IBAction)countryPickerHideButton:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.countryPickerViewBottom.constant = -256;
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentInset = UIEdgeInsetsZero;
        [self.view layoutIfNeeded];
    }];
    [UIView commitAnimations];
}

@end
