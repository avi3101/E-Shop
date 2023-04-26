#import "ViewController.h"
#import "TableViewCell.h"
#import "ImageDownloader.h"
#import "CartViewController.h"



@interface ViewController() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic)  UITableView *itemTableView;
@property (nonatomic) UISlider *priceSlider;
@property (nonatomic) UIButton *sortPrice;
@property (nonatomic) UIButton *sortCategory;
@property (nonatomic) NSArray *productJSON;
@property (nonatomic) NSMutableArray *secondProductJSON;
@property (nonatomic) NSMutableArray *cartProductJSON;
@property (nonatomic) NSMutableSet *tags;

@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor alloc]initWithRed:205.0/255.0 green:210.0/255.0 blue:217.0/255.0 alpha:1];
    
    _cartProductJSON = [[NSMutableArray alloc]init];
    _tags = [NSMutableSet set];
    _priceSlider = [[UISlider alloc]initWithFrame:CGRectZero];
    _priceSlider.translatesAutoresizingMaskIntoConstraints = NO;
    _priceSlider.minimumValue = 1;
    _priceSlider.maximumValue = 1000;
    _priceSlider.value = _priceSlider.maximumValue;
    _priceSlider.continuous = NO;
    [_priceSlider addTarget:self action:@selector(sliderTriggered) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_priceSlider];

    [_priceSlider setIsAccessibilityElement:YES];
    _priceSlider.accessibilityTraits = UIAccessibilityTraitSelected;
    
    [self changeSliderAccessibilityValue];
    
    _priceSlider.accessibilityLabel = @"Filter on price";
    _priceSlider.accessibilityHint = @"Choose price range as per slider value";
    
    
    
    _sortPrice = [[UIButton alloc]initWithFrame:CGRectZero];
    _sortPrice.translatesAutoresizingMaskIntoConstraints = NO;
    _sortPrice.titleLabel.numberOfLines = 0;
    _sortPrice.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_sortPrice setTitle:@"Sort by\n Price" forState:UIControlStateNormal];
    [_sortPrice setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    _sortPrice.backgroundColor = UIColor.systemBlueColor;
    [_sortPrice addTarget:self action:@selector(filterOnPrice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sortPrice];
    
    _sortCategory = [[UIButton alloc]initWithFrame:CGRectZero];
    _sortCategory.titleLabel.numberOfLines = 0;
    _sortCategory.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [_sortCategory setTitle:@"Sort by\n Category" forState:UIControlStateNormal];
    [_sortCategory setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    _sortCategory.backgroundColor = UIColor.systemBlueColor;
    _sortCategory.translatesAutoresizingMaskIntoConstraints = NO;
    [_sortCategory addTarget:self action:@selector(filterOnCategory) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sortCategory];
    
    [self fetchProductsUsingJSON];
        
    _itemTableView = [[UITableView alloc]initWithFrame:CGRectZero];
    _itemTableView.backgroundColor = [[UIColor alloc]initWithRed:205.0/255.0 green:210.0/255.0 blue:217.0/255.0 alpha:1];
    _itemTableView.delegate = self;
    _itemTableView.dataSource = self;
    _itemTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_itemTableView];

    [_itemTableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self configureContraints];
}

-(void) initializeSecondProductJSON {
    
    _secondProductJSON = [[NSMutableArray alloc]init];
       for(NSDictionary *product in _productJSON) {
           float price = [[product objectForKey:@"price"] floatValue];
           if(price <= _priceSlider.value){
               [_secondProductJSON addObject:product];
           }
           
       }
    
}

-(void) sliderTriggered {
    [self initializeSecondProductJSON];
    [_itemTableView reloadData];
    
}

-(void) changeSliderAccessibilityValue {
    
    _priceSlider.accessibilityValue = [NSString stringWithFormat:@"products under %d", (int)_priceSlider.value];
}

- (void)filterOnPrice {
    NSArray *sortedArray;
    sortedArray = [_secondProductJSON sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *a, NSDictionary *b) {
        
        return [[a objectForKey:@"price"] compare:[b objectForKey:@"price"]];
    }];
    _secondProductJSON = [sortedArray copy];
    [_itemTableView reloadData];
}

- (void) filterOnCategory {
    
    NSArray *sortedArray;
    sortedArray = [_secondProductJSON sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *a, NSDictionary *b) {
        return [[a objectForKey:@"category"] compare:[b objectForKey:@"category"]];
    }];
    _secondProductJSON = [sortedArray copy];
    [_itemTableView reloadData];
}

- (void) fetchProductsUsingJSON {
    
    NSURL *url = [NSURL URLWithString:@"https://dummyjson.com/products"];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError * err;
        NSDictionary *jsonData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if(err) {
            NSLog(@"Error: %@",err);
        }
        self.productJSON = jsonData[@"products"];
        [self initializeSecondProductJSON];
        dispatch_async(dispatch_get_main_queue(), ^ {
        [self.itemTableView reloadData];
        });
        
    }] resume];
    
}

- (void) configureContraints {
    
    [_priceSlider.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:50].active = YES;
    [_priceSlider.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.6].active = YES;
    [_priceSlider.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    
    [_sortPrice.topAnchor constraintEqualToAnchor:_priceSlider.topAnchor constant:50].active = YES;
    [_sortPrice.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:50].active = YES;
    [_sortPrice.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.3].active = YES;
    
    [_sortCategory.topAnchor constraintEqualToAnchor:_priceSlider.topAnchor constant:50].active = YES;
    [_sortCategory.leadingAnchor constraintEqualToAnchor:_sortPrice.trailingAnchor constant:50].active = YES;
    [_sortCategory.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.3].active = YES;
    
    [_itemTableView.topAnchor constraintEqualToAnchor:_sortPrice.bottomAnchor constant:10].active = YES;
    [_itemTableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [_itemTableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [_itemTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [_itemTableView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:1].active =YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
   numberOfRowsInSection:(NSInteger)section {
    
    return _secondProductJSON.count;
}

- (CGFloat)tableView:(UITableView *)tableView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    
    cell.cellTitle.text = [[self.secondProductJSON objectAtIndex:indexPath.row]objectForKey:@"title"];
    cell.cellDescription.text = [[self.secondProductJSON objectAtIndex:indexPath.row]objectForKey:@"description"];
    cell.cellPrice.text =[NSString stringWithFormat: @"$%@",
        [[self.secondProductJSON objectAtIndex:indexPath.row]objectForKey:@"price"]];
    cell.cellRating.text = [NSString stringWithFormat: @"%@",
        [[self.secondProductJSON objectAtIndex:indexPath.row]objectForKey:@"rating"]];
    cell.cellCategory.text = [[self.secondProductJSON objectAtIndex:indexPath.row]objectForKey:@"category"];
    cell.cellCartButton.tag = indexPath.row;
    [cell.cellCartButton addTarget:self action:@selector(cartButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    NSURL *url = [NSURL URLWithString:[[_secondProductJSON objectAtIndex:indexPath.row]objectForKey:@"thumbnail"]];
    
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
    
    
    [cell setIsAccessibilityElement:YES];
    cell.accessibilityTraits = UIAccessibilityTraitSelected;
    
    NSString *labelText = [NSString stringWithFormat:@"%@ %@ %@ %@",cell.cellTitle.text,cell.cellCategory.text,cell.cellPrice.text,[[_secondProductJSON objectAtIndex:indexPath.row]objectForKey:@"brand"]];
    cell.accessibilityLabel = labelText;    cell.accessibilityHint = @"Product Name Category Price And Manufacturer";
    
    return cell;
}

-(void)cartButtonTapped:(UIButton *)sender {
  
     NSNumber * number =[NSNumber numberWithInt:sender.tag];
       if(![_tags containsObject:number])
          {
              [_cartProductJSON addObject:[_productJSON objectAtIndex:(sender.tag)]];
              CartViewController * cartViewControllerInstance = [self.tabBarController.viewControllers objectAtIndex:1];
              [cartViewControllerInstance appendingElement:[_secondProductJSON objectAtIndex:sender.tag]];
              
              
    NSLog(@"count: %lu",(unsigned long)_cartProductJSON.count);
              [_tags addObject:number];
              
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Added" message:@"to cart"
        preferredStyle:UIAlertControllerStyleAlert];
                                                    
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
            style:UIAlertActionStyleDefault
            handler:^(UIAlertAction *action) {}];

        [alertController addAction:action];

        [self presentViewController:alertController animated:YES completion:nil];
          }
       else {
        
           [_tags removeObject:number];
           [_cartProductJSON removeObject:[_secondProductJSON objectAtIndex:sender.tag]];
           CartViewController * cartViewControllerInstance = [self.tabBarController.viewControllers objectAtIndex:1];
           [cartViewControllerInstance removingElement:[_secondProductJSON objectAtIndex:sender.tag]];
           
           UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Removed"
            message:@"From the cart"
            preferredStyle:UIAlertControllerStyleAlert];
                                                 
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault  handler:^(UIAlertAction *action) {}];

        [alertController addAction:action];

        [self presentViewController:alertController animated:YES completion:nil];
       }
}

@end
