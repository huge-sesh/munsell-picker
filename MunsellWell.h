//
//  MunsellWell.h
//  munsell wheel
//
//  Created by jeff on 3/21/14.
//  Copyright (c) 2014 jeff. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class MunsellColor;

@interface MunsellWell : NSColorWell

- (void) setMunsellColor:(MunsellColor*)color offset:(NSArray*)offset;
- (void) select;
- (void) deselect;

@property (nonatomic, copy) MunsellColor* munsellColor;
@property (nonatomic, assign) BOOL isPalette;
@property (nonatomic, assign) BOOL isSpectrum;
@end
