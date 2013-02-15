//
//  CellModel.h
//  Sudoku
//
//  Created by Greg Kronmiller on 2/13/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject

-(id)initWithValue: (char)inputValue Mutability: (bool)inputMutability;

@property char value;
@property bool mutability;

@end
