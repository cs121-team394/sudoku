//
//  GridView.m
//  Sudoku
//
//  Created by Greg Kronmiller on 2/10/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import "GridView.h"
#import "CellView.h"

@implementation GridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        target = nil;
        message = nil;
        
        self.backgroundColor = [UIColor blackColor];
        
        // precalculate some values related to cell sizes
        int boardWidth = self.bounds.size.width;
        int boardHeight = self.bounds.size.height;
        int cellWidth = [self getCellSize: boardWidth];
        int cellHeight = [self getCellSize: boardHeight];
        
        CellView* currentCell;
        grid = [[NSMutableArray alloc] init];
        
        for (int r=0; r<9; r++) {
            NSMutableArray* row = [[NSMutableArray alloc] init];
            
            for (int c=0; c<9; c++) {
                // calculate the position of the button
                int leftX = [self getOffsetForCell: c NumberOfPixels: boardWidth];
                int topY = [self getOffsetForCell: r NumberOfPixels: boardHeight];
                CGRect cellFrame = CGRectMake(leftX, topY, cellWidth, cellHeight);
                
                // create the button and add as a subview
                currentCell = [[CellView alloc] initWithFrame: cellFrame Row: r Column: c BackgroundColor:self.backgroundColor];
                
                // make the button clickable, visible, and put it in our array of buttons.
                [currentCell setCellSelectionTarget: self action: @selector(cellSelected:)];
                [currentCell setFlashTimeoutTarget: self action: @selector(flashTimedOut:)];
                [self addSubview: currentCell];
                [row addObject: currentCell];
            }
            
            [grid addObject: row];
        }
    }
    return self;
}

-(void) setTarget: (id)sender action: (SEL)action
{
    target = sender;
    message = action;
}

-(void) cellSelected: (id)sender
{
    CellView* selected = sender;
    
    _selectedRow = selected.row;
    _selectedColumn = selected.column;
    
    if (target != nil && message != nil) {
        [target performSelector: message];
    }
}

-(void) flashTimedOut: (id)sender
{
    for (int r=0; r<9; r++) {
        NSMutableArray* row = [grid objectAtIndex: r];
        
        for (int c=0; c<9; c++) {
            CellView* cell = [row objectAtIndex: c];
            
            [cell unflashInvalid];
        }
    }
}

-(int) getCellSize: (int)boardLength
{
    return boardLength * 0.1;
}

-(int) getOffsetForCell: (int)coordinate NumberOfPixels: (int)boardLength
{
    int cellSize = [self getCellSize: boardLength];
    int divisionSize = cellSize * 0.25;
    int offsetDueToCells = coordinate * cellSize;
    int offsetDueToDivisions = (1 + coordinate/3)*divisionSize;
    // Calculate the far right according to these values, subtract from the actual
    // far right, give half of that to the left side.
    int offsetDueToRounding = (boardLength - 9*cellSize - 4*divisionSize)/2;
    return offsetDueToCells + offsetDueToDivisions + offsetDueToRounding;
}

-(void) setCellValueTo: (char)value AtRow: (int)row AndColumn: (int)column
{
    CellView* cell = [[grid objectAtIndex: row] objectAtIndex: column];
    [cell setValue: value];
}

-(void) setCellMutabilityTo: (bool)isMutable AtRow: (int)row AndColumn: (int)column
{
    CellView* cell = [[grid objectAtIndex: row] objectAtIndex: column];
    
    if (isMutable) {
        [cell markAsMutable];
    }
    else {
        [cell markAsImmutable];
    }
}

-(void) flashCellInconsistentAtRow: (int)row AndColumn: (int)column
{
    CellView* cell = [[grid objectAtIndex: row] objectAtIndex: column];
    
    [cell flashInvalid];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
