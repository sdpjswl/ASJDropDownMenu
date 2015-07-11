ASJDropDownMenu
================

iOS doesn't have a drop down menu by default. Developers are supposed to use the ```UIPickerView``` for similar functionality. Project design constraints may sometimes however necessitate the use of such a menu. This class is a subclass of `UIView` that has a `UITableView` embedded in it. It provides the functionality needed to show a drop down menu below a `UITextField` and is customisable using various properties.

Creating one is simple. The show method has a completion block which returns the selected item. You may hide the drop down there and then:

```objc
ASJDropDownMenu *dropDownMenu = [[ASJDropDownMenu alloc] initWithTextField:aTextField];
dropDownMenu.menuItems = anArrayOfStrings;
[dropDown showMenuWithCompletion:^(ASJDropDownMenu *dropDownMenu, NSString *selectedItem, NSUInteger index) {
    myTextField.text = selectedItem;
    [dropDownMenu hideMenu];
  }];
```

![alt tag](Screenshot.png)

###To-do
- Animation to open and close
- Provision to add images

# License

```
 Copyright (c) 2014 Sudeep Jaiswal

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
```
