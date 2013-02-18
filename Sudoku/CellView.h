//
//  CellView.h
//  Sudoku
//
//  Created by Greg Kronmiller on 2/10/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellView : UIView
{
//    UIColor* background;
    UIButton* button;
    
    bool currentlyFlashing;
    
    id cellSelectionTarget;
    SEL cellSelectionAction;
    id flashTimeoutTarget;
    SEL flashTimeoutAction;
}

@property (readonly) int row;
@property (readonly) int column;

-(id) initWithFrame : (CGRect)frame Row: (int)r Column: (int)c BackgroundColor: (UIColor*)bgColor;

-(void) unhighlight;
-(void) highlight;

-(void) unflashInvalid;
-(void) flashInvalid;

-(void) markAsMutable;
-(void) markAsImmutable;

-(void) setValue: (char)value;

-(void) setCellSelectionTarget: (id)sender action: (SEL)action;
-(void) setFlashTimeoutTarget: (id)sender action: (SEL)action;

@end
