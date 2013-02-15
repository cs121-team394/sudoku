//
//  SudokuTests.h
//  SudokuTests
//
//  Created by Greg Kronmiller on 2/13/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "GridModel.h"
#import "GridGenerator.h"

@interface Sudoku_v3Tests : SenTestCase
{
    GridModel* grid;
    GridGenerator* generator;
}

// Test [GridModel isConsistent]
-(void) gridRowInconsistent;
-(void) gridColumnInconsistent;
-(void) gridBoxInconsistent;
-(void) gridCellConsistent;
-(void) gridValueConsistentWithSelf;
-(void) gridValueConsistentWithOther;
-(void) gridConsistentForBlank;
-(void) immutableGridCellConsistent;

// Test [GridModel isFull] and [GridModel isAllConsistent]
-(void) gridFullAndConsistent;

// Test [GridGeneratorFromFile initWithFile]
-(void) generatorWithInvalidFile;
-(void) generatorWithInvalidCharacter;
-(void) generatorWithPuzzleOfIncorrectLength;
// -(void) generatorYieldsUniqueSolution;

@end
