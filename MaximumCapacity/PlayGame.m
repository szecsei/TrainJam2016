//
//  PlayGame.m
//  MaximumCapacity
//
//  Created by denise szecsei on 3/12/16.
//  Copyright © 2016 denise szecsei. All rights reserved.
//

#import "PlayGame.h"
#import "Person.h"
#import <GameplayKit/GameplayKit.h>

@interface PlayGame ()

@end

@implementation PlayGame



- (void)viewDidLoad {
    
    weekCounter = 0;
    
    delegate = [[UIApplication sharedApplication] delegate];
    
    //set initial resource levels based on a gaussian distribution
    //if the resource levels drop 
    shipResourceLevel = 100;
    shipMechanicalLevel = 100;
    
    lastMechanical = 0;
    lastVirus = 0;
    
    
    //each person is assigned an initial morale level based on a gaussian distribution
    
    gameOver = NO;
    
    [self statusUpdate:@"start"];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)yourButtonDidTap {
    
    NSString *soundFilePath = [NSString stringWithFormat:@"%@/%@.mp3", [[NSBundle mainBundle] resourcePath], @"MusicTest1Sifi"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                     error:nil];
    _player.numberOfLoops = 0;
    
    [_player play];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self getPassengerDetails];
    [self yourButtonDidTap];
}


-(IBAction)statusUpdate:(id)sender {
    
    captainsLog.text = [self createUpdate];
    weekCounter++;
    
    if (weekCounter == 15) {

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over!" message:@"You made it to the promised land.  Congratulations!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Excellent. I'll let someone else play.", nil];
        
        alert.tag = 5;
        
        [alert show];
    }
    if (gameOver) {
        
        NSString *myMessage = [NSString stringWithFormat:@"You did not make it to the promised land.  You did survive for %d weeks, though!", weekCounter];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over!" message:myMessage delegate:self cancelButtonTitle:nil otherButtonTitles:@"Bummer. Try again.", nil];
        
        alert.tag = 1;
        
        [alert show];
    }
}



-(NSString *)createUpdate {
    
    NSLog(@"create update");
    
    int virusDiff = weekCounter - lastVirus;
    int mechDiff = weekCounter - lastMechanical;
    
    if ((weekCounter > 0) & !gameOver) {
        
        int randomNumber = arc4random() % 10;
        if ((randomNumber == 7 | randomNumber == 4) & ((mechDiff > 3) | (lastMechanical == 0))) {
            
            [self breakTheShip];
            
        } else if ((randomNumber == 1 | randomNumber == 9) & ((virusDiff > 3) | (lastVirus == 0))) {
            
            [self virus];
            
        } else {
            
            [self tweakParameters];
        }
    }
    
    NSString *myString = [NSString stringWithFormat:@"Captain's Log: Week %d\n\n", weekCounter];
    NSString *healthUpdate = [self getHealthLevel];
    NSString *moraleUpdate = [self getMoraleLevel];
    NSString *resourceUpdate = [self getResourceLevel];
    NSString *shipUpdate = [self getShipStatus];
    myString = [NSString stringWithFormat:@"%@%@\n\n%@\n\n%@\n\n%@", myString, healthUpdate, moraleUpdate, resourceUpdate, shipUpdate];

    return myString;
}

-(NSString *)getMoraleLevel {
    
    //when a person is created, they are assigned an actual health level between 20 and 80
    //based on a uniform distribution
    
    //traveling in space tends to decrease health levels
    //adequate resources tends to increase health levels
    
    int totalPopulationCount = (int)[delegate.passengerList count];
    int moraleLevel = 0;
    int depressedPeople = 0;
    
    for (Person *aPerson in delegate.passengerList) {
        
        moraleLevel = moraleLevel + aPerson.morale;
        if (aPerson.morale < 40) {
            depressedPeople++;
        }
    }
    
    populationMoraleLevel = moraleLevel/totalPopulationCount;
    
    if (populationMoraleLevel > 60) {
        NSString *aString = [NSString stringWithFormat:@"Overall population morale is excellent.  There are %d depressed people.", depressedPeople];
        [moraleStatusImage setImage:[UIImage imageNamed:@"GreenLight.png"]];
        return aString;
    } else if (populationMoraleLevel < 10) {
        
        NSString *aString = [NSString stringWithFormat:@"Your population is upset and have risen up against you.  There are %d depressed people.", depressedPeople];
        [moraleStatusImage setImage:[UIImage imageNamed:@"RedLight.png"]];
        return aString;
    } else {
        
        NSString *aString = [NSString stringWithFormat:@"Overall population morale is declining.  There are %d depressed people.", depressedPeople];
        [moraleStatusImage setImage:[UIImage imageNamed:@"YellowLight.png"]];
        return aString;
    }
    return @"Why are we here?";
}

-(NSString *)getHealthLevel {
    
    //when a person is created, they are assigned an actual health level between 20 and 80
    //based on a uniform distribution
    
    //traveling in space tends to decrease health levels
    //adequate resources tends to increase health levels

    int sickPeople = [self measureHealth];
    NSLog(@"population health: %d", populationHealthLevel);
    
    if (populationHealthLevel > 50) {
        NSString *aString = [NSString stringWithFormat:@"Overall population health is excellent.  There are %d sick people.", sickPeople];
        [healthStatusImage setImage:[UIImage imageNamed:@"GreenLight.png"]];
        return aString;
    } else if (populationHealthLevel < 10) {
        
        NSString *aString = [NSString stringWithFormat:@"Your population is dying.  There are %d sick people.", sickPeople];
        [healthStatusImage setImage:[UIImage imageNamed:@"RedLight.png"]];
        gameOver = YES;
        return aString;
    } else {
        
        NSString *aString = [NSString stringWithFormat:@"Overall population health is below optimal levels.  There are %d sick people.", sickPeople];
        [healthStatusImage setImage:[UIImage imageNamed:@"YellowLight.png"]];
        return aString;
    }
    return @"Why are we here?";
}



-(NSString *)getResourceLevel {
    
    if (shipResourceLevel > 75) {
        
        [resourceStatusImage setImage:[UIImage imageNamed:@"GreenLight.png"]];
        return @"Ship resources are holding";
        
    } else if (shipResourceLevel < 10) {
        
        [resourceStatusImage setImage:[UIImage imageNamed:@"RedLight.png"]];
        gameOver = YES;
        return @"You are out of resources.  Your population dies out.";
    } else {
        
        [resourceStatusImage setImage:[UIImage imageNamed:@"YellowLight.png"]];
        return @"You are running out of resources.  You need to put some labor into it!";
    }
    
    return @"Why are we here?";
}

-(NSString *)getShipStatus {
    
    
    if (shipMechanicalLevel > 75) {
        
        [shipStatusImage setImage:[UIImage imageNamed:@"GreenLight.png"]];
        return @"Ship is functioning within acceptable operation parameters.";
        
    } else if (shipResourceLevel < 10) {
        
        [shipStatusImage setImage:[UIImage imageNamed:@"RedLight.png"]];
        gameOver = YES;
        return @"Your ship can no longer function.  Your population dies out.";
    } else {
        
        [shipStatusImage setImage:[UIImage imageNamed:@"YellowLight.png"]];
        return @"Your ship is in need of repair.  You need to address these issues soon!";
    }
    
    return @"Why are we here?";
}

//MARK: generate random numbers based on uniform and gaussian distributions

-(int)getRandomUniform:(int)low highValue:(int)high {
    
    return arc4random_uniform(high - low) + low;
    //return ((arc4random() % (high - low)) + low);
}

-(int)getRandomGaussian:(int)low highValue:(int)high {
    
    GKRandomSource *random = [[GKRandomSource alloc] init];
    GKRandomDistribution *dist = [[GKGaussianDistribution alloc] initWithRandomSource:random lowestValue:low highestValue:high];
    
    int value = (int)[dist nextInt];
    return value;
    
}

-(void)tweakParameters {
    
    //we will increase/decrease parameters based on the professions selected
    //if the percentage of healthy labor is at least 40%, the resources can be sustained or increased
    if ([self countHealthyLabor] > 40) {
        
        shipResourceLevel = shipResourceLevel + [self getRandomUniform:4 highValue:10];
    } else {
        
        //otherwise, the resources will decrease by a certain factor (lose 10 points)
        shipResourceLevel = shipResourceLevel - 10;
    }

    //adjust health based on healthy medical population, current resources
    //if the percentage of Medical people is greater than 20%, the health can be maintained
    if ([self countHealthyMedical] < 20) {
        
        [self adjustHealthofPopulationDown];
    }
    if (shipResourceLevel < 70) {
        
        [self adjustHealthofPopulationDown];
    }
    
    if ([self countReproduction] < 70) {
        
        //if more than 70% of the population can reproduce, health can be maintained
        //if a person's health is less than 30, they cannot reproduce
        
        [self adjustHealthofPopulationDown];
    }

    //if the percentage of technical people is less than 20%, the ship cannot be maintained (lose 5 points)
    if ([self countHealthTechnical] < 20) {
        
        shipMechanicalLevel = shipMechanicalLevel - 5;
    }
    
    [self adjustMoraleLevel];
    
}

-(int)countHealthyLabor {
    
    int totalPopulationCount = 0;
    int numberOfHealthyLabor = 0;

    
    for (Person *aPerson in delegate.passengerList) {
        if (aPerson.healthActual > 0) {
            totalPopulationCount++;
        }
        if ([aPerson.profession isEqualToString:@"Labor"]) {
            if (aPerson.healthActual > 30) {
                
                numberOfHealthyLabor++;
            }
        }
    }
    
    //return the percentage of people living who are labor
    return numberOfHealthyLabor*100/totalPopulationCount;
}

-(int)countHealthyMedical {
    
    int totalPopulationCount = 0;
    int numberOfHealthyMedical = 0;
    
    
    for (Person *aPerson in delegate.passengerList) {
        if (aPerson.healthActual > 0) {
            totalPopulationCount++;
        }
        if ([aPerson.profession isEqualToString:@"Medical"]) {
            if (aPerson.healthActual > 30) {
                
                numberOfHealthyMedical++;
            }
        }
    }
    
    //return the percentage of people living who are medical
    return numberOfHealthyMedical*100/totalPopulationCount;
}

-(void)adjustHealthofPopulationUp {
    
    for (Person *aPerson in delegate.passengerList) {
        
        //only adjust the health of people with positive health
        if (aPerson.healthActual > 0) {
            aPerson.healthActual = aPerson.healthActual + [self getRandomUniform:0 highValue:5];
            if (aPerson.morale > 70) {
                aPerson.healthActual = aPerson.healthActual + [self getRandomUniform:0 highValue:3];
            }
        }
    }
}

-(void)adjustHealthofPopulationDown {
    
    for (Person *aPerson in delegate.passengerList) {
        
        if (aPerson.healthActual > 0) {
            aPerson.healthActual = aPerson.healthActual - [self getRandomUniform:3 highValue:7];
            if (aPerson.morale < 30) {
                aPerson.healthActual = MAX(aPerson.healthActual - [self getRandomUniform:2 highValue:5], 0);
            }
        }
    }
}

-(void)setReproduction {
    
    for (Person *aPerson in delegate.passengerList) {
        
        if (aPerson.healthActual < 30) {
            
            aPerson.canReproduce = NO;
        }
    }
}

-(int)countReproduction {
    
    int totalPopulation = 0;
    int reproducingPopulation = 0;
    
    for (Person *aPerson in delegate.passengerList) {
        
        if (aPerson.healthActual > 0) {
            
            totalPopulation++;
            if (aPerson.canReproduce) {
                reproducingPopulation++;
            }
        }
    }
    return reproducingPopulation*100/totalPopulation;
    
}

-(int)countHealthTechnical {
    
    int totalPopulationCount = 0;
    int numberOfHealthyTechnical = 0;
    
    
    for (Person *aPerson in delegate.passengerList) {
        if (aPerson.healthActual > 0) {
            totalPopulationCount++;
        }
        if ([aPerson.profession isEqualToString:@"Technical"]) {
            if (aPerson.healthActual > 30) {
                
                numberOfHealthyTechnical++;
            }
        }
    }
    
    //return the percentage of people living who are medical
    return numberOfHealthyTechnical*100/totalPopulationCount;
}

-(void)adjustMoraleLevel {
    
    for (Person *aPerson in delegate.passengerList) {
        
        if (aPerson.healthActual <30) {
            aPerson.morale = aPerson.morale - 10;
        } else if (aPerson.healthActual > 70) {
            
            aPerson.morale = aPerson.morale + 10;
        }
        
        if (shipResourceLevel < 50) {
            aPerson.morale = aPerson.morale - 10;
        } else if (shipResourceLevel < 75) {
            
            aPerson.morale = aPerson.morale - 5;
        } else {
            
            aPerson.morale = aPerson.morale + 5;
        }
        
        if (aPerson.morale <= 0) {
            aPerson.morale = 0;
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (alertView.tag == 1) {
        NSLog(@"tagged alert triggered");
        [self performSegueWithIdentifier:@"gameOverSegue" sender:nil];
    } else if (alertView.tag == 3) {
        
        [self trackProfessionals];
        
        if (buttonIndex == 1) {
            NSLog(@"Produce resources");
            
            //if they do this, bring the health of all laborers down by 10 units
            //raise the resources by 2 times the number of healthy laborers
            
            if (countLabor > 0) {
                
                [self produceResources];
            }
            
            //update the ship
            [self statusUpdate:@"Resources"];
            
        } else if (buttonIndex == 2) {
            
            NSLog(@"Fix the ship");
            
            //if they do this, bring the health of all technical people down by 10 units
            //raise the ship status by 5 times the number of healthy technical people
            
            if (countTechnical) {
                
                [self fixTheShip];
            }
            
            [self statusUpdate:@"Technical"];
            
        } else if (buttonIndex == 3) {
            
            NSLog(@"Heal the ship");
            
            //if they do this, bring the health of all medical people down by 10 units
            //can only do this if there is at least one healthy medical person
            //raise the health of all people less than 50 by 5 * healthy medical people units
            
            
            if (countMedical > 0) {
                [self healTheSick];
            }

            [self statusUpdate:@"Health"];
        }
    } else if (alertView.tag == 2) {
        
        if (buttonIndex == 1) {
            //Remove the sick
            [self removeTheSick];
            
        } else {
            
            //heal the sick
            [self healTheSick];
            weekCounter++;
        }
        NSLog(@"virus action");
        
    } else if (alertView.tag == 4) {
        
        if (buttonIndex == 0) {
            //they did nothing
            [self createUpdate];
        } else if (buttonIndex == 1) {

            //only take health from one technician
            BOOL shouldRemove = YES;
            for (Person *aPerson in delegate.passengerList) {
                if ([aPerson.profession isEqualToString:@"Technical"]) {
                    if (shouldRemove) {
                        aPerson.healthActual = MAX(aPerson.healthActual - 8, 0);
                        shouldRemove = NO;
                    }
                }
            }
            
            //make the repairs but remove health from one technician
            shipMechanicalLevel = shipMechanicalLevel + 10;
            
        } else if (buttonIndex == 2) {
            
            shipMechanicalLevel = shipMechanicalLevel + 20;
            //remove health from all technicians
            for (Person *aPerson in delegate.passengerList) {
                if ([aPerson.profession isEqualToString:@"Technical"]) {
                    aPerson.healthActual = MAX(aPerson.healthActual - 8, 0);

                }
            }
        }
        
        
        NSLog(@"explosion action");
    } else if (alertView.tag == 5) {
        
        [self performSegueWithIdentifier:@"gameOverSegue" sender:nil];
        
    }
}

-(void)produceResources {
    
    NSLog(@"resources before: %d", shipResourceLevel);
    int healthyLabor = 0;
    
    //count healthy labor
    for (Person *aPerson in delegate.passengerList) {
        if ([aPerson.profession isEqualToString:@"Labor"]) {
            if (aPerson.healthActual > 25) {
                healthyLabor++;
            }
            aPerson.healthActual = MAX(aPerson.healthActual - 8, 0);
        }
    }
    
    NSLog(@"healthy labor: %d", healthyLabor);
    
    //add to resources
    shipResourceLevel = shipResourceLevel + 2*healthyLabor;
    
    NSLog(@"resources after: %d", shipResourceLevel);
}

-(void)fixTheShip {
    
    NSLog(@"ship status before: %d", shipMechanicalLevel);
    int healthyTech = 0;
    
    //count healthy labor
    for (Person *aPerson in delegate.passengerList) {
        if ([aPerson.profession isEqualToString:@"Technical"]) {
            if (aPerson.healthActual > 25) {
                healthyTech++;
            }
            aPerson.healthActual = MAX(aPerson.healthActual - 8, 0);
        }
    }
    
    NSLog(@"healthy tech: %d", healthyTech);
    
    //add to resources
    shipMechanicalLevel = shipMechanicalLevel + 5*healthyTech;
    
    [self getPassengerDetails];
    
    NSLog(@"ship status after: %d", shipMechanicalLevel);
}

-(void)healTheSick {
    
    NSLog(@"health before %d", populationHealthLevel);
    int healthyMedical = 0;
    
    //count healthy labor
    for (Person *aPerson in delegate.passengerList) {
        if ([aPerson.profession isEqualToString:@"Medical"]) {
            if (aPerson.healthActual > 25) {
                healthyMedical++;
            }
            aPerson.healthActual = MAX(aPerson.healthActual - 8, 0);
        }
    }
    
    NSLog(@"healthy medical: %d", healthyMedical);
    
    //heal the sick
    for (Person *aPerson in delegate.passengerList) {
        
        if (aPerson.healthActual < 50) {
            aPerson.healthActual = aPerson.healthActual + 10 * healthyMedical;
        }
    }
    
    //remove health from medical folks
    for (Person *aPerson in delegate.passengerList) {
        if ([aPerson.profession isEqualToString:@"Medical"]) {
            
            aPerson.healthActual = MAX(aPerson.healthActual - 8, 0);
        }
    }
    
    [self measureHealth];
    [self getPassengerDetails];
}

-(int)measureHealth {
    
    int totalPopulationCount = (int)[delegate.passengerList count];
    int healthLevel = 0;
    int sickPeople = 0;
    
    for (Person *aPerson in delegate.passengerList) {
        
        healthLevel = healthLevel + aPerson.healthActual;
        if (aPerson.healthActual < 25) {
            sickPeople++;
        }
    }
    
    populationHealthLevel = healthLevel/totalPopulationCount;
    
    return sickPeople;
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {
    
    [self trackProfessionals];
    
    if (alertView.tag == 3) {
        if (countLabor == 0) {
            return NO;
        }
    } else {
        
        return YES;
    }
    return YES;
}

-(IBAction)takeAction:(id)sender {
    
    [self trackProfessionals];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Take Action" message:@"Which action do you want to take?" delegate:self cancelButtonTitle:@"None of the above" otherButtonTitles:@"Produce resources", @"Fix the ship", @"Heal the sick", nil];
    
    alert.tag = 3;
    [alert show];
}


-(void)getPassengerDetails {
    
    NSLog(@"get passenger details");
    NSString *myString = [NSString stringWithFormat:@"Captain's Log: Week %d\n\n", weekCounter];
    NSString *healthUpdate = [self getHealthLevel];
    NSString *moraleUpdate = [self getMoraleLevel];
    NSString *resourceUpdate = [self getResourceLevel];
    NSString *shipUpdate = [self getShipStatus];
    captainsLog.text = [NSString stringWithFormat:@"%@%@\n\n%@\n\n%@\n\n%@", myString, healthUpdate, moraleUpdate, resourceUpdate, shipUpdate];
}

-(void)virus {
    
    //for a virus, mainly affect weak people
    //reduce health by uniform distribution 5-10 units depending on intensity and health
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Virus has struck" message:@"Which action do you want to take?" delegate:self cancelButtonTitle:@"None of the above" otherButtonTitles:@"Remove the sick", @"Heal the sick", nil];
    
    alert.tag = 2;
    [alert show];
}

-(void)breakTheShip {
    
    //reduce the ship status by some factor

    shipMechanicalLevel = shipMechanicalLevel - 20;
    
    [self trackProfessionals];
    
    weekCounter++;
    
    if (countTechnical == 1) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mechanical Failure!" message:@"Which action do you want to take?" delegate:self cancelButtonTitle:@"Nothing" otherButtonTitles:@"Send a technician", nil];
        
        alert.tag = 4;
        [alert show];
    } else if (countTechnical == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mechanical Failure!" message:@"You do not have any healthy technical people available to repair the ship." delegate:self cancelButtonTitle:@"Bummer" otherButtonTitles:nil];
        
        alert.tag = 4;
        [alert show];
    } else if (countTechnical > 1) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mechanical Failure!" message:@"Which action do you want to take?" delegate:self cancelButtonTitle:@"Nothing" otherButtonTitles:@"Send a technician", @"Send all the technicians", nil];
        
        alert.tag = 4;
        [alert show];
    }
    
}


-(IBAction)monitorShip:(UIStoryboardSegue *)segue
{
    NSLog(@"Back to monitoring ship status");
    
}

-(void)trackProfessionals {
    
    int med = 0;
    int tech = 0;
    int lab = 0;
    
    for (Person *aPerson in delegate.passengerList) {
        
        if ([aPerson.profession isEqualToString:@"Medical"]) {
            if (aPerson.healthActual > 30) {
                
                med++;
            }
        } else if ([aPerson.profession isEqualToString:@"Technical"]) {
            if (aPerson.healthActual > 30) {
                
                tech++;
            }
        }
        else if ([aPerson.profession isEqualToString:@"Labor"]) {
            if (aPerson.healthActual > 30) {
                
                lab++;
            }
        }
    }
    
    NSLog(@"medical: %d, technical: %d, labor: %d", med, tech, lab);
    countMedical = med;
    countTechnical = tech;
    countLabor = lab;
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [_player stop];
}

-(void)removeTheSick {
    
    //set all sick people to zero health
    for (Person *aPerson in delegate.passengerList) {
        
        if (aPerson.healthActual < 20) {
            aPerson.healthActual = 0;
        }
    }
    weekCounter++;
    [self getPassengerDetails];
}



@end


