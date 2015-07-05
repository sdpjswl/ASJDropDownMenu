//
//  ASJDropDownMenu.h
//  ASJDropDownMenu
//
//  Created by Sudeep Jaiswal on 13/09/14.
//  Copyright (c) 2014 Sudeep Jaiswal. All rights reserved.
//

@import UIKit;

@class ASJDropDownMenu;

typedef void (^ASJDropDownMenuCompletionBlock)(ASJDropDownMenu *dropDownMenu, NSString *selectedItem, NSUInteger index);

typedef NS_ENUM(NSUInteger, ASJDropDownMenuScrollIndicatorStyle) {
  ASJDropDownMenuScrollIndicatorStyleDefault,
  ASJDropDownMenuScrollIndicatorStyleBlack,
  ASJDropDownMenuScrollIndicatorStyleWhite
};

@interface ASJDropDownMenu : UIView

/**
 *  Background color of the drop down menu
 */
@property (nonatomic) UIColor *menuColor;

/**
 *  Text color of the menu items
 */
@property (nonatomic) UIColor *itemColor;

/**
 *  Font of the menu items
 */
@property (nonatomic) UIFont *itemFont;

/**
 *  Height of individual menu items
 */
@property (nonatomic) CGFloat itemHeight;

/**
 *  Type of scroll indicator for the scroll view
 */
@property (nonatomic) ASJDropDownMenuScrollIndicatorStyle indicatorStyle;

/**
 *  An array of strings to show in the drop down menu
 */
@property (copy, nonatomic) NSArray *menuItems;

/**
 *  Set this property if not using the initWithTextField: initializer
 */
@property (nonatomic) UITextField *textField;

/**
 *  Use the designated initializer to construct a drop down menu
 *
 *  @param textField The text field under which to show the drop down.
 *
 *  @return Returns an instance of ASJDropDownMenu
 */
- (instancetype)initWithTextField:(UITextField *)textField;

/**
 *  Show the drop down menu under the specified text field
 *
 *  @param callback Returns the drop down menu object, the selection and the index at which it belongs in the array
 */
- (void)showMenuWithCompletion:(ASJDropDownMenuCompletionBlock)callback;

/**
 *  Hides the drop down from the screen
 */
- (void)hideMenu;

@end
