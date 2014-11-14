//
//  GolopoDropDownMenu.h
//  drop down
//
//  Created by Sudeep Jaiswal on 13/09/14.
//  Copyright (c) 2014 Sudeep Jaiswal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SJDropDownMenu;

@protocol SJDropDownMenuDelegate <NSObject>

-(void)sjMenu:(SJDropDownMenu *)menu selectedItem:(NSString *)selection placeID:(NSString *)placeID;

@end


@interface SJDropDownMenu : UIView <UITableViewDataSource, UITableViewDelegate> {
    UITableView *dropDownTableView;
    NSArray *tableData, *placeIDData;
}

@property (nonatomic, strong) id<SJDropDownMenuDelegate> delegate;
@property (nonatomic, strong) NSArray *menuItems;

@end
