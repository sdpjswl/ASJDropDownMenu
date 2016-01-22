// ASJDropDownMenu.h
//
// Copyright (c) 2014 Sudeep Jaiswal
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

@import UIKit;

@class ASJDropDownMenu;
@class ASJDropDownMenuItem;

typedef void (^ASJDropDownMenuCompletionBlock)(ASJDropDownMenu *dropDownMenu, ASJDropDownMenuItem *menuItem, NSUInteger index);

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
 *  Use the designated initializer to construct a drop down menu
 *
 *  @param view The view under which to show the drop down
 *
 *  @return Returns an instance of ASJDropDownMenu
 */
- (instancetype)initWithView:(id)view;

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

@interface ASJDropDownMenuItem : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;

+ (ASJDropDownMenuItem *)itemWithTitle:(NSString *)title;
+ (ASJDropDownMenuItem *)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle;

@end
