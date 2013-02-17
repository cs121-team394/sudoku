//
//  ViewController.m
//  Sudoku
//
//  Created by Greg Kronmiller on 2/13/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import "ViewController.h"
#import "GridGeneratorFromFile.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithRed: 0.0 green: 0.4 blue: 0.5 alpha: 1.0];
    
    NSString* filename = [[NSBundle mainBundle] pathForResource: @"grid2" ofType: @"txt"];
    generator = [[GridGeneratorFromFile alloc] initWithFile: filename];
    
    // calculate size parameters
    int width = self.view.bounds.size.width;
    int height = self.view.bounds.size.height;
    int smallerSize = MIN(width, height);
    int gridWidth = smallerSize * 0.8;
    
    int gridX = smallerSize * 0.1;
    int gridY = smallerSize * 0.1;
    gridFrame = CGRectMake(gridX, gridY, gridWidth, gridWidth);
    
    int numPadX = gridX;
    int numPadY = smallerSize;
    // TODO: Change the final argument here so that the NumPad buttons are the dimensions we want.
    numPadFrame = CGRectMake(numPadX, numPadY, gridWidth, smallerSize*0.15);
    
    // create the numPad
    numPad = [[NumPadView alloc] initWithFrame: numPadFrame];
    [self.view addSubview: numPad];
    
    [self loadNewGrid];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(void) loadNewGrid
{
    theGridModel = [generator generateGrid];
    
    // create the grid
    theGridView = [[GridView alloc] initWithFrame: gridFrame];
    [self.view addSubview: theGridView];
    [theGridView setTarget: self action: @selector(cellSelected)];
    
    // sync the view with the model
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            char value = [theGridModel getValueAtRow: r AndColumn: c];
            [theGridView setCellValueTo: value AtRow: r AndColumn: c];
            [theGridView setCellMutabilityTo: [theGridModel getMutabilityAtRow: r AndColumn: c] AtRow: r AndColumn: c];
        }
    }
}

-(void) checkForVictory
{
    if ([theGridModel isFull] && [theGridModel isAllConsistent]) {
        [self loadNewGrid];
    }
}

-(void) cellSelected
{
    char digit = numPad.selectedDigit;
    
    if (digit != ' ') {
        int row = theGridView.selectedRow;
        int column = theGridView.selectedColumn;
        
        if ([theGridModel getMutabilityAtRow: row AndColumn: column] &&
            [theGridModel isConsistentFor: digit AtRow: row AndColumn: column]) {
            
            [theGridModel setValueTo: digit AtRow: row AndColumn: column];
            [theGridView setCellValueTo: digit AtRow: row AndColumn: column];
            
            [self checkForVictory];
        }
    }
}

@end
