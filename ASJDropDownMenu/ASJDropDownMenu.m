// ASJDropDownMenu.m
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

#import "ASJDropDownMenu.h"

static NSString *const kCellIdentifier = @"dropDownCell";

@interface ASJDropDownMenu () <UITableViewDataSource, UITableViewDelegate> {
  UITableView *menuTableView;
  BOOL usesSubtitle;
}

@property (weak, nonatomic) UIView *view;
@property (copy) ASJDropDownMenuCompletionBlock callback;

- (void)setUp;
- (void)setDefaults;
- (void)setUI;
- (void)addTable;
- (void)reloadTable;

@end

@implementation ASJDropDownMenu


#pragma mark - Init methods

- (instancetype)initWithView:(id)view
{
  self = [super init];
  if (self) {
    _view = view;
    [self setUp];
  }
  return self;
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    [self setUp];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    [self setUp];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setUp];
  }
  return self;
}


#pragma mark - Set up

- (void)setUp {
  [self setDefaults];
  [self setUI];
  [self addTable];
}

- (void)setDefaults {
  _menuColor = [[UIColor clearColor] colorWithAlphaComponent:0.8];
  _itemColor = [UIColor whiteColor];
  _itemFont = [UIFont systemFontOfSize:14.0];
  _itemHeight = 40.0;
  _indicatorStyle = ASJDropDownMenuScrollIndicatorStyleDefault;
}

- (void)setUI {
  self.clipsToBounds = YES;
  self.layer.cornerRadius = 3.0;
  self.backgroundColor = _menuColor;
}

- (void)addTable {
  if (menuTableView) {
    return;
  }
  menuTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
  menuTableView.dataSource = self;
  menuTableView.delegate = self;
  menuTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  menuTableView.backgroundColor = [UIColor clearColor];
  menuTableView.indicatorStyle = (UIScrollViewIndicatorStyle)_indicatorStyle;
  menuTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
  [self addSubview:menuTableView];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
  if (!cell)
  {
    UITableViewCellStyle style = usesSubtitle ? UITableViewCellStyleSubtitle : UITableViewCellStyleDefault;
    cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:kCellIdentifier];
  }
  
  cell.textLabel.textColor = _itemColor;
  cell.textLabel.font = _itemFont;
  cell.backgroundColor = [UIColor clearColor];
  
  ASJDropDownMenuItem *item = _menuItems[indexPath.row];
  cell.textLabel.text = item.title;
  if (usesSubtitle)
  {
    cell.detailTextLabel.text = item.subtitle;
    cell.detailTextLabel.textColor = _itemColor;
  }
  
  return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (_callback) {
    _callback(self, _menuItems[indexPath.row], indexPath.row);
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return _itemHeight;
}


#pragma mark - Property setters

- (void)setMenuColor:(UIColor *)menuColor {
  _menuColor = menuColor;
  self.backgroundColor = _menuColor;
}

- (void)setItemColor:(UIColor *)itemColor {
  _itemColor = itemColor;
  [self reloadTable];
}

- (void)setItemFont:(UIFont *)itemFont {
  _itemFont = itemFont;
  [self reloadTable];
}

- (void)setItemHeight:(CGFloat)itemHeight {
  _itemHeight = itemHeight;
  [self reloadTable];
}

- (void)setMenuItems:(NSArray *)menuItems
{
  for (id menuItem in menuItems)
  {
    BOOL success = [menuItem isMemberOfClass:[ASJDropDownMenuItem class]];
    if (!success) {
      NSAssert(success, @"Items must be of kind ASJDropDownMenuItem");
    }
    ASJDropDownMenuItem *temp = (ASJDropDownMenuItem *)menuItem;
    if (temp.subtitle)
    {
      usesSubtitle = YES;
    }
  }
  _menuItems = menuItems;
  [self reloadTable];
}

- (void)reloadTable {
  dispatch_async(dispatch_get_main_queue(), ^{
    [menuTableView reloadData];
  });
}

- (void)setIndicatorStyle:(ASJDropDownMenuScrollIndicatorStyle)indicatorStyle {
  _indicatorStyle = indicatorStyle;
  menuTableView.indicatorStyle = (UIScrollViewIndicatorStyle)_indicatorStyle;
}


#pragma mark - Show-hide

- (void)showMenuWithCompletion:(ASJDropDownMenuCompletionBlock)callback {
  
#if DEBUG
  NSString *errorMessage = [NSString stringWithFormat:@"'view' cannot be nil. Use the designated initialiser 'initWithView:' or set the 'textField' property before attepting to show the drop down menu."];
  NSAssert(_view, errorMessage);
#endif
  
  _callback = callback;
  CGFloat x = _view.frame.origin.x;
  CGFloat y = _view.frame.origin.y + _view.frame.size.height;
  CGFloat width = _view.frame.size.width;
  CGFloat height = _itemHeight * _menuItems.count;
  if (_menuItems.count > 5) {
    height = _itemHeight * 5;
  }
  dispatch_async(dispatch_get_main_queue(), ^{
    self.frame = CGRectMake(x, y, width, height);
    [_view.superview addSubview:self];
  });
}

- (void)hideMenu {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self removeFromSuperview];
    [menuTableView deselectRowAtIndexPath:menuTableView.indexPathForSelectedRow animated:NO];
  });
}

@end

@implementation ASJDropDownMenuItem

+ (ASJDropDownMenuItem *)itemWithTitle:(NSString *)title
{
  ASJDropDownMenuItem *item = [[ASJDropDownMenuItem alloc] init];
  item.title = title;
  return item;
}

+ (ASJDropDownMenuItem *)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle
{
  ASJDropDownMenuItem *item = [[ASJDropDownMenuItem alloc] init];
  item.title = title;
  item.subtitle = subtitle;
  return item;
}

@end