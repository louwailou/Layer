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

#import "BackInOut.h"
#import "FTAnimation.h"

@implementation BackInOut

+ (NSString *)displayName {
  return @"Back In/Back Out";
}

- (void)viewDidLoad {
  self.hasDirectionControl = YES;
    
    
}

- (void)performAnimation:(id)sender {
    
//    CATransition *animation = [CATransition animation];
//    animation.delegate = self;
//    animation.duration = 0.5f; //动画时长
//    animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    animation.fillMode = kCAFillModeBoth;
//    animation.type = kCATransitionMoveIn; //过度效果
//    animation.subtype = kCATransitionFromLeft; //过渡方向
//    animation.startProgress = 0.0 ;//动画开始起点(在整体动画的百分比)
//    animation.endProgress = 1.0;  //动画停止终点(在整体动画的百分比)
//    //animation.removedOnCompletion = NO;
//    [self.view.layer addAnimation:animation forKey:@"animation"];
//    

    
  if(self.viewToAnimate.hidden) {
	  [self.viewToAnimate backInFrom:self.directionControl.selectedSegmentIndex inView:self.viewToAnimate.superview withFade:NO duration:0.4 delegate:nil startSelector:nil stopSelector:nil];
  } else {
	  [self.viewToAnimate backOutTo:self.directionControl.selectedSegmentIndex inView:self.viewToAnimate.superview withFade:NO duration:0.4 delegate:nil startSelector:nil stopSelector:nil];

  }
   NSLog(@"viewToAnimate=%@",NSStringFromCGRect(self.viewToAnimate.frame));
}


@end
