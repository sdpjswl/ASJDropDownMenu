//
//  GolopoDropDownMenu.h
//  drop down
//
//  Created by Sudeep Jaiswal on 13/09/14.
//  Copyright (c) 2014 Sudeep Jaiswal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GolopoDropDownMenu;

@protocol GolopoDropDownMenuDelegate <NSObject>

-(void)golopoMenu:(GolopoDropDownMenu *)menu selectedItem:(NSString *)selection placeID:(NSString *)placeID;

@end


@interface GolopoDropDownMenu : UIView <UITableViewDataSource, UITableViewDelegate> {
    UITableView *dropDownTableView;
    NSArray *tableData, *placeIDData;
}

@property (nonatomic, strong) id<GolopoDropDownMenuDelegate> delegate;
@property (nonatomic, strong) NSArray *menuItems;

@end
