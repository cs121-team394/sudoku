//
//  SudokuTests.m
//  SudokuTests
//
//  Created by Greg Kronmiller on 2/13/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import "SudokuTests.h"
#import "GridGeneratorFromFile.h"

@implementation Sudoku_v3Tests

char consistent_board[9][9] = {
    { '1', '2', '3',   '4', '5', '6',   '7', '8', '9' },
    { '4', '5', '6',   '7', '8', '9',   '1', '2', '3' },
    { '7', '8', '9',   '1', '2', '3',   '4', '5', '6' },
    
    { '2', '3', '4',   '5', '6', '7',   '8', '9', '1' },
    { '5', '6', '7',   '8', '9', '1',   '2', '3', '4' },
    { '8', '9', '1',   '2', '3', '4',   '5', '6', '7' },
    
    { '3', '4', '5',   '6', '7', '8',   '9', '1', '2' },
    { '6', '7', '8',   '9', '1', '2',   '3', '4', '5' },
    { '9', '1', '2',   '3', '4', '5',   '6', '7', '8' }
};


- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    //    grid = [[GridModel alloc] init];
    //    generator = [[GridGeneratorFromFile alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

// Test [GridModel isConsistent]
-(void) gridRowInconsistent
{
    grid = [[GridModel alloc] init];
    [grid setValueTo: '1' AtRow: 0 AndColumn: 0];
    STAssertFalse([grid isConsistentFor: '1' AtRow: 0 AndColumn: 3], @"Grid failed to recognize inconsistency within row.");
}

-(void) gridColumnInconsistent
{
    grid = [[GridModel alloc] init];
    [grid setValueTo: '1' AtRow: 0 AndColumn: 0];
    STAssertFalse([grid isConsistentFor: '1' AtRow: 3 AndColumn: 0], @"Grid failed to recognize inconsistency within column.");
}

-(void) gridBoxInconsistent
{
    grid = [[GridModel alloc] init];
    [grid setValueTo: '1' AtRow: 0 AndColumn: 0];
    STAssertFalse([grid isConsistentFor: '1' AtRow: 1 AndColumn: 1], @"Grid failed to recognize inconsistency within box.");
}

-(void) gridCellConsistent
{
    grid = [[GridModel alloc] init];
    // Grid is initialized blank, so should be consistent for anything anywhere.
    STAssertTrue([grid isConsistentFor: '1' AtRow: 0 AndColumn: 0], @"Grid failed to recognize consistency.");
}

-(void) gridValueConsistentWithSelf
{
    grid = [[GridModel alloc] init];
    [grid setValueTo: '1' AtRow: 0 AndColumn: 0];
    STAssertTrue([grid isConsistentFor: '1' AtRow: 0 AndColumn: 0], @"Grid failed to recognize consistency for overwriting a cell with its same value.");
}

-(void) gridValueConsistentWithOther
{
    grid = [[GridModel alloc] init];
    
    [grid setValueTo: '1' AtRow: 0 AndColumn: 0];
    [grid setValueTo: '2' AtRow: 1 AndColumn: 0];
    
    STAssertFalse([grid isConsistentFor: '2' AtRow: 0 AndColumn: 0], @"Grid failed to recognize inconsistency when overwriting a cell with a different value.");
    STAssertTrue([grid isConsistentFor: '3' AtRow: 0 AndColumn: 0], @"Grid failed to recognize consistency when overwriting a cell with a different value.");
}

-(void) gridConsistentForBlank
{
    grid = [[GridModel alloc] init];
    
    [grid setValueTo: '1' AtRow: 0 AndColumn: 0];
    
    STAssertTrue([grid isConsistentFor: ' ' AtRow: 0 AndColumn: 0], @"Grid failed to recognize consistency for overwriting a cell with a blank.");
    STAssertTrue([grid isConsistentFor: ' ' AtRow: 1 AndColumn: 0], @"Grid failed to recognize consistency for putting a blank in an empty cell.");
}

-(void) immutableGridCellConsistent
{
    grid = [[GridModel alloc] init];
    
    [grid setValueTo: '1' AtRow: 0 AndColumn: 0];
    [grid setMutabilityTo: false AtRow: 0 AndColumn: 0];
    
    STAssertTrue([grid isConsistentFor: '2' AtRow: 0 AndColumn: 0], @"Grid failed to recognize consistency for overwriting an immutable cell.");
}

// Test [GridModel isFull] and [GridModel isAllConsistent]
-(void) gridFullAndConsistent
{
    grid = [[GridModel alloc] init];
    
    [grid setValueTo: '1' AtRow: 0 AndColumn: 0];
    [grid setValueTo: '1' AtRow: 0 AndColumn: 1];
    STAssertFalse([grid isAllConsistent], @"Grid wrongly thought it was consistent.");
    
    for (int r=0; r<9; r++) {
        for (int c=0; c<9; c++) {
            STAssertFalse([grid isFull], @"Grid wrongly thought it was full.");
            [grid setValueTo: consistent_board[r][c] AtRow: r AndColumn: c];
        }
    }
    
    STAssertTrue([grid isFull], @"Grid wrongly thought it was not full.");
    STAssertTrue([grid isAllConsistent], @"Grid wrongly thought it was not consistent.");
    
    [grid setValueTo: '3' AtRow: 0 AndColumn: 0];
    [grid setValueTo: '3' AtRow: 0 AndColumn: 1];
    STAssertFalse([grid isAllConsistent], @"Grid wrongly thought it was consistent.");
}


// Test [GridGeneratorFromFile initWithFile]
-(void) generatorWithInvalidFile
{
    STAssertThrows([[GridGeneratorFromFile alloc] initWithFile: @"thisFileDoesntExist"], @"GridGeneratorFromFile didn't fail to generate from a nonexistent file.");
}

-(void) generatorWithInvalidCharacter
{
    STAssertThrows([[GridGeneratorFromFile alloc] initWithFile: @"invalid_char_test.txt"], @"GridGeneratorFromFile didn't fail to generate from a file with an invalid character.");
}

-(void) generatorWithPuzzleOfIncorrectLength
{
    STAssertThrows([[GridGeneratorFromFile alloc] initWithFile: @"short_sudoku_test.txt"], @"GridGeneratorFromFile didn't fail to generate from a file with a short description of a sudoku puzzle.");
    
    STAssertThrows([[GridGeneratorFromFile alloc] initWithFile: @"long_sudoku_test.txt"], @"GridGeneratorFromFile didn't fail to generate from a file with a long description of a sudoku puzzle.");
}

// -(void) generatorYieldsUniqueSolution

@end
