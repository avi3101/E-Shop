//
//  AccountViewController.m
//  ObjectiveCBlock
//
//  Created by Avinash Rai on 28/03/23.
//

#import "AccountViewController.h"
#import "SceneDelegate.h"

@interface AccountViewController ()
@property (nonatomic) UIImageView *image;
@property (nonatomic) UILabel *firstName;
@property (nonatomic) UILabel *lastName;
@property (nonatomic) UILabel *email;
@property (nonatomic) UIButton *logoutButton;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor alloc]initWithRed:205.0/255.0 green:210.0/255.0 blue:217.0/255.0 alpha:1];
    [self setupView];
    [self configureContrainsts];
}

#pragma mark - Private Method

-(void)setupView {
    
    _image = [[UIImageView alloc]initWithFrame:CGRectZero];
    _image.image = [UIImage imageNamed:@"avinash"];
    _image.layer.cornerRadius=120;
    _image.layer.masksToBounds = YES;
    _image.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: _image];
    
    _firstName = [[UILabel alloc]initWithFrame:CGRectZero];
    _firstName.text = @"Avinash";
    [_firstName setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    _firstName.textColor = UIColor.systemBlueColor;
    [_firstName sizeToFit];
    _firstName.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_firstName];
    
    _lastName = [[UILabel alloc]initWithFrame:CGRectZero];
    _lastName.text = @"Rai";
    [_lastName setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    _lastName.textColor = UIColor.systemBlueColor;
    [_lastName sizeToFit];
    _lastName.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_lastName];
    
    _email = [[UILabel alloc]initWithFrame:CGRectZero];
    [_email sizeToFit];
    [_email setFont:[UIFont fontWithName:@"Helvetica" size:20]];    _email.translatesAutoresizingMaskIntoConstraints = NO;
    _email.text = @"avinash.rai@rsllearning.com";
    [self.view addSubview:_email];
    
    _logoutButton = [[UIButton alloc]initWithFrame:CGRectZero];
    [_logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    [_logoutButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    _logoutButton.titleLabel.font = [UIFont systemFontOfSize: 20.0];
    [_logoutButton addTarget:self action:@selector(logoutButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    _logoutButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_logoutButton];

}

-(void)logoutButtonTapped {
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isUserLoggedIn"];
    [self.tabBarController setSelectedIndex:0];
    
    id<UIWindowSceneDelegate> sceneDelegate = (id<UIWindowSceneDelegate>)[[UIApplication sharedApplication].connectedScenes.allObjects firstObject].delegate;
    if ([sceneDelegate respondsToSelector:@selector(goToLoginViewController)]) {
        [sceneDelegate performSelector:@selector(goToLoginViewController) withObject:nil];
    }
    
}

-(void)configureContrainsts {
    [NSLayoutConstraint activateConstraints:@[
        [_image.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:50],
        [_image.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.7],
        [_image.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.3],
        [_image.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        
        [_firstName.topAnchor constraintEqualToAnchor:_image.bottomAnchor constant:50],
         [_firstName.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
          
          [_lastName.topAnchor constraintEqualToAnchor:_firstName.bottomAnchor constant:30],
         [_lastName.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [_email.topAnchor constraintEqualToAnchor:_lastName.bottomAnchor constant:30],
       [_email.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        
       
        [_logoutButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [_logoutButton.topAnchor constraintEqualToAnchor:_email.bottomAnchor constant:30]
       
        
    ]];
}
    
@end
