//
//  WheelController.m
//  munsell wheel
//
//  Created by jeff on 3/20/14.
//  Copyright (c) 2014 jeff. All rights reserved.
//

#import "WheelController.h"
#import "MunsellWell.h"
#import "MunsellColor.h"

@interface WheelController ()

@end

@implementation WheelController
@synthesize paletteWells;
@synthesize hueWells;
@synthesize spectrumWells;
@synthesize valueChromaBox;
@synthesize hueBox;
@synthesize spectrumBox;
@synthesize currentWell;
@synthesize currentColorWell;
@synthesize hexValue;
@synthesize munsellValue;
@synthesize clipboardCopyAutomaticallyBox;
@synthesize clipboardCopyButton;


- (void) setCurrentWell:(MunsellWell *)well {
    if (currentWell) [currentWell deselect];
    MunsellColor* color = [[well munsellColor] copy];
    
    [self setAdjacentHues:color];
    [self setPaletteColors:color];
    
    if (! [well isPalette]) {
        well = paletteWells[([[color value] intValue]) -1][([[color chroma] intValue] / 2) -1];
    }
    currentWell = well;
    [well select];
    
    [currentColorWell setMunsellColor:color offset:nil];
    NSColor* nsColor = [color nsColor];
    [munsellValue setStringValue:[NSString stringWithFormat:@"%@ %@/%@", [color hue], [color value], [color chroma]]];
    [hexValue setStringValue:[NSString stringWithFormat:@"#%02X%02X%02X",
                            (int) (nsColor.redComponent * 0xFF), (int) (nsColor.greenComponent * 0xFF),
                            (int) (nsColor.blueComponent * 0xFF)]];
    if ([clipboardCopyAutomaticallyBox state] == NSOnState) {
        [self copyText:self];
    }
}

- (IBAction) copyText:(id)sender
{
    NSPasteboard* pasteBoard = [NSPasteboard generalPasteboard];
    [pasteBoard declareTypes:[NSArray arrayWithObjects:NSStringPboardType, nil] owner:nil];
    [pasteBoard setString:[hexValue stringValue] forType:NSStringPboardType];
}

- (void) setPaletteColors:(MunsellColor*) color
{
    for (int y = 0; y < 9; y++) {
        for (int x = 0; x < 13; x++) {
            MunsellWell* well = paletteWells[y][x];
            [well setMunsellColor:[MunsellColor colorWithHue:[color hue] value:@1 chroma:@2]
                  offset:@[@0, [NSNumber numberWithInt:y], [NSNumber numberWithInt:x]]];
        
        }
    }

}

- (void) setAdjacentHues:(MunsellColor*) color
{
    for (int x = 0; x < 13; x++) {
        [hueWells[x] setMunsellColor:color offset:@[[NSNumber numberWithInt:x - 6], @0, @0]];
    }
    
}

- (void) awakeFromNib
{
    
    if (self) {
        NSMutableArray* wells = [NSMutableArray array];
        
        for (int x = 0; x < 40; x++) {
            MunsellWell* well = [[MunsellWell alloc] initWithFrame:NSRectFromCGRect(CGRectMake((x % 20) * 25 + 16, (x / 20) * 25 + 14, 17, 17))];
            [well setIsSpectrum:YES];
            [well setMunsellColor:[MunsellColor colorWithHue:@"5R" value:@7 chroma:@8] offset:@[[NSNumber numberWithInteger: x >= 20 ? x : 20 - x],@0,@0]];
            [wells addObject:well];
            [spectrumBox addSubview:well];
        }
        spectrumWells = wells;
        
        wells = [NSMutableArray array];
        for (int y = 0; y < 9; y++) {
            NSMutableArray* row = [NSMutableArray array];
            for (int x = 0; x < 13; x++) {
                MunsellWell* well = [[MunsellWell alloc] initWithFrame:
                                     NSRectFromCGRect(CGRectMake(x * 38 + 18, y * 38 + 14, 30, 30))];
                [well setIsPalette:YES];
                [row addObject: well];
                [valueChromaBox addSubview:well];
            }
            [wells addObject:row];
        }
        paletteWells = wells;
        
        wells = [NSMutableArray array];
        for (int x = 0; x < 13; x++) {
            [wells addObject:[[MunsellWell alloc] initWithFrame:NSRectFromCGRect(CGRectMake(x * 38 + 18, 14, 30, 30))]];
            [hueBox addSubview:wells[x]];
        }
        hueWells = wells;
        [hueWells[6] setBordered:NO];
        [self setPaletteColors:[MunsellColor colorWithHue:@"5R" value:@1 chroma:@2]];
        [self setCurrentWell:paletteWells[7][4]];
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {}
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

@end
