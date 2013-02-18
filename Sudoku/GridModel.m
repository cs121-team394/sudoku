//
//  GridModel.m
//  Sudoku
//
//  Created by Greg Kronmiller on 2/9/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import "GridModel.h"
#import "CellModel.h"


@implementation GridModel

-(id) init
{
    grid = [[NSMutableArray alloc] init];
    
    CellModel* currentCell;
    
    for (int r=0; r<9; r++) {
        NSMutableArray* row = [[NSMutableArray alloc] init];
        
        for (int c=0; c<9; c++) {
            currentCell = [[CellModel alloc] initWithValue: ' ' Mutability: true];
            [row addObject: currentCell];
        }
        
        [grid addObject: row];
    }
    
    return self;
}

-(char) getValueAtRow: (int)row AndColumn: (int)column
{
    CellModel* cell = [[grid objectAtIndex: row] objectAtIndex: column];
    return cell.value;
}

-(void) setValueTo: (char)value AtRow: (int)row AndColumn: (int)column
{
    CellModel* cell = [[grid objectAtIndex: row] objectAtIndex: column];
    cell.value = value;
}

-(bool) getMutabilityAtRow: (int)row AndColumn: (int)column
{
    CellModel* cell = [[grid objectAtIndex: row] objectAtIndex: column];
    return cell.mutability;
}

-(void) setMutabilityTo: (bool)mutability AtRow: (int)row AndColumn: (int)column
{
    CellModel* cell = [[grid objectAtIndex: row] objectAtIndex: column];
    cell.mutability = mutability;
}

-(bool) isConsistentFor: (char)value AtRow: (int)row AndColumn: (int)column
{
    _rowConflictIndex = -1;
    _columnConflictIndex = -1;
    _boxConflictRow = -1;
    _boxConflictColumn = -1;
    
    if (value == ' ') {
        return true;
    }
    
    bool consistent = true;
    
    // Check the row.
    for (int c = 0; c < 9; c++) {
        if (c != column) {
            if ([self getValueAtRow: row AndColumn: c] == value) {
                _rowConflictIndex = c;
                consistent = false;
            }
        }
    }
    
    // Check the column.
    for (int r = 0; r < 9; r++) {
        if (r != row) {
            if ([self getValueAtRow: r AndColumn: column] == value) {
                _columnConflictIndex = r;
                consistent = false;
            }
        }
    }
    
    // Check the box.
    for (int r = (row/3)*3; r < (row/3)*3 + 3; r++) {
        for (int c = (column/3)*3; c < (column/3)*3 + 3; c++) {
            if ( !(r == row && c == column) ) {
                if ([self getValueAtRow: r AndColumn: c] == value) {
                    _boxConflictRow = r;
                    _boxConflictColumn = c;
                    consistent = false;
                }
            }
        }
    }
    
    return consistent;
}

-(bool) isFull
{
    bool full = true;
    
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            if ([self getValueAtRow: r AndColumn: c] == ' ') {
                full = false;
            }
        }
    }
    
    return full;
}

-(bool) isAllConsistent
{
    bool consistent = true;
    
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            if ( !([self isConsistentFor: [self getValueAtRow: r AndColumn: c] AtRow: r AndColumn: c]) ) {
                consistent = false;
            }
        }
    }
    
    return consistent;
}

@end
