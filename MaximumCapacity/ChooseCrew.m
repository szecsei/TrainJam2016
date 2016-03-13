//
//  ChooseCrew.m
//  MaximumCapacity
//
//  Created by denise szecsei on 3/11/16.
//  Copyright © 2016 denise szecsei. All rights reserved.
//

#import "ChooseCrew.h"

@interface ChooseCrew ()

@end


@implementation ChooseCrew

@synthesize focusGroup;
@synthesize player = _player;

- (void)viewDidLoad {
    
    informationLabel.numberOfLines = 0;
    
    delegate = [[UIApplication sharedApplication] delegate];
    groupNumber = 0;
    
    threeQuestions = [[NSMutableArray alloc] init];
    correspondingAnswers = [[NSMutableArray alloc] init];
    
    survivalQuestions = [[NSArray alloc] initWithObjects:@"How would you treat someone with different routines and customs?", @"How do you resolve disputes?", @"Which are you loyal to: the crew or the ship?", @"Is there any limit to what you would do in order to survive?", @"Which is more important: survival of the group or reaching our destination?", nil];
    
    NSMutableArray *q1Answers = [[NSMutableArray alloc] init];
    [q1Answers addObject:@"Diversity gives us strength"];
    [q1Answers addObject:@"Dividing the ship into separate sections would allow everyone to retain their cultural identity while allowing us to come together as a community as needed"];
    [q1Answers addObject:@"Sharing similar values forms a cohesive unit.  Different customs lead to chaos.  Uniformity is required for our success."];
    
    NSMutableArray *q2Answers = [[NSMutableArray alloc] init];
    [q2Answers addObject:@"We usually report issues to the authorities and follow due process"];
    [q2Answers addObject:@"If we can resolve it ourselves, we will. If not, we will turn the matter over to the authorities."];
    [q2Answers addObject:@"We tend to band together to defend any member of the group. Strength through unity."];
    
    NSMutableArray *q3Answers = [[NSMutableArray alloc] init];
    [q3Answers addObject:@"Our loyalty would be to the crew."];
    [q3Answers addObject:@"Our loyalty would be to the ship."];
    
    NSMutableArray *q4Answers = [[NSMutableArray alloc] init];
    [q4Answers addObject:@"No.  We will avoid death at all costs."];
    [q4Answers addObject:@"It depends on the situation."];
    [q4Answers addObject:@"No, we are willing to sacrifice for the greater good.  The good of the many outweigh the good of the few.  Or the one."];
    
    NSMutableArray *q5Answers = [[NSMutableArray alloc] init];
    [q5Answers addObject:@"Survival of the group is our primary concern."];
    [q5Answers addObject:@"Reaching the destination is our primary concern."];
    
    survivalAnswers = [[NSArray alloc] initWithObjects:q1Answers, q2Answers, q3Answers,q4Answers,q5Answers, nil];
    
    moralQuestions = [[NSArray alloc] initWithObjects:@"A virus is spreading through the ship.  Should we leave those infected behind or try to treat them?", @"You feel that the captain and crew are making an error in judgement.  What would you do?", @"Is it better to kill or be killed?", @"Are some professions more essential than others?", @"What would you do if you saw someone being punished for wasting resources?", nil];
    
    NSMutableArray *q6Answers = [[NSMutableArray alloc] init];
    [q6Answers addObject:@"We must quarantine infected individuals and prevent the infection from spreading throughout the ship"];
    [q6Answers addObject:@"We must leave the infected people behind. We can’t afford to waste our limited resources on people who are sick."];
    [q6Answers addObject:@"The humane solution is to treat them. Once they are healthy, anyone infected should be allowed to rejoin the group."];
    
    NSMutableArray *q7Answers = [[NSMutableArray alloc] init];
    [q7Answers addObject:@"We follow orders: the captain is always in charge."];
    [q7Answers addObject:@"We would discuss the issue with the captain and come to an acceptable resolution."];
    [q7Answers addObject:@"If the crew are compromised, it is our duty to replace them."];
    
    NSMutableArray *q8Answers = [[NSMutableArray alloc] init];
    [q8Answers addObject:@"Killing is wrong.  We would rather sacrifice ourselves than hurt anyone."];
    [q8Answers addObject:@"We would respond in kind."];
    [q8Answers addObject:@"We will definitely kill to save ourselves and we have the right to do so."];
    
    NSMutableArray *q9Answers = [[NSMutableArray alloc] init];
    [q9Answers addObject:@"Yes, some professions are more useful."];
    [q9Answers addObject:@"No, all professions have equal merit."];
    
    NSMutableArray *q10Answers = [[NSMutableArray alloc] init];
    [q10Answers addObject:@"We would intervene and let the authorities handle the problem."];
    [q10Answers addObject:@"We would walk away.  It does not concern us."];
    [q10Answers addObject:@"We would join in and punish the offender.  Wasting resources threatens the survival of the entire group.  There is no place for waste."];
    
    moralAnswers = [[NSArray alloc] initWithObjects:q6Answers, q7Answers, q8Answers,q9Answers, q10Answers, nil];
    
    
    resourceQuestions = [[NSArray alloc] initWithObjects:@"There aren’t enough resources to feed all the people. Who should get fewer rations?", @"What does your group have to offer? ", @"How well does your group produce food?", @"What do you think is our most important resource?", @"Are you spenders or savers?", nil];
    
    NSMutableArray *q11Answers = [[NSMutableArray alloc] init];
    [q11Answers addObject:@"The children.  Unfortunately, children are unable to work and we need a productive crew"];
    [q11Answers addObject:@"The crew. Our children are our future"];
    
    NSMutableArray *q12Answers = [[NSMutableArray alloc] init];
    [q12Answers addObject:@"We have an excellent work ethic, we are skilled and we are strong."];
    [q12Answers addObject:@"We have technical expertise that may surprise you."];
    [q12Answers addObject:@"We are smart, healthy, and resourceful."];
    
    NSMutableArray *q13Answers = [[NSMutableArray alloc] init];
    [q13Answers addObject:@"We have excellent survival skills, including farming."];
    [q13Answers addObject:@"Well, they are not very impressive but we have many other attributes that you may appreciate."];
    
    NSMutableArray *q14Answers = [[NSMutableArray alloc] init];
    [q14Answers addObject:@"Our intellect and desire to survive are our most important resources"];
    [q14Answers addObject:@"Food and water are our most important resources"];
    [q14Answers addObject:@"Our military strength is our most important resource"];
    
    NSMutableArray *q15Answers = [[NSMutableArray alloc] init];
    [q15Answers addObject:@"We believe in saving resources"];
    [q15Answers addObject:@"We tend to spend our resources, but believe in recycling"];
    
    resourceAnswers = [[NSArray alloc] initWithObjects:q11Answers, q12Answers, q13Answers,q14Answers,q15Answers, nil];
    
    questionCategories = [[NSMutableArray alloc] init];
    [questionCategories addObject:@"Survival"];
    [questionCategories addObject:@"Morality"];
    [questionCategories addObject:@"Resources"];
    
    
    myChoicePicker = [[UIPickerView alloc] init];
    myChoicePicker.delegate = self;
    myChoicePicker.dataSource = self;
    
    
    //create the buttons
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Ask Question" style:UIBarButtonItemStylePlain target:self action:@selector(askQuestion:)];
    
    [toolBar setItems:[[NSArray alloc] initWithObjects:barButtonDone,nil]];
    
    questionList.inputView = myChoicePicker;
    questionList.inputAccessoryView = toolBar;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapResponse)];
    [self.view addGestureRecognizer:tapGesture];
    
    [launchShip setHidden:YES];
    [launchShip setEnabled:NO];
    [acceptGroup setHidden:NO];
    [acceptGroup setEnabled:YES];
    [rejectGroup setHidden:NO];
    [rejectGroup setEnabled:YES];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)yourButtonDidTap {
    NSString *soundFilePath = [NSString stringWithFormat:@"%@/%@.mp3", [[NSBundle mainBundle] resourcePath], @"MusicSelectionScreenTest3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                     error:nil];
    _player.numberOfLoops = 0;
    
    [_player play];
}

-(void)tapResponse {
    
    [questionList resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    
    //make sure buttons are set up properly
    [launchShip setHidden:YES];
    [launchShip setEnabled:NO];
    [acceptGroup setHidden:NO];
    [acceptGroup setEnabled:YES];
    [rejectGroup setHidden:NO];
    [rejectGroup setEnabled:YES];
    
    [self yourButtonDidTap];
    
    [self makeNewGroup];
}


-(void)makeNewGroup {
    
    //need a fade-out of the label
    informationLabel.text = @"";
    
    //create the three questions:
    NSMutableArray *newGroupQAndA = [self getNewQuestionsAndAnswers];
    
    threeQuestions = [newGroupQAndA objectAtIndex:0];
    correspondingAnswers = [newGroupQAndA objectAtIndex:1];
    
    //make a new group
    self.focusGroup = [[Group alloc] init];
    [self getGroupStats:@"NewGroup"];
}

-(NSMutableArray *)getNewQuestionsAndAnswers {
    
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *qArray = [[NSMutableArray alloc] init];
    int value1 = (int) (arc4random() % (int)[survivalQuestions count]);
    int value2 = (int) (arc4random() % (int)[moralQuestions count]);
    int value3 = (int) (arc4random() % (int)[resourceQuestions count]);
    
    [qArray addObject:[survivalQuestions objectAtIndex:value1]];
    [qArray addObject:[moralQuestions objectAtIndex:value2]];
    [qArray addObject:[resourceQuestions objectAtIndex:value3]];
    
    NSMutableArray *aArray = [[NSMutableArray alloc] init];
    NSMutableArray *tempAnswers1 = [survivalAnswers objectAtIndex:value1];
    NSMutableArray *tempAnswers2 = [moralAnswers objectAtIndex:value2];
    NSMutableArray *tempAnswers3 = [resourceAnswers objectAtIndex:value3];
    
    int value4 = (int) (arc4random() % (int)[tempAnswers1 count]);
    int value5 = (int) (arc4random() % (int)[tempAnswers2 count]);
    int value6 = (int) (arc4random() % (int)[tempAnswers3 count]);
    
    [aArray addObject:[tempAnswers1 objectAtIndex:value4]];
    [aArray addObject:[tempAnswers2 objectAtIndex:value5]];
    [aArray addObject:[tempAnswers3 objectAtIndex:value6]];
    
    [newArray addObject:qArray];
    [newArray addObject:aArray];
    
    return newArray;
}

-(IBAction)getGroupStats:(id)sender {
    
    NSMutableArray *myGroup = focusGroup.group;
    
    int child = 0;
    int education = 0;
    int labor = 0;
    int agriculture = 0;
    int medical = 0;
    int technical = 0;
    int management = 0;
    
    //age statistics
    int totalAge = 0;
    int maxAge = 0;
    int minAge = 100;
    
    //tolerance and aggression
    int toleranceTotal = 0;
    int aggressionTotal = 0;
    NSString *disposition = @"Neutral Disposition";
    
    //intelligence, engineering and tech
    int intelligenceTotal = 0;
    int engineeringTotal = 0;
    int techTotal = 0;
    NSString *intelligenceLevel = @"Average Intelligence";
    
    //physical characteristics
    int strengthTotal = 0;
    int adaptabilityTotal = 0;
    int tradeTotal = 0;
    NSString *physicalLevel = @"Average Physical Attributes";
    
    int healthTotal = 0;
    NSString *healthLevel = @"Average Health Level";
    int reproduction = 0;
    int giveBirth = 0;
    
    for (Person *aPerson in myGroup) {
        
        if ([aPerson.profession isEqualToString:@"Labor"]) {
            labor++;
        } else if ([aPerson.profession isEqualToString:@"Medical"]) {
            
            medical++;
        } else if ([aPerson.profession isEqualToString:@"Education"]) {
            
            education++;
        } else if ([aPerson.profession isEqualToString:@"Child"]) {
            
            child++;
        } else if ([aPerson.profession isEqualToString:@"Agriculture"]) {
            
            agriculture++;
        } else if ([aPerson.profession isEqualToString:@"Technical"]) {
            
            technical++;
        } else if ([aPerson.profession isEqualToString:@"Management"]) {
            
            management++;
        }
        
        //get age summary statistics
        totalAge = totalAge + aPerson.age;
        if (aPerson.age > maxAge) {
            
            maxAge = aPerson.age;
        }
        if (aPerson.age < minAge) {
            
            minAge = aPerson.age;
        }
        
        //tolerance and aggression
        toleranceTotal = toleranceTotal + aPerson.tolerance;
        aggressionTotal = aggressionTotal + aPerson.aggression;
        
        //intelligence, engineering and tech
        intelligenceTotal = intelligenceTotal + aPerson.intelligence;
        engineeringTotal = engineeringTotal + aPerson.engineering;
        techTotal = techTotal + aPerson.tech;
        
        //physical characteristics
        strengthTotal = strengthTotal + aPerson.strength;
        adaptabilityTotal = adaptabilityTotal + aPerson.adaptability;
        tradeTotal = tradeTotal + aPerson.trade;
        
        //reproduction and health
        healthTotal = healthTotal + aPerson.healthVisible;
        if (aPerson.canReproduce) {
            
            reproduction = reproduction + 1;
            
            if (aPerson.hasUterus) {
                
                giveBirth = giveBirth + 1;
            }
        }
    }
    
    //build the summary string
    //first, include the professions
    NSString *summaryString = [NSString stringWithFormat:@"Professional Composition:\nMedical: %d, Technical: %d, Agriculture: %d, Education: %d, Management: %d, Labor: %d, Child: %d\n\n", medical, technical, agriculture, education, management, labor, child];
    
    float averageAge = totalAge / 10.0;
    
    
    summaryString = [NSString stringWithFormat:@"%@Average Age: %.0f, youngest: %d, oldest: %d\n\n", summaryString, averageAge, minAge, maxAge];
    
    //determine disposition
    if (toleranceTotal > 600) {
        if (aggressionTotal < 400) {
            
            disposition = @"Positive Disposition";
        }
    } else if (aggressionTotal > 600) {
        
        if (toleranceTotal < 400) {
            
            disposition = @"Negative Disposition";
        }
    }
    
    //determine physical level
    if (strengthTotal + adaptabilityTotal + tradeTotal > 1500) {
        
        physicalLevel = @"Above Average Physical Attributes";
        
    } else if (strengthTotal + adaptabilityTotal + tradeTotal < 900) {
        
        physicalLevel = @"Below Average Physical Attributes";
    }
    
    //determine intelligence level
    if (technical + medical > 4) {
        
        intelligenceLevel = @"Above Average Intelligence";
        
    } else if (intelligenceTotal + engineeringTotal + techTotal > 1700) {
        
        intelligenceLevel = @"Above Average Intelligence";
        
    } else if (intelligenceTotal + engineeringTotal + techTotal < 900) {
        
        intelligenceLevel = @"Below Average Intelligence";
    }
    
    //determine health level
    if (healthTotal > 500) {
        healthLevel = @"Above Average Health Level";
    } else if (healthTotal < 250) {
        
        healthLevel = @"Below Average Health Level";
    }
    
    summaryString = [NSString stringWithFormat:@"%@%@\n%@\n%@\n%@\n", summaryString, disposition, intelligenceLevel, physicalLevel, healthLevel];
    
    summaryString = [NSString stringWithFormat:@"%@%d people can reproduce\n%d people can give birth", summaryString, reproduction, giveBirth];
    
    informationLabel.text = summaryString;
}

-(IBAction)askQuestion:(id)sender {
    
    //get the question and the answer
    
    //get the answer to the question
    informationLabel.text = [NSString stringWithFormat:@"%@\n\n%@", [threeQuestions objectAtIndex:questionNumber], [correspondingAnswers objectAtIndex:questionNumber]];
    
    //TODO: generate a series of questions and answers based on characteristics of the group as grouped in the summary?
    //topic 1: mechanical: ability to repair a ship
    //topic 2: medical: ability to treat medical conditions
    //topic 3: compatibility: ability to get along and work together
    
}

//PickerViewController.m
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

//PickerViewController.m
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 3;
}
//PickerViewController.m
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [questionCategories objectAtIndex:row];
}

//PickerViewController.m
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    //get the choice
    questionNumber = (int)row;
}


-(IBAction)makeChoice:(id)sender {
    
    //TODO: if accept, give each person in the group a name and add them to the passenger list
    if ([sender isEqual:acceptGroup]) {
        
        [questionList resignFirstResponder];
        
        //TODO: add people in focusGroup to passenger list
        NSLog(@"Accept");
        for (Person *aPerson in focusGroup.group) {
            
            aPerson.name = [delegate createName:groupNumber];
            [delegate.passengerList addObject:aPerson];
        }
        groupNumber = groupNumber + 1;
        
        if ([delegate.passengerList count] < 50) {
            [self makeNewGroup];
        } else {
            
            //print an alert indicating that the ship is full
            [acceptGroup setEnabled:NO];
            [rejectGroup setEnabled:NO];
            [launchShip setHidden:NO];
            [launchShip setEnabled:YES];
            [acceptGroup setHidden:YES];
            [rejectGroup setHidden:YES];
        }
        
        
    } else if ([sender isEqual:rejectGroup]) {
        
        NSLog(@"Reject");
        groupNumber = groupNumber + 1;
        [self makeNewGroup];
    }
}

-(IBAction)getOverallStats:(id)sender {

    
    int totalPopulationCount = (int)[delegate.passengerList count];
    
    int child = 0;
    int education = 0;
    int labor = 0;
    int agriculture = 0;
    int medical = 0;
    int technical = 0;
    int management = 0;
    
    //age statistics
    int totalAge = 0;
    int maxAge = 0;
    int minAge = 100;
    
    //tolerance and aggression
    int toleranceTotal = 0;
    int aggressionTotal = 0;
    NSString *disposition = @"Neutral Disposition";
    
    //intelligence, engineering and tech
    int intelligenceTotal = 0;
    int engineeringTotal = 0;
    int techTotal = 0;
    NSString *intelligenceLevel = @"Average Intelligence";
    
    //physical characteristics
    int strengthTotal = 0;
    int adaptabilityTotal = 0;
    int tradeTotal = 0;
    NSString *physicalLevel = @"Average Physical Attributes";
    
    int healthTotal = 0;
    NSString *healthLevel = @"Average Health Level";
    int reproduction = 0;
    int giveBirth = 0;
    
    for (Person *aPerson in delegate.passengerList) {
        
        if ([aPerson.profession isEqualToString:@"Labor"]) {
            labor++;
        } else if ([aPerson.profession isEqualToString:@"Medical"]) {
            
            medical++;
        } else if ([aPerson.profession isEqualToString:@"Education"]) {
            
            education++;
        } else if ([aPerson.profession isEqualToString:@"Child"]) {
            
            child++;
        } else if ([aPerson.profession isEqualToString:@"Agriculture"]) {
            
            agriculture++;
        } else if ([aPerson.profession isEqualToString:@"Technical"]) {
            
            technical++;
        } else if ([aPerson.profession isEqualToString:@"Management"]) {
            
            management++;
        }
        
        //get age summary statistics
        totalAge = totalAge + aPerson.age;
        if (aPerson.age > maxAge) {
            
            maxAge = aPerson.age;
        }
        if (aPerson.age < minAge) {
            
            minAge = aPerson.age;
        }
        
        //tolerance and aggression
        toleranceTotal = toleranceTotal + aPerson.tolerance;
        aggressionTotal = aggressionTotal + aPerson.aggression;
        
        //intelligence, engineering and tech
        intelligenceTotal = intelligenceTotal + aPerson.intelligence;
        engineeringTotal = engineeringTotal + aPerson.engineering;
        techTotal = techTotal + aPerson.tech;
        
        //physical characteristics
        strengthTotal = strengthTotal + aPerson.strength;
        adaptabilityTotal = adaptabilityTotal + aPerson.adaptability;
        tradeTotal = tradeTotal + aPerson.trade;
        
        //reproduction and health
        healthTotal = healthTotal + aPerson.healthVisible;
        if (aPerson.canReproduce) {
            
            reproduction = reproduction + 1;
            
            if (aPerson.hasUterus) {
                
                giveBirth = giveBirth + 1;
            }
        }
    }

    //build the summary string
    //first, include the professions
    NSString *summaryString = [NSString stringWithFormat:@"Professional Composition:\nMedical: %d, Technical: %d, Agriculture: %d, Education: %d, Management: %d, Labor: %d, Child: %d\n\n", medical, technical, agriculture, education, management, labor, child];
    
    float averageAge = totalAge / totalPopulationCount;
    
    
    summaryString = [NSString stringWithFormat:@"%@Average Age: %.0f, youngest: %d, oldest: %d\n\n", summaryString, averageAge, minAge, maxAge];
    
    //determine disposition
    if (toleranceTotal/totalPopulationCount > 60) {
        if (aggressionTotal/totalPopulationCount < 40) {
            
            disposition = @"Positive Disposition";
        }
    } else if (aggressionTotal/totalPopulationCount > 60) {
        
        if (toleranceTotal/totalPopulationCount < 40) {
            
            disposition = @"Negative Disposition";
        }
    }
    
    //determine physical level
    if ((strengthTotal + adaptabilityTotal + tradeTotal)/(3 * totalPopulationCount) > 50) {
        
        physicalLevel = @"Above Average Physical Attributes";
        
    } else if ((strengthTotal + adaptabilityTotal + tradeTotal)/(3*totalPopulationCount) < 30) {
        
        physicalLevel = @"Below Average Physical Attributes";
    }
    
    //determine intelligence level
    if ((technical + medical)/totalPopulationCount > 4) {
        
        intelligenceLevel = @"Above Average Intelligence";
        
    } else if ((intelligenceTotal + engineeringTotal + techTotal)/(3*totalPopulationCount) > 55) {
        
        intelligenceLevel = @"Above Average Intelligence";
        
    } else if ((intelligenceTotal + engineeringTotal + techTotal)/(3*totalPopulationCount) < 30) {
        
        intelligenceLevel = @"Below Average Intelligence";
    }
    
    //determine health level
    if (healthTotal/totalPopulationCount > 50) {
        healthLevel = @"Above Average Health Level";
    } else if (healthTotal/totalPopulationCount < 25) {
        
        healthLevel = @"Below Average Health Level";
    }
    
    summaryString = [NSString stringWithFormat:@"%@%@\n%@\n%@\n%@\n", summaryString, disposition, intelligenceLevel, physicalLevel, healthLevel];
    
    summaryString = [NSString stringWithFormat:@"%@%d people can reproduce\n%d people can give birth", summaryString, reproduction, giveBirth];
    
    if (totalPopulationCount == 0) {
        informationLabel.text = @"You haven't accepted any groups to board the ship.";
    } else {
        
        informationLabel.text = summaryString;
    }
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [_player stop];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
