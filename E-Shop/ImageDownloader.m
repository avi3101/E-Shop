//
//  ImageDownloader.m
//  ObjectiveCBlock
//
//  Created by Avinash Rai on 21/03/23.
//

#import "ImageDownloader.h"

@interface ImageDownloader ()
@end

@implementation ImageDownloader

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)fetchImage:(NSURL *)url
    parameterBlock:(void (^)(UIImage *))completionBlock {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error fetching image: %@", error);
            completionBlock(nil);
        } else {
            UIImage *image = [UIImage imageWithData:data];
            completionBlock(image);
        }
    }];
    [task resume];
}



@end
