//
//  WheelController.h
//  munsell wheel
//
//  Created by jeff on 3/20/14.
//  Copyright (c) 2014 jeff. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class MunsellWell;

@interface WheelController : NSWindowController <NSApplicationDelegate> {
}


@property (nonatomic, strong) NSArray* hueWells;
@property (nonatomic, strong) NSArray* paletteWells;
@property (nonatomic, strong) NSArray* spectrumWells;
@property (nonatomic, strong) IBOutlet NSBox* hueBox;
@property (nonatomic, strong) IBOutlet NSBox* valueChromaBox;
@property (nonatomic, strong) IBOutlet NSBox* spectrumBox;
@property (nonatomic, strong) IBOutlet MunsellWell* currentColorWell;
@property (weak) IBOutlet NSTextField *munsellValue;
@property (weak) IBOutlet NSTextField *hexValue;
@property (weak) IBOutlet NSButton *clipboardCopyButton;
@property (weak) IBOutlet NSButton *clipboardCopyAutomaticallyBox;

@property (nonatomic, strong) NSString* currentHue;
@property (nonatomic, strong) MunsellWell* currentWell;
@end
