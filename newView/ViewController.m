//
//  ViewController.m
//  newView
//
//  Created by RAGHAV  on 28/07/13.
//  Copyright (c) 2013 RAGHAV . All rights reserved.
//

#import "ViewController.h"
#import "Pattern.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    toggleStyleMenu = YES;
    togglePatternMenu = YES;
    
    [self toggleAll];
    [self initializePatternMenuValues];
    
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 0.3;
    opacity = 1.0;
    angleValue=1;
    radiusValue=0;
    //verticesValue=3;
    center = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/2);
    startValue=100;
    counter=0;
    
    patternName=@"Circle";
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [patternMenuValues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }

    cell.textLabel.text = [patternMenuValues objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:17.0f];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    patternName=[patternMenuValues objectAtIndex:indexPath.row];
    [self toggleAll];
}


-(void)initializePatternMenuValues{
    
    patternMenuValues = [[NSMutableArray alloc]initWithObjects:@"Circle",@"iCircle",@"Ellipse",@"iEllipse",@"Tube",@"Circlipse",@"Atoms", nil];
    
}



//////////////////////////////////////////////////////////////////////
- (IBAction)undoPressed:(UIGestureRecognizer *)sender {
    
    [[self.view viewWithTag:startValue+counter-1] removeFromSuperview];
    if(counter!=0){
        counter--;
    }
}

- (IBAction)pencilPressed:(id)sender {
    
    [self toggleAll];
    UIButton * PressedButton = (UIButton*)sender;
    
    switch(PressedButton.tag)
    {
        case 10:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 1:
            red = 105.0/255.0;
            green = 105.0/255.0;
            blue = 105.0/255.0;
            break;
        case 2:
            red = 255.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 3:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 255.0/255.0;
            break;
        case 4:
            red = 102.0/255.0;
            green = 204.0/255.0;
            blue = 0.0/255.0;
            break;
        case 5:
            red = 102.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
        case 6:
            red = 51.0/255.0;
            green = 204.0/255.0;
            blue = 255.0/255.0;
            break;
        case 7:
            red = 160.0/255.0;
            green = 82.0/255.0;
            blue = 45.0/255.0;
            break;
        case 8:
            red = 255.0/255.0;
            green = 102.0/255.0;
            blue = 0.0/255.0;
            break;
        case 9:
            red = 255.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
    }

}

-(CGPoint)nextPoint:(id)sender{
    CGPoint nP;
    NSString *pattern_type=(NSString*)sender;
    
    if([pattern_type isEqual:@"Circle"]){
        nP.x=center.x+(sin(angle))*radius;
        nP.y= center.y-(cos(angle))*radius;
        //radiusValue=0;
    }
    else if ([pattern_type isEqual:@"Ellipse"]){
        nP.x=center.x+(sin(angle++))*radius;
        nP.y= center.y-(cos(angle))*radius;
        radiusValue=0;
    }
    else if ([pattern_type isEqual:@"iEllipse"]){
        nP.x=center.x+(sin(angle--))*radius;
        nP.y= center.y-(cos(angle))*radius;
    }
    else if ([pattern_type isEqual:@"Tube"]){
        nP.x=center.x+(sin(angle))*radius;
        nP.y= center.y-(tan(angle))*radius;
        radiusValue=0;
    }
    else if ([pattern_type isEqual:@"iCircle"]){
        nP.x=center.x+(1/sin(angle))*radius;
        nP.y= center.y-(1/cos(angle))*radius;
        radiusValue=0;
    }
    
    return nP;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self toggleAll];
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
    
    
    
    lastPoint.x=lastPoint.x-center.x;
    lastPoint.y=lastPoint.y-center.y;
    radius = sqrt(pow(lastPoint.x,2)+pow(lastPoint.y, 2));
    angle = atan(((lastPoint.y)/(lastPoint.x)));
    
    
    //lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSUInteger figure_radius=10;

    mouseSwiped = YES;
    
    lastPoint=[self nextPoint:patternName];
    angle=angle+angleValue;
    radius=radius-radiusValue;
    
    //UITouch *touch = [touches anyObject];
    //CGPoint currentPoint;
    //currentPoint = [touch locationInView:self.view];
    currentPoint=[self nextPoint:patternName];
    
    //[self changePattern:nil];
    
    
    NSLog(@"currentpoint.x is equal to: %f",currentPoint.x);
    NSLog(@"currentpoint.y is equal to: %f",currentPoint.y);
    
    //UITouch *touch = [touches anyObject];
    // CGPoint currentPoint;
    //currentPoint = [touch locationInView:self.view];
    
    
    
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    if(shapesWanted.isOn){
            
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x,lastPoint.y-figure_radius);
    
        CGFloat arc = M_PI * 2.0/ verticesValue;
    
        for (NSUInteger i = 1; i < verticesValue; i++) {
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),lastPoint.x + figure_radius * sin(arc * i),lastPoint.y - figure_radius * cos(arc * i));
        }
    
        CGContextClosePath(UIGraphicsGetCurrentContext());
        [[UIColor colorWithRed:red green:green blue:blue alpha:0.1] setFill];
    
        CGContextFillPath(UIGraphicsGetCurrentContext());
    }
    
    if(lineWanted.isOn){
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x,lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    }
    
    if(arcsWanted.isOn){
        CGContextAddArcToPoint(UIGraphicsGetCurrentContext(), lastPoint.x,lastPoint.y, currentPoint.x, currentPoint.y,radius);
    }
    //CGContextAddCurveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x,lastPoint.y,(lastPoint.x+currentPoint.x)/2,(lastPoint.y+currentPoint.y)/2, currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [tempDrawImage setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    //lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    

    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imgView.tag=startValue+counter;
    UIGraphicsBeginImageContext(imgView.frame.size);
    [imgView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    imgView.image = UIGraphicsGetImageFromCurrentImageContext();
    //mainImage.image=UIGraphicsGetImageFromCurrentImageContext();
    [self.view insertSubview:imgView aboveSubview:mainImage];
    tempDrawImage.image = nil;
    
    UIGraphicsEndImageContext();
    counter++;
}

//////////////////////////////////////////////////////////////



-(void)toggleAll{
    
    if(!toggleStyleMenu){
        [self showStyleMenu:nil];
    }
    if(!togglePatternMenu){
        [self showPatternMenu:nil];
    }

}

-(void)toggleMenus:(BOOL)toggleValue viewName:(UIView*)viewName{
    
    int width=viewName.frame.size.width;
    if(!toggleValue){
        width =-width;
    }
    [UIView animateWithDuration:0.3 animations:^() {

        [viewName setFrame:CGRectMake(viewName.frame.origin.x+width, viewName.frame.origin.y, viewName.frame.size.width, viewName.frame.size.height)];

    }];
    //toggleValue=!toggleValue;
    
}

- (IBAction)showPatternMenu:(id)sender {
    
    if(!toggleStyleMenu){
        [self showStyleMenu:nil];
    }
    [self toggleMenus:togglePatternMenu viewName:patternMenu];
    togglePatternMenu=!togglePatternMenu;

}

- (IBAction)showStyleMenu:(id)sender {
    
    if(!togglePatternMenu){
        [self showPatternMenu:nil];
    }
    [self toggleMenus:toggleStyleMenu viewName:styleMenu];
    toggleStyleMenu=!toggleStyleMenu;

}

- (IBAction)sliderValueChanged:(id)sender {
    
    UISlider * changedSlider = (UISlider*)sender;
    
    if(changedSlider == angleSlider) {
        
        angleValue = angleSlider.value;
        angleSliderLabel.text = [NSString stringWithFormat:@"%.1d", angleValue];
        
    }
    else if(changedSlider == radiusSlider) {
        
        radiusValue = radiusSlider.value;
        radiusSliderLabel.text = [NSString stringWithFormat:@"%.1d", radiusValue];
        
    }
    else if(changedSlider == verticesSlider) {
        
        verticesValue = verticesSlider.value;
        verticesSliderLabel.text = [NSString stringWithFormat:@"%.1d",verticesValue];
        
    }
    
    
}
@end
