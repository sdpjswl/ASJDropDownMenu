//
//  ViewController.m
//  ASJDropDownMenuExample
//
//  Created by sudeep on 02/07/15.
//  Copyright (c) 2015 Sudeep Jaiswal. All rights reserved.
//

#import "ViewController.h"
#import "ASJDropDownMenu.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (strong, nonatomic) ASJDropDownMenu *dropDown;
@property (readonly, copy, nonatomic) NSArray *menuItems;

- (void)setup;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup

- (void)setup
{
    [_myTextField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldChanged:(UITextField *)sender
{
    if (!_dropDown)
    {
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (NSString *item in self.menuItems)
        {
            NSInteger idx = [self.menuItems indexOfObject:item];
            ASJDropDownMenuItem *menuItem = [ASJDropDownMenuItem itemWithTitle:self.menuItems[idx] subtitle:@"Radiohead - In Rainbows (2007)" image:[UIImage imageNamed:@"in_rainbows"]];
            [temp addObject:menuItem];
        }
        
        _dropDown = [[ASJDropDownMenu alloc] initWithView:_myTextField menuItems:temp];
        _dropDown.menuColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
        _dropDown.itemColor = [UIColor orangeColor];
        _dropDown.itemHeight = 50.0f;
        _dropDown.hidesOnSelection = YES;
        _dropDown.direction = ASJDropDownMenuDirectionDown;
        _dropDown.indicatorStyle = ASJDropDownMenuScrollIndicatorStyleWhite;
    }
    
    [_dropDown showMenuWithCompletion:^(ASJDropDownMenu *dropDownMenu, ASJDropDownMenuItem *menuItem, NSUInteger index)
     {
        self->_myTextField.text = menuItem.title;
    }];
}

- (NSArray *)menuItems
{
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
