//
//  GridModel.h
//  Sudoku
//
//  Created by Greg Kronmiller on 2/13/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GridModel : NSObject
{
    NSMutableArray* grid;
}

-(char) getValueAtRow: (int)row AndColumn: (int)column;
-(void) setValueTo: (char)value AtRow: (int)row AndColumn: (int)column;

-(bool) getMutabilityAtRow: (int)row AndColumn: (int)column;
-(void) setMutabilityTo: (bool)mutability AtRow: (int)row AndColumn: (int)column;

-(bool) isConsistentFor: (char)value AtRow: (int)row AndColumn: (int)column;

-(bool) isFull;
-(bool) isAllConsistent;

@end
