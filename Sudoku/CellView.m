//
//  CellView.m
//  Sudoku
//
//  Created by Greg Kronmiller on 2/10/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import "CellView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CellView

-(id) initWithFrame : (CGRect)frame Row: (int)r Column: (int)c BackgroundColor: (UIColor*)bgColor
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        _row = r;
        _column = c;
        self.backgroundColor = bgColor;
        cellSelectionTarget = nil;
        cellSelectionAction = nil;
        
        CGRect subframe = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);

        button = [[UIButton alloc] initWithFrame: subframe];
        
        // set the appearance of the button
        [self unhighlight];
        
        [[button layer] setBackgroundColor: [UIColor whiteColor].CGColor];
//        [[button layer] setCornerRadius: 8];
        [self markAsImmutable];
        int fontSize = MIN(frame.size.width, frame.size.height) * 0.9;
        button.titleLabel.font = [UIFont fontWithName: @"Helvetica" size: fontSize];
        
        [self addSubview: button];
        [button addTarget: self action: @selector(buttonPressed:) forControlEvents: UIControlEventTouchDown];
        [button addTarget: self action: @selector(buttonUnpressed:) forControlEvents: (UIControlEventTouchUpInside | UIControlEventTouchUpOutside)];
    }
    return self;
}

-(void) unhighlight
{
    [[button layer] setBorderWidth: 1];
    [[button layer] setBorderColor: self.backgroundColor.CGColor];
}
-(void) highlight
{
    [[button layer] setBorderWidth: 6];
    [[button layer] setBorderColor: [UIColor cyanColor].CGColor];
}

-(void) unflashInvalid
{
    [[button layer] setBackgroundColor: [UIColor whiteColor].CGColor];
    
    currentlyFlashing = false;
}
-(void) flashInvalid
{
    [[button layer] setBackgroundColor: [UIColor redColor].CGColor];
    
    currentlyFlashing = true;
}

-(void) markAsMutable
{
    [button setTitleColor: [UIColor blueColor] forState: UIControlStateNormal];
}

-(void) markAsImmutable
{
    [button setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
}

-(void) setValue: (char)value
{
    [button setTitle: [[NSString alloc] initWithFormat: @"%c", value] forState: UIControlStateNormal];
}

-(void) setCellSelectionTarget: (id)sender action: (SEL)action
{
    cellSelectionTarget = sender;
    cellSelectionAction = action;
}

-(void) setFlashTimeoutTarget: (id)sender action: (SEL)action
{
    flashTimeoutTarget = sender;
    flashTimeoutAction = action;
}

-(void) buttonPressed: (id)sender
{
    if (cellSelectionTarget != nil && cellSelectionAction != nil) {
        [cellSelectionTarget performSelector: cellSelectionAction withObject: self];
    }
}

-(void) buttonUnpressed: (id)sender
{
    if (currentlyFlashing) {
        [self unflashInvalid];
        [flashTimeoutTarget performSelector: flashTimeoutAction withObject: self];
    }
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
