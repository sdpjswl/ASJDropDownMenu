//
//  GolopoDropDownMenu.m
//  drop down
//
//  Created by Sudeep Jaiswal on 13/09/14.
//  Copyright (c) 2014 Sudeep Jaiswal. All rights reserved.
//

#import "GolopoDropDownMenu.h"

@implementation GolopoDropDownMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self.layer setCornerRadius:3.0];
        [self setBackgroundColor:[[UIColor clearColor] colorWithAlphaComponent:0.8]];
        
        [self addTableViewToDropDownMenu];
    }
    return self;
}

-(void)setMenuItems:(NSArray *)menuItems {
    
    // array contains place name and place id. we shall return the corresponding place id as well for the subsequent get request
    // autocomplete results
    if ([[menuItems firstObject] isKindOfClass:[NSDictionary class]]) {
        placeIDData = [menuItems valueForKey:@"placeID"];
        tableData = [[NSArray alloc] initWithArray:[menuItems valueForKey:@"name"]];
    }
    
    // category results
    else {
        placeIDData = nil;
        tableData = [[NSArray alloc] initWithArray:menuItems];
    }
    
    [self reloadTable];
}

-(void)addTableViewToDropDownMenu {
    
    if (dropDownTableView == nil) {
        
        int x = self.bounds.origin.x;
        int y = self.bounds.origin.y;
        int width = self.bounds.size.width;
        int height = self.bounds.size.height;
        CGRect tvFrame = CGRectMake(x, y, width, height);
        
        dropDownTableView = [[UITableView alloc] initWithFrame:tvFrame style:UITableViewStylePlain];
        [dropDownTableView setDataSource:self];
        [dropDownTableView setDelegate:self];
        [dropDownTableView setScrollEnabled:YES];
        [dropDownTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [dropDownTableView setBackgroundColor:[UIColor clearColor]];
        [dropDownTableView.layer setCornerRadius:3.0];
        [self addSubview:dropDownTableView];
    }
    else {
        [dropDownTableView setFrame:self.bounds];
    }
    
    [self reloadTable];
}

-(void)reloadTable {
    
    if (tableData != nil) {
        [dropDownTableView reloadData];
    }
}


#pragma mark - Table view methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 33.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14.0]];
        [cell.layer setCornerRadius:3.0];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TextField.png"]]];
        [cell.backgroundView.layer setCornerRadius:3.0];
        
    }
    [cell.textLabel setText:[tableData objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(golopoMenu:selectedItem:placeID:)]) {
        
        NSString *itemSelected = [tableData objectAtIndex:indexPath.row];
        NSString *placeID;
        if (placeIDData != nil) {
            placeID = [placeIDData objectAtIndex:indexPath.row];
        }
        else {
            placeID = nil;
        }
        
        [self.delegate golopoMenu:self selectedItem:itemSelected placeID:placeID];
    }
}

@end
