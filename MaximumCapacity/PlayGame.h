//
//  PlayGame.h
//  MaximumCapacity
//
//  Created by denise szecsei on 3/12/16.
//  Copyright © 2016 denise szecsei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface PlayGame : UIViewController <UIAlertViewDelegate> {
    
    IBOutlet UILabel *shipStatus, *resourceStatus, *healthStatus, *moraleStatus;
    IBOutlet UIImageView *shipStatusImage, *resourceStatusImage, *healthStatusImage, *moraleStatusImage;
    
    IBOutlet UITextView *captainsLog;
    IBOutlet UIButton *updateButton, *actionButton, *passengerButton;
    
    int weekCounter, countMedical, countTechnical, countLabor;
    
    int shipResourceLevel, shipMechanicalLevel, populationHealthLevel, populationMoraleLevel, shipFoodProduction, passengerWaste;
    
    BOOL gameOver;
    
    AppDelegate *delegate;
    int lastVirus, lastMechanical;

}

@property (strong, nonatomic) AVAudioPlayer *player;

-(IBAction)statusUpdate:(id)sender;
-(IBAction)takeAction:(id)sender;
-(void)getPassengerDetails;

-(NSString *)createUpdate;
-(NSString *)getMoraleLevel;
-(NSString *)getHealthLevel;
-(NSString *)getResourceLevel;
-(NSString *)getShipStatus;

-(IBAction)monitorShip:(UIStoryboardSegue *)segue;


@end
