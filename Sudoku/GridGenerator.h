//
//  GridGenerator.h
//  Sudoku
//
//  Created by Greg Kronmiller on 2/13/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GridModel.h"

@interface GridGenerator : NSObject

-(GridModel*) generateGrid;

@end
