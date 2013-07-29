//
//  ViewController.h
//  newView
//
//  Created by RAGHAV  on 28/07/13.
//  Copyright (c) 2013 RAGHAV . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
    
    BOOL togglePatternMenu;
    BOOL toggleStyleMenu;
    BOOL mouseSwiped;
    
    CGPoint lastPoint;
    CGPoint currentPoint;
    CGPoint center;
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    CGFloat radius;
    CGFloat angle;
    NSInteger angleValue,radiusValue;
    
    NSInteger verticesValue;
    
    NSString *patternName;
    
    int startValue;
    int counter;
    
    NSMutableArray *patternMenuValues;
    
    UIImageView *imgView;
    
    IBOutlet UIImageView *tempDrawImage;
    
    __weak IBOutlet UIImageView *mainImage;
    
    __weak IBOutlet UIButton *patternButton;
    
    __weak IBOutlet UIButton *styleButton;
    
    __weak IBOutlet UITableView *patternMenu;
    
    __weak IBOutlet UIView *styleMenu;
    
    __weak IBOutlet UISlider *angleSlider;
    
    __weak IBOutlet UILabel *angleSliderLabel;
    
    __weak IBOutlet UISlider *radiusSlider;
    
    __weak IBOutlet UILabel *radiusSliderLabel;
    
    __weak IBOutlet UISlider *verticesSlider;
    
    __weak IBOutlet UILabel *verticesSliderLabel;
    
    __weak IBOutlet UISwitch *lineWanted;
    
    __weak IBOutlet UISwitch *arcsWanted;
    
    __weak IBOutlet UISwitch *shapesWanted;
}

- (IBAction)showPatternMenu:(id)sender;
- (IBAction)showStyleMenu:(id)sender;
- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)undoPressed:(id)sender;
- (IBAction)pencilPressed:(id)sender;

@end
