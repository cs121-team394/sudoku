//
//  GridGenerator.m
//  Sudoku
//
//  Created by Greg Kronmiller on 2/13/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import "GridGenerator.h"

@implementation GridGenerator

const char origBoard[9][9] = {
    { '7', ' ', ' ',   '6', ' ', ' ',   ' ', '3', '8' },
    { ' ', ' ', '2',   '5', '8', '1',   ' ', '4', ' ' },
    { ' ', '9', ' ',   ' ', ' ', ' ',   ' ', ' ', ' ' },
    
    { '4', '5', '6',   ' ', ' ', ' ',   '8', '9', '3' },
    { '2', ' ', '9',   ' ', ' ', '4',   '6', ' ', ' ' },
    { ' ', ' ', ' ',   ' ', '6', '5',   ' ', ' ', '2' },
    
    { ' ', ' ', '5',   '4', ' ', '6',   ' ', '1', '7' },
    { ' ', ' ', ' ',   '3', ' ', ' ',   ' ', ' ', '4' },
    { '9', '4', ' ',   ' ', '7', ' ',   '2', ' ', ' ' }
};

-(GridModel*) generateGrid
{
    GridModel* grid = [[GridModel alloc] init];
    
    for (int r=0; r<9; r++) {
        for (int c=0; c<9; c++) {
            [grid setValueTo: origBoard[r][c] AtRow: r AndColumn: c];
            [grid setMutabilityTo: (origBoard[r][c] == ' ') AtRow: r AndColumn: c];
        }
    }
    
    return grid;
}

@end
