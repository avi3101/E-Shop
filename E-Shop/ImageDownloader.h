//
//  ImageDownloader.h
//  ObjectiveCBlock
//
//  Created by Avinash Rai on 21/03/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageDownloader : UIViewController

- (void)fetchImage:(NSURL *)url
    parameterBlock:(void (^)(UIImage *))completionBlock;

@end

NS_ASSUME_NONNULL_END
