//
//  TableViewCell.m
//  ObjectiveCBlock
//
//  Created by Avinash Rai on 20/03/23.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.contentView.backgroundColor = [[UIColor alloc]initWithRed:205.0/255.0 green:210.0/255.0 blue:217.0/255.0 alpha:1];
        _cellTitle.text = @"Loading...";
        _cellTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _cellTitle.numberOfLines = 1;
        [_cellTitle setFont:[UIFont fontWithName:@"Helvetica" size:20]];
        _cellTitle.textColor = UIColor.systemBlueColor;
        [_cellTitle sizeToFit];
        _cellTitle.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_cellTitle];
        
        _cellDescription = [[UILabel alloc]initWithFrame:CGRectZero];
        _cellDescription.numberOfLines = 3;
        _cellDescription.textColor = UIColor.grayColor;
        [_cellDescription sizeToFit];
        _cellDescription.translatesAutoresizingMaskIntoConstraints = NO;
        _cellDescription.text = @"Loading...";
        [self.contentView addSubview:_cellDescription];
        
       _cellPrice = [[UILabel alloc]initWithFrame:CGRectZero];
        _cellPrice.translatesAutoresizingMaskIntoConstraints = NO;
        _cellPrice.text = @"Loading...";
        [self.contentView addSubview:_cellPrice];
        
        _cellRatingLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _cellRatingLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _cellRatingLabel.text = @"Rating:";
        [self.contentView addSubview:_cellRatingLabel];
        
        _cellRating = [[UILabel alloc]initWithFrame:CGRectZero];
        _cellRating.translatesAutoresizingMaskIntoConstraints = NO;
        _cellRating.text = @"Loading...";
        [self.contentView addSubview:_cellRating];
        
        _cellCategory = [[UILabel alloc]initWithFrame:CGRectZero];
        _cellCategory.translatesAutoresizingMaskIntoConstraints = NO;
        _cellCategory.text = @"Loading...";
        [self.contentView addSubview:_cellCategory];
        
        _cellImage = [[UIImageView alloc]initWithFrame:CGRectZero];
        _cellImage.translatesAutoresizingMaskIntoConstraints = NO;
        _cellImage.image = [UIImage imageNamed:@"DummyPic"];
        [self.contentView addSubview:_cellImage];
        
        _cellCartButton = [[UIButton alloc]initWithFrame:CGRectZero];
        _cellCartButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_cellCartButton setImage:[UIImage imageNamed:@"cart"] forState:UIControlStateNormal];
        [self.contentView addSubview:_cellCartButton];
        [self addSubview:self.contentView];
        
        [self appydynamicTypeAccessibility];
        [self addingConstraints];
    }
    return self;
}

-(void) appydynamicTypeAccessibility {
    
    self.cellTitle.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        self.cellTitle.adjustsFontForContentSizeCategory = YES;
    
    self.cellDescription.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        self.cellDescription.adjustsFontForContentSizeCategory = YES;
}
    



- (void) addingConstraints {
    
    [NSLayoutConstraint activateConstraints:@[
        [self.cellImage.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10],
        [self.cellImage.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:20],
        [self.cellImage.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:0.3],
        [self.cellImage.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor multiplier:0.6],
        
        [self.cellTitle.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-20],
        [self.cellTitle.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:20],
        [self.cellTitle.leadingAnchor constraintEqualToAnchor:_cellImage.trailingAnchor constant:20],
             
        [self.cellDescription.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-20],
        [self.cellDescription.topAnchor constraintEqualToAnchor:_cellTitle.bottomAnchor constant:10],
        [self.cellDescription.leadingAnchor constraintEqualToAnchor:_cellImage.trailingAnchor constant:20],
        
        [self.cellPrice.topAnchor constraintEqualToAnchor:_cellImage.bottomAnchor constant:30],
        [self.cellPrice.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:30],
        [self.cellPrice.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:0.1],
        
        [self.cellRatingLabel.topAnchor constraintEqualToAnchor:_cellImage.bottomAnchor constant:30],
        [self.cellRatingLabel.leadingAnchor constraintEqualToAnchor:self.cellPrice.trailingAnchor constant:30],
        [self.cellRatingLabel.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:0.15],
        
        [self.cellRating.topAnchor constraintEqualToAnchor:_cellImage.bottomAnchor constant:30],
        [self.cellRating.leadingAnchor constraintEqualToAnchor:self.cellRatingLabel.trailingAnchor constant:0],
        [self.cellRating.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:0.1],
        
        [self.cellCategory.topAnchor constraintEqualToAnchor:_cellImage.bottomAnchor constant:30],
        [self.cellCategory.leadingAnchor constraintEqualToAnchor:self.cellRating.trailingAnchor constant:30],
        [self.cellCategory.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:0.25],
        
        [self.cellCartButton.topAnchor constraintEqualToAnchor:_cellImage.bottomAnchor constant:30],
        [self.cellCartButton.leadingAnchor constraintEqualToAnchor:self.cellCategory.trailingAnchor constant:10],
        [self.cellCartButton.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:0.1],
        [self.cellCartButton.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor multiplier:0.1]
    ]];
}
@end
