//
//  NumPadView.m
//  Sudoku
//
//  Created by Greg Kronmiller on 2/10/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import "NumPadView.h"
#import "CellView.h"

const double verticalButtonFraction = 0.667;
const double horizontalButtonFraction = 0.095;
const int numberOfButtons = 10;

@implementation NumPadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        buttons = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor blackColor];
        
        int myWidth = self.bounds.size.width;
        int myHeight = self.bounds.size.height;
        int buttonWidth = myWidth * horizontalButtonFraction;
        int buttonHeight = myHeight * verticalButtonFraction;
        int horizontalPadding = (myWidth - buttonWidth * numberOfButtons) / 2;
        int verticalPadding = (myHeight - buttonHeight) / 2;
        
        CellView* currentButton;
        
        for (int c = 0; c < numberOfButtons; c++) {
            // Create a button at (horizontalPadding + x*buttonWidth, verticalPadding)
            int leftX = horizontalPadding + c*buttonWidth;
            int topY = verticalPadding;
            CGRect buttonFrame = CGRectMake(leftX, topY, buttonWidth, buttonHeight);
            currentButton = [[CellView alloc] initWithFrame: buttonFrame Row: 0 Column: c BackgroundColor:self.backgroundColor];
            
            [currentButton setValue: [self getDigitFromIndex: c]];
            
            [currentButton setCellSelectionTarget: self action: @selector(buttonPressed:)];
            [self addSubview: currentButton];
            [buttons addObject: currentButton];
        }
        
        _selectedDigit = ' ';
        [self highlightButtonForDigit:_selectedDigit];

    }
    return self;
}

-(char) getDigitFromIndex: (int)index
{
    if (index == 0) {
        return ' ';
    } else {
        return (char) (index + '0');
    }
}

-(int) getIndexFromDigit: (char)digit
{
    if (digit == ' ') {
        return 0;
    } else {
        return (int) (digit - '0');
    }
}

-(void) highlightButtonForDigit: (char)digit
{
    int index = [self getIndexFromDigit: digit];
    CellView* button = [buttons objectAtIndex: index];
    [button highlight];
}

-(void) unhighlightButtonForDigit: (char)digit
{
    int index = [self getIndexFromDigit: digit];
    CellView* button = [buttons objectAtIndex: index];
    [button unhighlight];
}

-(void) selectDigit: (char)digit
{
    [self unhighlightButtonForDigit: _selectedDigit];
    [self highlightButtonForDigit: digit];
    _selectedDigit = digit;
}

-(void) buttonPressed: (id)sender
{
    CellView* selected = sender;
    [self selectDigit: [self getDigitFromIndex: selected.column]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
