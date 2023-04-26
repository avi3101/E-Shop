//
//  LoginViewController.m
//  ObjectiveCBlock
//
//  Created by Avinash Rai on 12/04/23.
//

#import "LoginViewController.h"

#import "SceneDelegate.h"
@interface LoginViewController ()

@property (nonatomic) UITextField *usernameTextField;
@property (nonatomic) UITextField *passwordTextField;
@property (nonatomic) UIButton *loginButton;

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc]initWithRed:205.0/255.0 green:210.0/255.0 blue:217.0/255.0 alpha:1];
    self.usernameTextField = [[UITextField alloc] init];
    self.usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.usernameTextField.placeholder = @"Username";
    self.usernameTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.usernameTextField];

    // Create password text field
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTextField.placeholder = @"Password";
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.passwordTextField];

    // Create login button
    self.loginButton = [[UIButton alloc] init];
    self.loginButton.backgroundColor = [UIColor blueColor];
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    self.loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.loginButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    
    //setting autolayout constrainsts
    [self configureConstraints];
}

#pragma -private methods

- (void)loginButtonPressed {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;

    NSString *adminUserName = [[NSUserDefaults standardUserDefaults]stringForKey:@"userName"];
    NSLog(@"name : %@",adminUserName);
    NSString *adminPassword = [[NSUserDefaults standardUserDefaults]stringForKey:@"password"];
    if ([username isEqualToString:adminUserName] && [password isEqualToString:adminPassword]) {
        // Login successful, navigate to main page
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isUserLoggedIn"];
        
        id<UIWindowSceneDelegate> sceneDelegate = (id<UIWindowSceneDelegate>)[[UIApplication sharedApplication].connectedScenes.allObjects firstObject].delegate;
        if ([sceneDelegate respondsToSelector:@selector(changeViewController)]) {
            [sceneDelegate performSelector:@selector(changeViewController) withObject:nil];
        }


        } else {
        // Login failed, show error message
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Invalid username or password." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        }
        }

- (void) configureConstraints {
    [NSLayoutConstraint activateConstraints:@[
        [_usernameTextField.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100],
        [_usernameTextField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [_usernameTextField.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.4],
        [_passwordTextField.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:150],
        [_passwordTextField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [_passwordTextField.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.4],
        [_loginButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:250],
        [_loginButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [_loginButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.4],
        
        ]];
    
}
@end
