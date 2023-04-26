//
//  CartViewController.h
//  ObjectiveCBlock
//
//  Created by Avinash Rai on 28/03/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CartViewController : UIViewController

-(instancetype)init;
-(void)appendingElement: (NSDictionary * const)dictObject;
-(void)removingElement: (NSDictionary * const)dictObject;

@end

NS_ASSUME_NONNULL_END
