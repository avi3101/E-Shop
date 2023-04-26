//
//  SceneDelegate.h
//  ObjectiveCBlock
//
//  Created by Avinash Rai on 20/03/23.
//

#import <UIKit/UIKit.h>

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>

@property (strong, nonatomic) UIWindow * window;

-(void) changeViewController;
-(void)goToLoginViewController;
@end

