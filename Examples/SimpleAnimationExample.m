/*
 The MIT License
 
 Copyright (c) 2009 Free Time Studios and Nathan Eror
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/

#import "SimpleAnimationExample.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "KACircleProgressView.h"
@implementation SimpleAnimationExample

@synthesize viewToAnimate = viewToAnimate_;
@synthesize performAnimationButton = performAnimationButton_;
@synthesize directionControl = directionControl_;

+ (NSString *)displayName {
  return @"";
}

#pragma mark init and dealloc

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    self.title = [[self class] displayName];
  }
  return self;
}

- (void)dealloc {
  self.viewToAnimate = nil;
  self.performAnimationButton = nil;
  self.directionControl = nil;
  [super dealloc];
}

- (void)setHasDirectionControl:(BOOL)hasDirection {
  if(hasDirection && (self.directionControl.superview == nil)) {
    [self.view insertSubview:self.directionControl belowSubview:self.viewToAnimate];
  } else if(!hasDirection && self.directionControl.superview != nil){
    [self.directionControl removeFromSuperview];
  }
}

- (BOOL)hasDirectionControl {
  return (self.directionControl.superview != nil);
}
#pragma  添加 反射效果
-(void)addOtherLayer{
    
    [[[self view] layer]setBackgroundColor:
     [[UIColor blackColor]CGColor]];
    UIImage *balloon = [UIImage imageNamed:@"ss"];
    // Create the top layer; this is the main image
    CALayer *topLayer = [[CALayer alloc] init];
    [topLayer setBounds:CGRectMake(0.0f, 0.0f, 320.0, 240.0)];
    [topLayer setPosition:CGPointMake(160.0f, 120.0f)];// 中心点
    [topLayer setContents:(id)[balloon CGImage]];
    // Add the layer to the view
    [[[self view] layer]addSublayer:topLayer];
    
    
    
    // Create the reflectionlayer; this image is displayed beneath // the top layer
    CALayer *reflectionLayer =[[CALayer alloc] init];
    [reflectionLayer setBounds:CGRectMake(0.0f, 0.0f,320.0, 240.0)];
    [reflectionLayer setPosition:CGPointMake(158.0f, 362.0f)];
    // Use a copy of the imagecontents from the top layer // for the reflection layer
    [reflectionLayer setContents:[topLayer contents]];
    // Rotate the image 180degrees over the x axis to flip the image
    [reflectionLayer setValue:[NSNumber numberWithFloat:(180.0f/360*M_PI_4)] forKeyPath:@"transform.rotation.x"];
    // Create a gradient layer touse as a mask for the
    // reflection layer
    
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    [gradientLayer setBounds:[reflectionLayer bounds]];
    [gradientLayer setPosition:CGPointMake([reflectionLayer bounds].size.width/2, [reflectionLayer bounds].size.height/2)];
    [gradientLayer setColors:[NSArray arrayWithObjects: (id)[[UIColor clearColor] CGColor],
                              (id)[[UIColor blackColor]CGColor], nil]];
    // Override the default startand end points to give the gradient // the right look
    [gradientLayer setEndPoint:CGPointMake(0.5,0.35)];
    [gradientLayer setStartPoint:CGPointMake(0.5,1.0)];
    // Set the reflection layer’smask to the gradient layer
    [reflectionLayer setMask:gradientLayer];
    
  
    
    // Add the reflection layerto the view
    [[[self view] layer]addSublayer:reflectionLayer];
      CFRelease(gradientLayer);
    CFRelease(reflectionLayer);
}
// mask layer 只显示layer层和mask 重合的部分
-(void)maskLayer{
    UIImage *balloon = [UIImage imageNamed:@"ss"];
    [[[self view] layer] setContents:(id)[balloon CGImage]];
    CGMutablePathRef path =CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 100);
    CGPathAddLineToPoint(path,NULL, 200, 0);
    CGPathAddLineToPoint(path, NULL, 200, 200);
    CGPathAddLineToPoint(path, NULL, 0, 100);
   CAShapeLayer* shapeLayer = [[CAShapeLayer alloc] init];
    [shapeLayer setBounds:CGRectMake(0, 0, 200, 200)];
    [shapeLayer setFillColor:[[UIColor purpleColor]CGColor]];
    [shapeLayer setPosition:CGPointMake(200, 200)];
    [shapeLayer setPath:path];
    [shapeLayer setStrokeColor:[[UIColor redColor] CGColor]];
    [shapeLayer setLineWidth:10.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:50], [NSNumber numberWithInt:2],
      nil]];  
    [[[self view] layer]setMask:shapeLayer];
    CFRelease(shapeLayer);
    CFRelease(path);
}
-(void)executeImageViewMask{
    
    UIImageView* userHead = [[UIImageView alloc]initWithFrame:CGRectMake(100, 135, 80, 80)];
    userHead.image = [UIImage imageNamed:@"ss.png"];
    
    //创建圆形遮罩，把用户头像变成圆形
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(40, 40) radius:40 startAngle:0 endAngle:2*M_PI clockwise:YES];
    CAShapeLayer* shape = [CAShapeLayer layer];
    
    shape.strokeStart=.0;
    shape.strokeEnd=1.0;
    shape.strokeColor=[[UIColor redColor]CGColor];
    shape.lineWidth=2;
    [shape setPosition:CGPointMake(0, 0)];
    shape.lineCap = kCALineCapSquare;
    shape.path = path.CGPath;
    userHead.layer.mask = shape;
   // shape.fillColor=[[UIColor greenColor]CGColor];

    [self.view addSubview:userHead];
    [userHead release];
    
    
}
-(void)executePathLayer{
    UIImage *balloon = [UIImage imageNamed:@"ss"];
    [[[self view] layer] setContents:(id)[balloon CGImage]];
    CGMutablePathRef path =CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 100);
    CGPathAddLineToPoint(path, NULL, 200, 0);
    CGPathAddLineToPoint(path, NULL, 200,200);
    CGPathAddLineToPoint(path, NULL, 0, 100);
  CAShapeLayer*  shapeLayer = [[CAShapeLayer alloc] init];
    [shapeLayer setBounds:CGRectMake(0, 0, 200, 200)];
    [shapeLayer setFillColor:[[UIColor purpleColor] CGColor]];
    [shapeLayer setPosition:CGPointMake(200, 200)];
    [shapeLayer setPath:path];
    [shapeLayer setStrokeColor:[[UIColor redColor] CGColor]];
    [shapeLayer setLineWidth:10.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:50], [NSNumber numberWithInt:2],
      nil]];  
    [[[self view] layer]addSublayer:shapeLayer];
    
    CFRelease(shapeLayer);
    CFRelease(path);
}
#pragma mark Load and unload the view

- (void)loadView {
    
    
    self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
//    
//    KACircleProgressView *progress = [[KACircleProgressView alloc] initWithFrame:CGRectMake(100, 150, 100, 100)];
//    [self.view addSubview:progress];
//    progress.trackColor = [UIColor whiteColor];
//    progress.progressColor = [UIColor orangeColor];
//    progress.progress = .7;
//    progress.progressWidth = 10;

    self.view.backgroundColor=[UIColor whiteColor];
    //[self executePathLayer];
    [self executeImageViewMask];
    //[self executeAnimationLayer];
    //[self maskLayer];
}
-(void)executeAnimationLayer{
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(40, 40) radius:40 startAngle:0 endAngle:2*M_PI clockwise:YES];
    CAShapeLayer* shape = [CAShapeLayer layer];
    
    shape.strokeStart=.0; //绘画的比例，如果是.5 只画一半
    
    shape.strokeColor=[[UIColor blackColor]CGColor];
    shape.lineWidth=2;
    [shape setPosition:CGPointMake(100, 100)];
    shape.lineCap = kCALineCapSquare;
    shape.path = path.CGPath;
  
    shape.fillColor=[[UIColor greenColor]CGColor];
    [self.view.layer addSublayer:shape];
    // 给这个layer添加动画效果
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.f];
    [shape addAnimation:pathAnimation forKey:nil];
    [pathAnimation setValue:shape forKey:@"shape"];
    [pathAnimation setDelegate:self];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
   CAShapeLayer* shape= [anim valueForKey:@"shape"];
    shape.strokeEnd=1.0;
}
-(void)executeAnimation{
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Checkers.png"]];;
    NSLog(@"self.view.frame=%@",NSStringFromCGRect(self.view.frame));
    
    NSLog(@"self.nav.frame=%@",NSStringFromCGRect(self.navigationController.navigationBar.frame));
    
    
    self.viewToAnimate = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ViewBackground.png"]] autorelease];
    self.viewToAnimate.opaque = NO;
    self.viewToAnimate.backgroundColor = [UIColor clearColor];
    self.viewToAnimate.frame = CGRectMake(20., 74., 280., 280.);
    
    self.performAnimationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.performAnimationButton.frame = CGRectMake(10., 480-44., 300., 44.);
    [self.performAnimationButton setTitle:@"Run Animation" forState:UIControlStateNormal];
    [self.performAnimationButton addTarget:self action:@selector(performAnimation:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *directionItems = [NSArray arrayWithObjects:@"T", @"R", @"B", @"L", @"TL", @"TR", @"BL", @"BR", nil];
    self.directionControl = [[[UISegmentedControl alloc] initWithItems:directionItems] autorelease];
    self.directionControl.selectedSegmentIndex = 0;
    self.directionControl.frame = CGRectMake(10., 360., 300., 44.);
    
    [self.view addSubview:self.performAnimationButton];
    [self.view addSubview:self.viewToAnimate];
}
#pragma mark Event Handling

- (void)performAnimation:(id)sender {
  NSAssert(NO, @"performAnimation: must be overridden by subclasses");
}

@end


