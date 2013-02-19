//
//  ViewController.m
//  Sudoku
//
//  Created by Greg Kronmiller on 2/9/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import "ViewController.h"
#import "GridGeneratorFromFile.h"
#import <QuartzCore/QuartzCore.h>

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
    int gridY = smallerSize * 0.13;
    gridFrame = CGRectMake(gridX, gridY, gridWidth, gridWidth);
    
    int numPadX = gridX;
    int numPadHeight = gridWidth*0.15;
    int numPadY = height - width * 0.1 - numPadHeight;
    // TODO: Change the final argument here so that the NumPad buttons are the dimensions we want.
    numPadFrame = CGRectMake(numPadX, numPadY, gridWidth, numPadHeight);
    
    int buttonWidth = width * 0.3;
    int buttonHeight = width * 0.07;
    int newGameX = width * 0.15;
    int newGameY = width * 0.03;
    CGRect newGameButtonFrame = CGRectMake(newGameX, newGameY, buttonWidth, buttonHeight);

    int resetX = width - newGameX - buttonWidth;
    CGRect resetButtonFrame = CGRectMake(resetX, newGameY, buttonWidth, buttonHeight);
    
    // create the numPad
    numPad = [[NumPadView alloc] initWithFrame: numPadFrame];
    [self.view addSubview: numPad];
    
    // create new game button
    UIButton* newGameButton = [self createButtonInFrame:newGameButtonFrame WithText:@"New Game"];
    [newGameButton addTarget:self action:@selector(loadNewGrid)
            forControlEvents:UIControlEventTouchUpInside];
    
    // create reset button
    UIButton* resetButton = [self createButtonInFrame:resetButtonFrame WithText:@"Reset Board"];
    [resetButton addTarget:self action:@selector(resetGrid)
            forControlEvents:UIControlEventTouchUpInside];
    
    // create congratulations label
    CGRect labelFrame = CGRectMake(width * 0.1, width*0.96, width * 0.8, width * 0.1);
    congrats = [[UILabel alloc] initWithFrame:labelFrame];
    
    congrats.text = @"Congratulations!";
    [congrats setTextColor:[UIColor cyanColor]];
    [congrats setTextAlignment:UITextAlignmentCenter];
    [congrats setFont:[UIFont systemFontOfSize:60]];
    congrats.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    
    [self.view addSubview:congrats];
    
    [congrats setHidden:true];
    
    
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
    
    [congrats setHidden:true];
}

-(void) resetGrid
{
    for (int r = 0; r < 9; r++) {
        for (int c = 0; c < 9; c++) {
            if ([theGridModel getMutabilityAtRow: r AndColumn: c]) {
                [theGridModel setValueTo: ' ' AtRow: r AndColumn: c];
                [theGridView setCellValueTo: ' ' AtRow: r AndColumn: c];
            }
        }
    }
    
    [congrats setHidden:true];
}

-(void) checkForVictory
{
    if ([theGridModel isFull] && [theGridModel isAllConsistent]) {
        [congrats setHidden:false];
    }
}

-(void) cellSelected
{
    char digit = numPad.selectedDigit;
    
    int row = theGridView.selectedRow;
    int column = theGridView.selectedColumn;
        
    if ([theGridModel getMutabilityAtRow: row AndColumn: column]) {
        if ([theGridModel isConsistentFor: digit AtRow: row AndColumn: column]) {
            [theGridModel setValueTo: digit AtRow: row AndColumn: column];
            [theGridView setCellValueTo: digit AtRow: row AndColumn: column];
            
            [self checkForVictory];
        }
        else {
            [theGridView flashCellInconsistentAtRow: row AndColumn: column];
            
            if (theGridModel.rowConflictIndex >= 0) {
                [theGridView flashCellInconsistentAtRow: row AndColumn: theGridModel.rowConflictIndex];
            }
            if (theGridModel.columnConflictIndex >= 0) {
                [theGridView flashCellInconsistentAtRow: theGridModel.columnConflictIndex AndColumn: column];
            }
            if (theGridModel.boxConflictRow >= 0 && theGridModel.boxConflictColumn >= 0) {
                [theGridView flashCellInconsistentAtRow: theGridModel.boxConflictRow AndColumn: theGridModel.boxConflictColumn];
            }
        }
    }
}

-(UIButton*) createButtonInFrame: (CGRect)frame WithText: (NSString*)text
{
//    UIButton* button = [[UIButton alloc] initWithFrame:frame];
    UIButton* button = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    
    button.frame = frame;
    [button setTintColor: [UIColor colorWithRed: 0.0 green: 0.4 blue: 0.5 alpha: 1.0]];
    
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName: @"Helvetica" size: 32];
    [[button layer] setCornerRadius: 8];
//    button.showsTouchWhenHighlighted = true;
    [self.view addSubview:button];
    
    return button;
}

@end
