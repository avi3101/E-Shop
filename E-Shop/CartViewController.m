#import "CartViewController.h"
#import "SceneDelegate.h"
#import "ViewController.h"
#import "TableViewCell.h"
#import "ImageDownloader.h"

@interface CartViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic) UILabel *label;
@property (nonatomic) UIButton *button;
@property (nonatomic) NSMutableArray *cartProductArray;
@property (nonatomic) UITableView *itemTableView;
@property (nonatomic) UIImageView *emptyCartImage;


@end

@implementation CartViewController

- (instancetype)init {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _cartProductArray = [NSMutableArray array];

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc]initWithRed:205.0/255.0 green:210.0/255.0 blue:217.0/255.0 alpha:1];
    
}
-(void)viewWillAppear:(BOOL)animated {
    if(_cartProductArray.count == 0)
       {
           [self setupView];
           [self configureConstraints];
       }
    else {
        [self setupTableView];
        [self tableViewConstraints];
    }
}

#pragma mark private method

-(void) setupView {
    
    for (UIView *subview in self.view.subviews) {
        [subview removeFromSuperview];
    }

    _label = [[UILabel alloc]initWithFrame:CGRectZero];
    _label.text = @"Cart is Empty";
    [_label setFont:[UIFont fontWithName:@"Helvetica" size:40]];
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_label];
    
    _button = [[UIButton alloc]initWithFrame:CGRectZero];
    [_button setTitle:@"Shop Now" forState:UIControlStateNormal];
    _button.layer.borderWidth = 1;
    _button.backgroundColor = UIColor.blueColor;
    _button.layer.borderColor = UIColor.blackColor.CGColor;
    _button.translatesAutoresizingMaskIntoConstraints = NO;
    [_button addTarget:self action:@selector(backButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    _emptyCartImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    _emptyCartImage.image = [UIImage imageNamed:@"emptyCart"];
    _emptyCartImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_emptyCartImage];
    
}
-(void) setupTableView {
    
   for (UIView *subview in self.view.subviews) {
        [subview removeFromSuperview];
    }

    _itemTableView = [[UITableView alloc]initWithFrame:CGRectZero];
    _itemTableView.backgroundColor = [[UIColor alloc]initWithRed:205.0/255.0 green:210.0/255.0 blue:217.0/255.0 alpha:1];
     _itemTableView.delegate = self;
     _itemTableView.dataSource = self;
     _itemTableView.translatesAutoresizingMaskIntoConstraints = NO;
     [self.view addSubview:_itemTableView];
    
     [_itemTableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
    
    _label = [[UILabel alloc]initWithFrame:CGRectZero];
    _label.text = @"My Cart";
    [_label setFont:[UIFont fontWithName:@"Helvetica" size:40]];
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_label];
    
    _button = [[UIButton alloc]initWithFrame:CGRectZero];
    [_button setTitle:@"Home" forState:UIControlStateNormal];
    _button.layer.borderWidth = 1;
    _button.backgroundColor = UIColor.blueColor;
    _button.layer.borderColor = UIColor.blackColor.CGColor;
    _button.translatesAutoresizingMaskIntoConstraints = NO;
    [_button addTarget:self action:@selector(backButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}
-(void) backButtonTapped {
    [self.tabBarController setSelectedIndex:0];
}



-(void) configureConstraints {
    
    [NSLayoutConstraint activateConstraints:@[
        [_label.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:50],
       
        [_label.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [_emptyCartImage.topAnchor constraintEqualToAnchor:_label.bottomAnchor constant:30],
        [_emptyCartImage.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [_emptyCartImage.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.5],
        [_emptyCartImage.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.3],
        
        [_button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [_button.topAnchor constraintEqualToAnchor:_emptyCartImage.bottomAnchor constant:30],
        [_button.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.5],
        

    ]];
}

-(void)tableViewConstraints {
    [_label.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:50].active = YES;
    [_label.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [_label.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.4].active = YES;
    [_itemTableView.topAnchor constraintEqualToAnchor:_label.topAnchor constant:100].active = YES;
    [_itemTableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_itemTableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [_itemTableView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.5].active = YES;
    [_itemTableView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:1].active =YES;
    
    [_button.topAnchor constraintEqualToAnchor:_itemTableView.bottomAnchor constant:50].active = YES;
    [_button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [_button.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.3].active = YES;
}

-(void)appendingElement: (NSDictionary * const)dictObject {
    [_cartProductArray addObject:dictObject];
    NSLog(@"cartcount: %d",_cartProductArray.count);
    [_itemTableView reloadData];
}

-(void)removingElement:(NSDictionary *const)dictObject {
    [_cartProductArray removeObject:dictObject];
    [_itemTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
   numberOfRowsInSection:(NSInteger)section {
    
    return _cartProductArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    
    cell.cellTitle.text = [[self.cartProductArray objectAtIndex:indexPath.row]objectForKey:@"title"];
    cell.cellDescription.text = [[self.cartProductArray objectAtIndex:indexPath.row]objectForKey:@"description"];
    cell.cellPrice.text =[NSString stringWithFormat: @"$%@",
        [[self.cartProductArray objectAtIndex:indexPath.row]objectForKey:@"price"]];
    cell.cellRating.text = [NSString stringWithFormat: @"%@",
        [[self.cartProductArray objectAtIndex:indexPath.row]objectForKey:@"rating"]];
    cell.cellCategory.text = [[self.cartProductArray objectAtIndex:indexPath.row]objectForKey:@"category"];
    cell.cellCartButton.tag = indexPath.row;
   // [cell.cellCartButton addTarget:self action:@selector(cartButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    NSURL *url = [NSURL URLWithString:[[_cartProductArray objectAtIndex:indexPath.row]objectForKey:@"thumbnail"]];
    
    ImageDownloader *downloader = [[ImageDownloader alloc] init];
        [downloader fetchImage:url parameterBlock:^(UIImage *image) {
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.cellImage.image = image;
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.cellImage.image = [UIImage imageNamed:@"DummyPic"];
                });
            }
        }];
    return cell;
}
@end
