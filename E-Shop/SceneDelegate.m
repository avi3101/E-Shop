#import "SceneDelegate.h"

#import "ViewController.h"
#import "CartViewController.h"
#import "AccountViewController.h"
#import "LoginViewController.h"

static NSString *const deeplinkURLSchema = @"deeplinking";
static NSString *const cartPageLinkURLHost = @"cart";
static NSString *const accountPageLinkURLHost = @"account";

@interface SceneDelegate ()

@property ViewController *mainView;
@property CartViewController *cartView;
@property AccountViewController *accountView;
@property LoginViewController *loginViewController;
@property UITabBarController *tabBarController;

@end

/**
 * Testing deelink URLs:
 *  - Home page: `deeplinkingdemo://home`
 *  - Cart page:  `deeplinkingdemo://cart?startTimestamp=1679904662&endTimestamp=1679731862`
 *  - Account page: `deeplinking://account
 */

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
   
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc]initWithWindowScene:windowScene];
    
   
    _tabBarController = [[UITabBarController alloc]init];
    
    
    _mainView = [[ViewController alloc]init];
    _cartView = [[CartViewController alloc]init];
    _accountView = [[AccountViewController alloc]init];
    
   
    
    UITabBarItem * item1 = [[UITabBarItem alloc]initWithTitle:@"Home" image: [UIImage imageNamed:@"home"] tag:0];
    
    
    UITabBarItem * item2 = [[UITabBarItem alloc]initWithTitle:@"My Cart" image: [UIImage imageNamed:@"cart"] tag:1];
    
    UITabBarItem * item3 = [[UITabBarItem alloc]initWithTitle:@"Account" image: [UIImage imageNamed:@"account"] tag:2];

   
    _tabBarController.tabBar.backgroundColor = UIColor.whiteColor;
    _tabBarController.tabBar.tintColor = UIColor.blackColor;

    _tabBarController.tabBar.unselectedItemTintColor = [UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1];
    
      _mainView.tabBarItem = item1;
      _cartView.tabBarItem = item2;
      _accountView.tabBarItem = item3;
    
    
    _tabBarController.viewControllers = @[_mainView, _cartView, _accountView];
    _tabBarController.tabBar.barTintColor=[UIColor blueColor];

    NSURL *url = connectionOptions.URLContexts.allObjects.firstObject.URL;
        UIViewController *desiredController = [self viewControllerForDeeplinkURL:url];
        if(desiredController != nil)
        {
            _tabBarController.selectedViewController = desiredController;
        }
    
    
    
   //
    [[NSUserDefaults standardUserDefaults]setObject:@"Avinash" forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults]setObject:@"1234" forKey:@"password"];
     
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"isUserLoggedIn"])
    {
        [self changeViewController];
        
    } else {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isUserLoggedIn"];
        
        [self goToLoginViewController];
        
       
        
    }
    
    
    [self.window makeKeyAndVisible];
    
}

- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts {
    // Get the deep link URL
    NSURL *url = URLContexts.allObjects.firstObject.URL;

    // Get the view controller for deeplink url.
    UIViewController *desiredViewController = [self viewControllerForDeeplinkURL:url];

    if (desiredViewController != nil) {
        UITabBarController *tabBarController =  (UITabBarController *)self.window.rootViewController;
        tabBarController.selectedViewController = desiredViewController;
        
    } else {
        NSLog(@"Failed to open URL: %@", url);
    }
}


#pragma mark - Private method

/**
 * Returns the view controller mapped with deep link URL.
 * NOTE: It may return nil value in following cases:
 * - URL schema is not matched
 * - Invalid parameters founds for any page link
 * - Unhandled URL is passed
 *
 * @param url The URL used to get its mapped view controller.
 * @returns An instance of @c UIViewController corresponding to URL if it mapped correctly.
 */
- (nullable UIViewController *)viewControllerForDeeplinkURL:(NSURL *)url {
    if (![url.scheme isEqualToString:deeplinkURLSchema]) {
        return nil;
    }

    UIViewController *desiredViewController = nil;

    if ([url.host isEqualToString:accountPageLinkURLHost]) {
        desiredViewController = _accountView;
    } else if ([url.host isEqualToString:cartPageLinkURLHost]) {
        desiredViewController = _cartView;
    } else {
        NSLog(@"Unhandled URL: %@", url);
    }

    return desiredViewController;
}

- (void)changeViewController {
    self.window.rootViewController = _tabBarController;
}

-(void)goToLoginViewController {
    _loginViewController = [[LoginViewController alloc]init];
     self.window.rootViewController = _loginViewController;
}

@end
