//
//  ViewController.h
//  Sudoku
//
//  Created by Greg Kronmiller on 2/13/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridGenerator.h"
#import "GridModel.h"
#import "GridView.h"
#import "NumpadView.h"

@interface ViewController : UIViewController
{
    GridGenerator* generator;
    GridModel* theGridModel;
    GridView* theGridView;
    NumPadView* numPad;
    
    CGRect gridFrame;
    CGRect numPadFrame;
}

-(void) loadNewGrid;

-(void) checkForVictory;

-(void) cellSelected;

@end
