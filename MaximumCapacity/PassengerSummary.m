//
//  PassengerSummary.m
//  MaximumCapacity
//
//  Created by denise szecsei on 3/12/16.
//  Copyright © 2016 denise szecsei. All rights reserved.
//

#import "PassengerSummary.h"
#import "Person.h"

@implementation PassengerSummary


-(void)viewDidLoad {
    
    delegate = [[UIApplication sharedApplication] delegate];
    summaryLabel.numberOfLines = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    
    summaryLabel.text = [self getSummaryString];
    
}

-(NSString *)getSummaryString {
    
    int livingPopulation = 0;
    
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
        
        if (aPerson.healthActual > 0) {
            
            livingPopulation++;
            
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
    }
    
    if (livingPopulation == 0) {
        
        return @"Everyone is dead";
    }
    
    //build the summary string
    //first, include the professions
    NSString *summaryString = [NSString stringWithFormat:@"There are %d passengers currently alive on the ship.\n\nProfessional Composition:\nMedical: %d, Technical: %d, Agriculture: %d, Education: %d, Management: %d, Labor: %d, Child: %d\n\n", livingPopulation, medical, technical, agriculture, education, management, labor, child];
    
    float averageAge = totalAge / livingPopulation;
    
    
    summaryString = [NSString stringWithFormat:@"Age Distribution:\n%@Average Age: %.0f, youngest: %d, oldest: %d\n\n", summaryString, averageAge, minAge, maxAge];
    
    //determine disposition
    if (toleranceTotal/livingPopulation > 60) {
        if (aggressionTotal/livingPopulation < 40) {
            
            disposition = @"Positive Disposition";
        }
    } else if (aggressionTotal/livingPopulation > 60) {
        
        if (toleranceTotal/livingPopulation < 40) {
            
            disposition = @"Negative Disposition";
        }
    }
    
    //determine physical level
    if ((strengthTotal + adaptabilityTotal + tradeTotal)/(3 * livingPopulation) > 50) {
        
        physicalLevel = @"Above Average Physical Attributes";
        
    } else if ((strengthTotal + adaptabilityTotal + tradeTotal)/(3*livingPopulation) < 30) {
        
        physicalLevel = @"Below Average Physical Attributes";
    }
    
    //determine intelligence level
    if ((technical + medical)/livingPopulation > 4) {
        
        intelligenceLevel = @"Above Average Intelligence";
        
    } else if ((intelligenceTotal + engineeringTotal + techTotal)/(3*livingPopulation) > 55) {
        
        intelligenceLevel = @"Above Average Intelligence";
        
    } else if ((intelligenceTotal + engineeringTotal + techTotal)/(3*livingPopulation) < 30) {
        
        intelligenceLevel = @"Below Average Intelligence";
    }
    
    //determine health level
    NSLog(@"health: %d", healthTotal/livingPopulation);
    if (healthTotal/livingPopulation > 50) {
        healthLevel = @"Above Average Health Level";
    } else if (healthTotal/livingPopulation < 25) {
        
        healthLevel = @"Below Average Health Level";
    }
    
    summaryString = [NSString stringWithFormat:@"%@Passenger Characteristics:\n%@\n%@\n%@\n%@\n", summaryString, disposition, intelligenceLevel, physicalLevel, healthLevel];
    
    summaryString = [NSString stringWithFormat:@"%@%d people can reproduce\n%d people can give birth", summaryString, reproduction, giveBirth];
    
    if (livingPopulation == 0) {
        summaryLabel.text = @"Everyone is dead.";
    } else {
        
        summaryLabel.text = summaryString;
    }
    
    return summaryString;
    
}

-(IBAction)goBack:(id)sender {
    
    NSLog(@"go back");
    [self performSegueWithIdentifier:@"monitorShipSegue" sender:nil];
}

@end
