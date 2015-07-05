//
//  ViewController.m
//  ASJDropDownMenuExample
//
//  Created by sudeep on 02/07/15.
//  Copyright (c) 2015 Sudeep Jaiswal. All rights reserved.
//

#import "ViewController.h"
#import "ASJDropDownMenu.h"

@interface ViewController () {
  IBOutlet UITextField *myTextField;
  ASJDropDownMenu *dropDown;
}

@property (readonly, nonatomic) NSArray *menuItems;

- (void)setUp;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  [self setUp];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


#pragma mark - Set up

- (void)setUp {
  [myTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldChanged:(UITextField *)sender {
  if (!dropDown) {
    dropDown = [[ASJDropDownMenu alloc] initWithTextField:myTextField];
    dropDown.menuItems = self.menuItems;
    dropDown.menuColor = [UIColor colorWithWhite:0.2 alpha:1.0];
    dropDown.itemColor = [UIColor orangeColor];
    dropDown.itemHeight = 50.0;
    dropDown.indicatorStyle = ASJDropDownMenuScrollIndicatorStyleWhite;
  }
  [dropDown showMenuWithCompletion:^(ASJDropDownMenu *dropDownMenu, NSString *selectedItem, NSUInteger index) {
    myTextField.text = selectedItem;
    [dropDownMenu hideMenu];
  }];
}

- (NSArray *)menuItems {
  return @[@"15 Step",
           @"Bodysnatchers",
           @"Nude",
           @"Weird Fishes / Arpeggi",
           @"All I Need",
           @"Faust Arp",
           @"Reckoner",
           @"House of Cards",
           @"Jigsaw Falling Into Place",
           @"Videotape"];
}

@end
