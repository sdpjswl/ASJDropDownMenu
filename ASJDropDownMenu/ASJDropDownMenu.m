//
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

@interface ASJDropDownMenu () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UIView *targetView;
@property (strong, nonatomic) UITableView *menuTableView;
@property (copy) ASJDropDownMenuCompletionBlock callback;

- (void)setup;
- (void)setupDefaults;
- (void)setupUI;
- (void)addTable;
- (void)reloadTable;

@end

@implementation ASJDropDownMenu

#pragma mark - Init methods

- (instancetype)initWithView:(__kindof UIView *)view menuItems:(nullable NSArray<ASJDropDownMenuItem *> *)menuItems
{
  NSAssert(view, @"View must not be nil.");
  self = [super initWithFrame:CGRectZero];
  if (self) {
    _targetView = view;
    _menuItems = menuItems;
    [self setup];
  }
  return self;
}

#pragma mark - Setup

- (void)setup
{
  [self setupDefaults];
  [self setupUI];
  [self addTable];
}

- (void)setupDefaults
{
  _menuColor = [[UIColor clearColor] colorWithAlphaComponent:0.8f];
  _itemColor = [UIColor whiteColor];
  _itemFont = [UIFont systemFontOfSize:14.0f];
  _itemHeight = 40.0f;
  _indicatorStyle = ASJDropDownMenuScrollIndicatorStyleDefault;
}

- (void)setupUI
{
  self.clipsToBounds = YES;
  self.layer.cornerRadius = 3.0f;
  self.backgroundColor = _menuColor;
}

- (void)addTable
{
  if (_menuTableView) {
    return;
  }
  _menuTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
  _menuTableView.dataSource = self;
  _menuTableView.delegate = self;
  _menuTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  _menuTableView.backgroundColor = [UIColor clearColor];
  _menuTableView.indicatorStyle = (UIScrollViewIndicatorStyle)_indicatorStyle;
  _menuTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
  [self addSubview:_menuTableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _menuItems.count;
}

static NSString *const kCellIdentifier = @"ASJDropDownCellIdentifier";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
  
  ASJDropDownMenuItem *item = _menuItems[indexPath.row];
  BOOL hasSubtitle = item.subtitle.length ? YES : NO;
  BOOL hasImage = item.image ? YES : NO;
  
  if (!cell)
  {
    UITableViewCellStyle style = hasSubtitle ? UITableViewCellStyleSubtitle : UITableViewCellStyleDefault;
    cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:kCellIdentifier];
  }
  
  cell.textLabel.textColor = _itemColor;
  cell.textLabel.font = _itemFont;
  cell.backgroundColor = [UIColor clearColor];
  cell.textLabel.text = item.title;
  
  if (hasSubtitle)
  {
    cell.detailTextLabel.text = item.subtitle;
    cell.detailTextLabel.textColor = _itemColor;
  }
  if (hasImage) {
    cell.imageView.image = item.image;
  }
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (_hidesOnSelection == YES) {
    [self hideMenu];
  }
  
  if (_callback) {
    _callback(self, _menuItems[indexPath.row], indexPath.row);
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return _itemHeight;
}

#pragma mark - Property setters

- (void)setMenuColor:(UIColor *)menuColor
{
  _menuColor = menuColor;
  self.backgroundColor = _menuColor;
}

- (void)setItemColor:(UIColor *)itemColor
{
  _itemColor = itemColor;
  [self reloadTable];
}

- (void)setItemFont:(UIFont *)itemFont
{
  _itemFont = itemFont;
  [self reloadTable];
}

- (void)setItemHeight:(CGFloat)itemHeight
{
  _itemHeight = itemHeight;
  [self reloadTable];
}

- (void)setMenuItems:(NSArray *)menuItems
{
  NSAssert(menuItems.count, @"You must provide at least one ASJDropDownMenuItem.");
  
  for (id object in menuItems)
  {
    BOOL success = [object isMemberOfClass:[ASJDropDownMenuItem class]];
    NSAssert(success, @"Items must be of kind ASJDropDownMenuItem");
  }
  _menuItems = menuItems;
  [self reloadTable];
}

- (void)reloadTable
{
  [_menuTableView reloadData];
}

- (void)setIndicatorStyle:(ASJDropDownMenuScrollIndicatorStyle)indicatorStyle
{
  _indicatorStyle = indicatorStyle;
  _menuTableView.indicatorStyle = (UIScrollViewIndicatorStyle)_indicatorStyle;
}

#pragma mark - Show-hide

- (void)showMenuWithCompletion:(ASJDropDownMenuCompletionBlock)callback
{
  _callback = callback;
  CGFloat x = _targetView.frame.origin.x;
  CGFloat width = _targetView.frame.size.width;
  CGFloat height = _itemHeight * _menuItems.count;
  
  if (_menuItems.count > 5) {
    height = _itemHeight * 5;
  }
  
  CGFloat y = 0.0f;
  if (_direction == ASJDropDownMenuDirectionDown) {
    y = _targetView.frame.origin.y + _targetView.frame.size.height;
  }
  else {
    y = _targetView.frame.origin.y - height;
  }
  
  self.frame = CGRectMake(x, y, width, height);
  [_targetView.superview addSubview:self];
}

- (void)hideMenu
{
  [self removeFromSuperview];
  [_menuTableView deselectRowAtIndexPath:_menuTableView.indexPathForSelectedRow animated:NO];
}

@end

#pragma mark - ASJDropDownMenuItem

@implementation ASJDropDownMenuItem

+ (ASJDropDownMenuItem *)itemWithTitle:(NSString *)title
{
  ASJDropDownMenuItem *item = [[ASJDropDownMenuItem alloc] init];
  item.title = title;
  return item;
}

+ (ASJDropDownMenuItem *)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(nullable UIImage *)image
{
  ASJDropDownMenuItem *item = [[ASJDropDownMenuItem alloc] init];
  item.title = title;
  item.subtitle = subtitle;
  item.image = image;
  return item;
}

@end
