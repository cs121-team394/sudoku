//
//  GridGeneratorFromFile.m
//  Sudoku
//
//  Created by Greg Kronmiller on 2/13/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import "GridGeneratorFromFile.h"
#import "GridModel.h"

@implementation GridGeneratorFromFile

-(id) initWithFile: (NSString *)filename
{
    self = [super init];
    
    NSError* error;
    NSString* fileContents = [[NSString alloc] initWithContentsOfFile: filename encoding: NSUTF8StringEncoding error: &error];
    
    NSAssert(error == nil, @"Could not find file containing list of Sudoku grids.");
    
    grids = [fileContents componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    index = 0;
    
    return self;
}

-(GridModel*) generateGrid
{
    NSString* gridDescription = [grids objectAtIndex: index];
    
    NSAssert([gridDescription length] == 81, @"Grid description of incorrect length.");
    
    GridModel* grid = [[GridModel alloc] init];
    
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            char value = [gridDescription characterAtIndex: 9*r + c];
            if (value != '.') {
                NSAssert('1' <= value && value <= '9', @"Invalid character in grid description.");
                [grid setValueTo: value AtRow: r AndColumn: c];
                [grid setMutabilityTo: false AtRow: r AndColumn: c];
            }
        }
    }
    
    NSAssert([grid isAllConsistent], @"Inconsistent grid in file.");
    
    index++;
    
    return grid;
}

@end
