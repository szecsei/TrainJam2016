//
//  PassengerSummary.h
//  MaximumCapacity
//
//  Created by denise szecsei on 3/12/16.
//  Copyright © 2016 denise szecsei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface PassengerSummary : UIViewController {
    
    IBOutlet UILabel *summaryLabel;
    IBOutlet UIButton *backButton;
    
    AppDelegate *delegate;
}

-(IBAction)goBack:(id)sender;

@end
