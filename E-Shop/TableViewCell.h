//
//  TableViewCell.h
//  ObjectiveCBlock
//
//  Created by Avinash Rai on 20/03/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell

@property (nonatomic) UILabel *cellTitle;
@property (nonatomic) UILabel *cellDescription;
@property (nonatomic) UIImageView *cellImage;
@property (nonatomic) UILabel *cellPrice;
@property (nonatomic) UILabel *cellRatingLabel;
@property (nonatomic) UILabel *cellRating;
@property (nonatomic) UILabel *cellCategory;
@property (nonatomic) UIButton *cellCartButton;
@end

NS_ASSUME_NONNULL_END
