//
//  ChooseCrew.h
//  MaximumCapacity
//
//  Created by denise szecsei on 3/11/16.
//  Copyright © 2016 denise szecsei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"
#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface ChooseCrew : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
    
    IBOutlet UIButton *newGroup, *acceptGroup, *rejectGroup, *totalStats, *launchShip;
    IBOutlet UILabel *informationLabel;
    IBOutlet UITextField *questionList;
    
    NSArray *survivalQuestions, *survivalAnswers, *moralQuestions, *moralAnswers, *resourceQuestions, *resourceAnswers;
    
    Group *focusGroup;
    
    AppDelegate *delegate;
    int groupNumber;
    
    UIPickerView *myChoicePicker;
    
    NSMutableArray *threeQuestions, *correspondingAnswers, *questionCategories;
    int questionNumber;
    
}

@property (nonatomic, strong) Group *focusGroup;
@property (strong, nonatomic) AVAudioPlayer *player;

-(IBAction)askQuestion:(id)sender;
-(IBAction)makeChoice:(id)sender;
-(IBAction)getGroupStats:(id)sender;
-(void)makeNewGroup;





@end

