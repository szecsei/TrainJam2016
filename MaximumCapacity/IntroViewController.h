//
//  IntroViewController.h
//  MaximumCapacity
//
//  Created by denise szecsei on 3/12/16.
//  Copyright © 2016 denise szecsei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface IntroViewController : UIViewController {
    
    IBOutlet UILabel *instructionsLabel;
    AppDelegate *delegate;
    
    
    
}

-(IBAction)gameOver:(UIStoryboardSegue *)segue;

@end
