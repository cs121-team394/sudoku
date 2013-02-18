//
//  GridModel.h
//  Sudoku
//
//  Created by Greg Kronmiller on 2/9/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GridModel : NSObject
{
    NSMutableArray* grid;
}

// See the comment on isConsistentFor.
@property (readonly) int rowConflictIndex;
@property (readonly) int columnConflictIndex;
@property (readonly) int boxConflictRow;
@property (readonly) int boxConflictColumn;

-(char) getValueAtRow: (int)row AndColumn: (int)column;
-(void) setValueTo: (char)value AtRow: (int)row AndColumn: (int)column;

-(bool) getMutabilityAtRow: (int)row AndColumn: (int)column;
-(void) setMutabilityTo: (bool)mutability AtRow: (int)row AndColumn: (int)column;

// Returns true if the grid would be no less consistent with the specified value added
// in the specified row and column.
// Also sets the four properties rowConflictIndex, columnConflictIndex,
// boxConflictRow, and boxConflictColumn.
// rowConflictIndex is the column coordinate of the cell that conflicts because
// it's in the same row, or -1 if there is no such conflicting cell.
// columnConflictIndex is the row coordinate of the cell that conflicts because
// it's in the same column, or -1 if there is no such conflicting cell.
// boxConflictRow and boxConflictColumn are the coordinates of the cell that conflicts because
// it's in the same box, or -1 if there is no such conflicting cell.
// All four of those properties are valid until the next call to isConsistentFor;
// this is true regardless of the value returned by that call.
-(bool) isConsistentFor: (char)value AtRow: (int)row AndColumn: (int)column;

-(bool) isFull;
-(bool) isAllConsistent;

@end
