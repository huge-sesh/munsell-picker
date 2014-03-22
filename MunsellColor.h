//
//  MunsellColor.h
//  munsell wheel
//
//  Created by jeff on 3/21/14.
//  Copyright (c) 2014 jeff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MunsellColor : NSObject

@property (nonatomic, copy) NSString* hue;
@property (nonatomic, copy) NSNumber* value;
@property (nonatomic, copy) NSNumber* chroma;

+ (MunsellColor*) colorWithHue:(NSString*)hue value:(NSNumber*)value chroma:(NSNumber*)chroma;
- (id)copyWithZone:(NSZone*)zone;
- (NSColor*) nsColor;
- (MunsellColor*) offset:(NSArray*)offset;
@end
