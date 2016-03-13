//
//  IntroViewController.m
//  MaximumCapacity
//
//  Created by denise szecsei on 3/12/16.
//  Copyright © 2016 denise szecsei. All rights reserved.
//

#import "IntroViewController.h"



@implementation IntroViewController



- (void)viewDidLoad {
    
    NSString *instructions = [NSString stringWithFormat:@"Your planet is doomed.  You have been put in charge of a ship which can carry 50 passengers in addition to your crew.  There are many people in your area wanting to get on board.\n\nIn order to expedite the process of choosing people, passengers will be presented in groups of 10.  You will be given summary information about each group, and you can ask each group three psychological questions: one related to survival, one related to morality, and one related to resources.\n\nOnce you have chosen your passengers, you will be able to launch the ship and travel to your destination.  It will take 15 weeks to reach your new home.\n\nYou will be able to monitor the health and overall morale of the passengers, the condition of the ship, and the resources available.  Laborers will be able to produce additional resources, technical people will be able to repair the ship, and medical professionals will be able to maintain the health of the passengers."];
    
    instructionsLabel.numberOfLines = 0;
    instructionsLabel.text = instructions;
    
 
    delegate = [[UIApplication sharedApplication] delegate];
}


-(IBAction)gameOver:(UIStoryboardSegue *)segue
{
    [delegate.passengerList removeAllObjects];
    
}


@end
