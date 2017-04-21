//
//  LYSSignatureView.m
//  LYSSignatureView
//
//  Created by jk on 2017/4/21.
//  Copyright © 2017年 Goldcard. All rights reserved.
//

#import "LYSSignatureView.h"

#define INITIAL_COLOR [UIColor redColor]; // Initial color for line  drawing.
#define FINAL_COLOR [UIColor redColor];// End color after completd drawing

#define INITIAL_LABEL_TEXT @"Sign Here";

@interface LYSSignatureView (){
    UIImage *incrImage;
    CGPoint points[5];
    uint control;
}

@property(nonatomic,strong)UIBezierPath *beizerPath;

@property(nonatomic,strong)UILabel *placeHolderView;

@end

@implementation LYSSignatureView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    return self;
}

-(UILabel*)placeHolderView{
    if (!_placeHolderView) {
        _placeHolderView = [UILabel new];
        _placeHolderView.font = [UIFont fontWithName:@"HelveticaNeue" size:51];
        _placeHolderView.text = self.placeHolder;
        _placeHolderView.textColor = [UIColor lightGrayColor];
        _placeHolderView.textAlignment = NSTextAlignmentCenter;
        _placeHolderView.alpha = 0.3;
    }
    return _placeHolderView;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.placeHolderView.frame = CGRectMake(0, (self.frame.size.height - self.placeholderVH) * 0.5, self.frame.size.width, self.placeholderVH);
}

-(UIBezierPath*)beizerPath{
    if (!_beizerPath) {
        _beizerPath = [UIBezierPath bezierPath];
        _beizerPath.lineWidth = self.lineW;

    }
    return  _beizerPath;
}

#pragma mark - 初始化
-(void)initConfig{
    self.backgroundColor = [UIColor whiteColor];
    [self setMultipleTouchEnabled:NO];
    [self setDefaults];
    [self addSubview:self.placeHolderView];
}


#pragma mark - 设置默认参数
-(void)setDefaults{
    _placeHolder = @"在这里签名";
    _placeholderVH = 60.f;
    _lineW = 3.f;
    _lineBorderColor = _lineColor = [UIColor redColor];
    
}

- (void)drawRect:(CGRect)rect{
    
    [incrImage drawInRect:rect];
    
    [self.beizerPath stroke];
    
    UIColor *fillColor = self.lineColor;
    [fillColor setFill];
    
    UIColor *strokeColor = self.lineBorderColor;
    
    [strokeColor setStroke];
    
    [self.beizerPath stroke];
}

#pragma mark - UIView Touch Methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if ([self.placeHolderView superview]){
        [self.placeHolderView removeFromSuperview];
    }
    control = 0;
    UITouch *touch = [touches anyObject];
    points[0] = [touch locationInView:self];
    CGPoint startPoint = points[0];
    CGPoint endPoint = CGPointMake(startPoint.x + 1.5, startPoint.y + 2);
    [self.beizerPath moveToPoint:startPoint];
    [self.beizerPath addLineToPoint:endPoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    control++;
    points[control] = touchPoint;
    if (control == 4){
        points[3] = CGPointMake((points[2].x + points[4].x)/2.0, (points[2].y + points[4].y)/2.0);
        [self.beizerPath moveToPoint:points[0]];
        [self.beizerPath addCurveToPoint:points[3] controlPoint1:points[1] controlPoint2:points[2]];
        [self setNeedsDisplay];
        points[0] = points[3];
        points[1] = points[4];
        control = 1;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self drawBitmapImage];
    [self setNeedsDisplay];
    [self.beizerPath removeAllPoints];
    control = 0;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touchesEnded:touches withEvent:event];
}

#pragma mark - Bitmap Image Creation
- (void)drawBitmapImage{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);
    if (!incrImage){
        UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:self.bounds];
        [self.backgroundColor setFill];
        [rectpath fill];
    }
    [incrImage drawAtPoint:CGPointZero];
    UIColor *strokeColor = self.lineBorderColor;
    [strokeColor setStroke];
    [self.beizerPath stroke];
    incrImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

#pragma mark - 清除
- (void)clear{
    incrImage = nil;
    if (![self.placeHolderView superview]) {
        [self addSubview:self.placeHolderView];
    }
    [self setNeedsDisplay];
}

#pragma mark - 获取照片
- (UIImage *)getImage {
    if([self.placeHolderView superview]){
        return nil;
    }
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *signatureImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return signatureImage;
}

@end
