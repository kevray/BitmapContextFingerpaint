//
//  PaintView.m
//  
//
//  Created by Aaron Golden on 5/22/15.
//
//

#import "PaintView.h"

@implementation PaintView {
    CGPoint _prevPoition;
    CGMutablePathRef _path;
    CGContextRef _bitmapContext;
    CGFloat _alpha;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        const size_t width = CGRectGetWidth(frame);
        const size_t height = CGRectGetHeight(frame);
        CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
        _bitmapContext = CGBitmapContextCreate(NULL, width, height, 8, 4 * width, rgbColorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
        CGColorSpaceRelease(rgbColorSpace);
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, self.bounds);

    CGImageRef image = CGBitmapContextCreateImage(_bitmapContext);
    CGContextDrawImage(context, self.bounds, image);
    CGImageRelease(image);
    _alpha *= 0.99;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    const CGPoint point = [[touches anyObject] locationInView:self];
    CGPathRelease(_path);
    _path = CGPathCreateMutable();
    CGPathMoveToPoint(_path, NULL, point.x, point.y);
    _alpha = .1;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    const CGPoint point = [[touches anyObject] locationInView:self];
    CGPathAddLineToPoint(_path, NULL, point.x, point.y);

    CGContextSaveGState(_bitmapContext);
    CGContextSetAlpha(_bitmapContext, _alpha);
    CGContextSetLineWidth(_bitmapContext, 60);
    CGContextSetLineCap(_bitmapContext, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(_bitmapContext, [UIColor colorWithRed:254/255.0 green:228/255.0 blue:214/255.0 alpha:1].CGColor);
    CGContextAddPath(_bitmapContext, _path);
    CGContextDrawPath(_bitmapContext, kCGPathStroke);
    CGContextRestoreGState(_bitmapContext);

    [self setNeedsDisplay];
}

@end
