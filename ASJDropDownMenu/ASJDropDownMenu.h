//
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

NS_ASSUME_NONNULL_BEGIN

typedef void (^ASJDropDownMenuCompletionBlock)(ASJDropDownMenu *dropDownMenu, ASJDropDownMenuItem *menuItem, NSUInteger index);

typedef NS_ENUM(NSUInteger, ASJDropDownMenuScrollIndicatorStyle)
{
  ASJDropDownMenuScrollIndicatorStyleDefault,
  ASJDropDownMenuScrollIndicatorStyleBlack,
  ASJDropDownMenuScrollIndicatorStyleWhite
};

typedef NS_ENUM(NSInteger, ASJDropDownMenuDirection)
{
  ASJDropDownMenuDirectionDown,
  ASJDropDownMenuDirectionUp
};

@interface ASJDropDownMenu : UIView

/**
 *  Background color of the drop down menu.
 */
@property (nullable, strong, nonatomic) UIColor *menuColor;

/**
 *  Text color of the menu items.
 */
@property (nullable, strong, nonatomic) UIColor *itemColor;

/**
 *  Font of the menu items.
 */
@property (nullable, strong, nonatomic) UIFont *itemFont;

/**
 *  Height of individual menu items.
 */
@property (assign, nonatomic) CGFloat itemHeight;

/**
 *  Hide the drop down menu when an item is selected.
 */
@property (assign, nonatomic) BOOL hidesOnSelection;

/**
 *  Show the drop down menu below or above the specified view.
 */
@property (assign, nonatomic) ASJDropDownMenuDirection direction;

/**
 *  Type of scroll indicator for the scroll view. The available types are default, black and white. If you want to have more control over the indicator color, you can refer ASJColoredScrollIndicators: https://github.com/sudeepjaiswal/ASJColoredScrollIndicators
 */
@property (assign, nonatomic) ASJDropDownMenuScrollIndicatorStyle indicatorStyle;

/**
 *  An array of ASJDropDownMenuItems to show in the drop down menu.
 */
@property (copy, nonatomic) NSArray<ASJDropDownMenuItem *> *menuItems;

/**
 *  Use the designated initializer to construct a drop down menu.
 *
 *  @param view      The view under which to show the drop down.
 *  @param menuItems An array of ASJDropDownMenuItems to show in the drop down menu.
 *
 *  @return Returns an instance of ASJDropDownMenu.
 */
- (instancetype)initWithView:(__kindof UIView *)view menuItems:(nullable NSArray<ASJDropDownMenuItem *> *)menuItems NS_DESIGNATED_INITIALIZER;

/**
 *  Disallow usage of "init" to force the user to use the designated initializer.
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 *  Disallow usage of "initWithCoder:" to force the user to use the designated initializer.
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 *  Disallow usage of "initWithFrame:" to force the user to use the designated initializer.
 */
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

/**
 *  Show the drop down menu under the specified view.
 *
 *  @param callback Returns the drop down menu object, the selection and the index at which it belongs in the array.
 */
- (void)showMenuWithCompletion:(nullable ASJDropDownMenuCompletionBlock)callback;

/**
 *  Hides the drop down from the screen.
 */
- (void)hideMenu;

@end

@interface ASJDropDownMenuItem : NSObject

/**
 *  Main text of the menu item.
 */
@property (copy, nonatomic) NSString *title;

/**
 *  Accompanying text below the main text. Optional.
 */
@property (nullable, copy, nonatomic) NSString *subtitle;

/**
 *  Accompanying  image on the left of the main text. Optional
 */
@property (nullable, copy, nonatomic) UIImage *image;

/**
 *  Convenience constructors. Will only show the main text.
 */
+ (ASJDropDownMenuItem *)itemWithTitle:(NSString *)title;

/**
 *  Convenience constructor. 'subtitle' and 'image' can be nil.
 */
+ (ASJDropDownMenuItem *)itemWithTitle:(NSString *)title subtitle:(nullable NSString *)subtitle image:(nullable UIImage *)image;

@end

NS_ASSUME_NONNULL_END
