//
//  CellModel.m
//  Sudoku
//
//  Created by Greg Kronmiller on 2/13/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel

-(id)initWithValue: (char)inputValue Mutability: (bool)inputMutability
{
    value = inputValue;
    mutability = inputMutability;
    
    return self;
}

@synthesize value;
@synthesize mutability;

@end
