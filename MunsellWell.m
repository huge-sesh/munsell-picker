//
//  MunsellWell.m
//  munsell wheel
//
//  Created by jeff on 3/21/14.
//  Copyright (c) 2014 jeff. All rights reserved.
//

#import "MunsellWell.h"
#import "MunsellColor.h"
#import "WheelController.h"
@implementation MunsellWell
@synthesize munsellColor;
@synthesize isPalette;
@synthesize isSpectrum;


- (void) activate:(BOOL)exclusive {
    [(WheelController*)[[self window] delegate] setCurrentWell:self];
    [self deactivate];
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    if (isSpectrum) {
        [self setBordered:NO];
        [super drawRect:dirtyRect];
        [self setBordered:YES];
    } else {
        [super drawRect:dirtyRect];
    }
}

- (void) setMunsellColor:(MunsellColor *)color
{
    [self setMunsellColor:color offset:nil];
}

- (void) setMunsellColor:(MunsellColor *)inColor offset:(NSArray*)offset
{
    munsellColor = [[inColor copy] offset:offset];
    NSColor* __color = [munsellColor nsColor];
    if (__color) {
        [self setColor:__color];
        [self setHidden:NO];
    } else {
        [self setHidden:YES];
    }
}

- (void) deselect
{
    [self setBordered:YES];
    [self setNeedsDisplay];
}
- (void) select
{
    [self setBordered:NO];
    [self setNeedsDisplay];
}

@end
