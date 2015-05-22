//
//  ViewController.m
//  BitmapContextFingerpaint
//
//  Created by Aaron Golden on 5/22/15.
//  Copyright (c) 2015 Aaron Golden. All rights reserved.
//

#import "ViewController.h"

#import "PaintView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView {
    self.view = [[PaintView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
}

@end
