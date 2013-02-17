//
//  GridView.h
//  Sudoku
//
//  Created by Greg Kronmiller on 2/13/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridView : UIView
{
    NSMutableArray* grid;
    
    id target;
    SEL message;
}

@property (readonly) int selectedRow;
@property (readonly) int selectedColumn;

-(void) setTarget: (id)sender action: (SEL)action;

-(void) setCellValueTo: (char)value AtRow: (int)row AndColumn: (int)column;
-(void) setCellMutabilityTo: (bool)isMutable AtRow: (int)row AndColumn: (int)column;
-(void) flashCellInconsistentAtRow: (int)row AndColumn: (int)column;

@end
