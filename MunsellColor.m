//
//  MunsellColor.m
//  munsell wheel
//
//  Created by jeff on 3/21/14.
//  Copyright (c) 2014 jeff. All rights reserved.
//

#import "MunsellColor.h"

@implementation MunsellColor
@synthesize hue;
@synthesize value;
@synthesize chroma;

static NSArray* hues, *chromas, *values, *spectrum;
static NSDictionary* colors;
+ (void) initialize {
    hues = @[@"5R", @"7.5R", @"10R", @"2.5YR", @"5YR", @"7.5YR", @"10YR", @"2.5Y", @"5Y", @"7.5Y", @"10Y", @"2.5GY", @"5GY", @"7.5GY", @"10GY", @"2.5G", @"5G", @"7.5G", @"10G", @"2.5BG", @"5BG", @"7.5BG", @"10BG", @"2.5B", @"5B", @"7.5B", @"10B", @"2.5PB", @"5PB", @"7.5PB", @"10PB", @"2.5P", @"5P", @"7.5P", @"10P", @"2.5RP", @"5RP", @"7.5RP", @"10RP", @"2.5R"];
    chromas = @[@2, @4, @6, @8, @10, @12, @14, @16, @18, @20, @22, @24, @26];
    values = @[@1, @2, @3, @4, @5, @6, @7, @8, @9];
    NSError* error;
    colors = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"munsell" ofType:@"json"]] options:0 error:&error];
}

+ (MunsellColor*) colorWithHue:(NSString*)hue value:(NSNumber*)value chroma:(NSNumber*)chroma
{
    MunsellColor* color = [[MunsellColor alloc] init];
    [color setHue:hue];
    [color setValue:value];
    [color setChroma:chroma];
    return color;
}
- (MunsellColor*) offset:(NSArray*) offset
{
    if (!offset) return self;
    else {
        MunsellColor* color = [self copy];
        int hue_index = ((int)[hues indexOfObject:hue] + (int)[offset[0] integerValue]) % (int)[hues count];
        if ((hue_index) < 0) hue_index += [hues count];
        [color setHue:hues[hue_index]];
        [color setValue:values[(((int)[values indexOfObject:value]) + [offset[1] integerValue]) % [values count]]];
        [color setChroma:chromas[(((int)[chromas indexOfObject:chroma]) + [offset[2] integerValue]) % [chromas count]]];
        return color;
    }
}

- (id) copyWithZone:(NSZone *)zone
{
    return [MunsellColor colorWithHue:hue value:value chroma:chroma];
}
- (NSColor*) nsColor {
    NSDictionary* _values = [colors objectForKey:hue];
    if (_values) {
        NSDictionary* _chromas = [_values objectForKey:[value stringValue]];
        if (_chromas) {
            NSDictionary* colorDict = [_chromas objectForKey:[chroma stringValue]];
            if (colorDict) return [NSColor colorWithRed:[((NSNumber*)colorDict[@"r"]) floatValue]
                                                  green:[((NSNumber*)colorDict[@"g"]) floatValue]
                                                   blue:[((NSNumber*)colorDict[@"b"]) floatValue]
                                                  alpha:1.0f];
        }
    }
    return nil;
}
@end
