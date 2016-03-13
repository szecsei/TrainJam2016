//
//  Person.m
//  MaximumCapacity
//
//  Created by denise szecsei on 3/10/16.
//  Copyright © 2016 denise szecsei. All rights reserved.
//

#import "Person.h"
#import <GameplayKit/GameplayKit.h>

@implementation Person


@synthesize name = _name;
@synthesize healthActual = _healthActual;
@synthesize healthVisible = _healthVisible;
@synthesize age = _age;
@synthesize canReproduce = _canReproduce;
@synthesize hasUterus = _hasUterus;
@synthesize profession = _profession;
@synthesize intelligence = _intelligence;
@synthesize aggression = _aggression;
@synthesize adaptability = _adaptability;
@synthesize tolerance = _tolerance;
@synthesize healing = _healing;
@synthesize strength = _strength;
@synthesize tech = _tech;
@synthesize morale = _morale;
@synthesize trade = _trade;
@synthesize engineering = _engineering;



-(id)initWithProfession:(NSString *)prof {

    _profession = prof;
    
    //create a child
    if ([prof isEqualToString:@"Child"]) {
        
        //create values for these parameters
        _intelligence = [self getRandomGaussian:60 highValue:80];
        _strength = [self getRandomUniform:5 highValue:20];
        _tolerance = [self getRandomUniform:75 highValue:100];
        _adaptability = [self getRandomGaussian:75 highValue:95];
        _aggression = [self getRandomUniform:0 highValue:20];
        _age = [self getRandomUniform:1 highValue:16];
        _healing = [self getRandomUniform:0 highValue:10];
        
        if (_age < 7) {
            
            _trade = 1;
            _engineering = 1;
            _tech = [self getRandomUniform:5 highValue:20];
            
        } else if (_age < 12) {
            
            _trade = [self getRandomUniform:5 highValue:10];
            _engineering = [self getRandomUniform:5 highValue:10];
            _tech = [self getRandomUniform:20 highValue:50];
            
        } else {
            
            _trade = [self getRandomUniform:5 highValue:25];
            _engineering = [self getRandomUniform:10 highValue:50];
            _tech = [self getRandomUniform:40 highValue:70];
        }
        
        _hasUterus = [self getRandomUniform:0 highValue:1];
        
        _healthActual = [self getRandomUniform:20 highValue:80];
        _healthVisible = [self getRandomUniform:(_healthActual -5) highValue:(_healthActual + 20)];
        
        
        //determine if the person has a uterus
        int temp = arc4random() % 2;
        if (temp == 0) {
            _hasUterus = YES;
            if (_age > 14) {
                
                _canReproduce = YES;
                
            } else {
                
                _canReproduce = NO;
                
            }
        } else {
            
            _hasUterus = NO;
            
            if (_age > 14) {
                
                _canReproduce = YES;
                
            } else {
                
                _canReproduce = NO;
                
            }
        }
        //[self logCharacteristics];
        return self;
    }
    
    //make the dictionary for the profession
    NSMutableDictionary *profDict = [self.makeDictionaries objectForKey:prof];
    
    //use the details on the profession to create values for these parameters
    //get the gaussian parameters first
    _intelligence = [self getRandomGaussian:(int)[[profDict objectForKey:@"intelligenceLow"] integerValue] highValue:(int)[[profDict objectForKey:@"intelligenceHigh"] integerValue]];
    
    _strength = [self getRandomGaussian:(int)[[profDict objectForKey:@"strengthLow"] integerValue] highValue:(int)[[profDict objectForKey:@"strengthHigh"] integerValue]];
    
    _tolerance = [self getRandomGaussian:(int)[[profDict objectForKey:@"toleranceLow"] integerValue] highValue:(int)[[profDict objectForKey:@"toleranceHigh"] integerValue]];
    
    _adaptability = [self getRandomGaussian:(int)[[profDict objectForKey:@"adaptabilityLow"] integerValue] highValue:(int)[[profDict objectForKey:@"adaptabilityHigh"] integerValue]];
    
    
    //get the uniform parameters next
    _aggression = [self getRandomUniform:(int)[[profDict objectForKey:@"aggressionLow"] integerValue] highValue:(int)[[profDict objectForKey:@"aggressionHigh"] integerValue]];
    
    _age = [self getRandomUniform:(int)[[profDict objectForKey:@"ageLow"] integerValue] highValue:(int)[[profDict objectForKey:@"ageHigh"] integerValue]];
    
    _healing = [self getRandomUniform:(int)[[profDict objectForKey:@"healingLow"] integerValue] highValue:(int)[[profDict objectForKey:@"healingHigh"] integerValue]];
    
    _trade = [self getRandomUniform:(int)[[profDict objectForKey:@"tradeLow"] integerValue] highValue:(int)[[profDict objectForKey:@"tradeHigh"] integerValue]];
    
    _engineering = [self getRandomUniform:(int)[[profDict objectForKey:@"engineeringLow"] integerValue] highValue:(int)[[profDict objectForKey:@"engineeringHigh"] integerValue]];
    
    _tech = [self getRandomUniform:(int)[[profDict objectForKey:@"techLow"] integerValue] highValue:(int)[[profDict objectForKey:@"techHigh"] integerValue]];
    
    _healthActual = [self getRandomUniform:20 highValue:80];
    _healthVisible = [self getRandomUniform:(_healthActual -5) highValue:(_healthActual + 20)];


    
    //determine if the person has a uterus
    int temp = arc4random() % 2;
    if (temp == 0) {
        _hasUterus = YES;
        
        //determine if they can reproduce
        if (_age < 35) {
            
            int temp = (int)[self getRandomUniform:1 highValue:100];
            if (temp > 80) {
                _canReproduce = NO;
            }
            else {
                _canReproduce = YES;
            }
        } else if (_age > 45) {
            
            _canReproduce = NO;
        } else {
            
            int temp = (int)[self getRandomUniform:1 highValue:100];
            if (temp > 80) {
                _canReproduce = YES;
            }
            else {
                _canReproduce = NO;
            }
        }
    } else {
        
        _hasUterus = NO;
        
        int temp = (int)[self getRandomUniform:1 highValue:100];
        if (temp > 21) {
            _canReproduce = YES;
        }
        else {
            _canReproduce = NO;
        }
    }
    
    _name = @"";
    _morale = [self getRandomGaussian:70 highValue:90];
    
    //[self logCharacteristics];
    return self;
}

-(NSMutableDictionary *)makeDictionaries {
    
    NSMutableDictionary *profDict = [[NSMutableDictionary alloc] init];
    
    //characterize labor folks
    NSMutableDictionary *laborDict = [[NSMutableDictionary alloc] init];
    [laborDict setObject:[NSNumber numberWithInt:50] forKey:@"intelligenceLow"];
    [laborDict setObject:[NSNumber numberWithInt:70] forKey:@"intelligenceHigh"];
    [laborDict setObject:[NSNumber numberWithInt:20] forKey:@"toleranceLow"];
    [laborDict setObject:[NSNumber numberWithInt:70] forKey:@"toleranceHigh"];
    [laborDict setObject:[NSNumber numberWithInt:20] forKey:@"aggressionLow"];
    [laborDict setObject:[NSNumber numberWithInt:100] forKey:@"aggressionHigh"];
    [laborDict setObject:[NSNumber numberWithInt:20] forKey:@"adaptabilityLow"];
    [laborDict setObject:[NSNumber numberWithInt:100] forKey:@"adaptabilityHigh"];
    [laborDict setObject:[NSNumber numberWithInt:20] forKey:@"ageLow"];
    [laborDict setObject:[NSNumber numberWithInt:80] forKey:@"ageHigh"];
    [laborDict setObject:[NSNumber numberWithInt:20] forKey:@"healingLow"];
    [laborDict setObject:[NSNumber numberWithInt:40] forKey:@"healingHigh"];
    [laborDict setObject:[NSNumber numberWithInt:80] forKey:@"strengthLow"];
    [laborDict setObject:[NSNumber numberWithInt:90] forKey:@"strengthHigh"];
    [laborDict setObject:[NSNumber numberWithInt:70] forKey:@"tradeLow"];
    [laborDict setObject:[NSNumber numberWithInt:90] forKey:@"tradeHigh"];
    [laborDict setObject:[NSNumber numberWithInt:10] forKey:@"engineeringLow"];
    [laborDict setObject:[NSNumber numberWithInt:40] forKey:@"engineeringHigh"];
    [laborDict setObject:[NSNumber numberWithInt:0] forKey:@"techLow"];
    [laborDict setObject:[NSNumber numberWithInt:50] forKey:@"techHigh"];
    [profDict setObject:laborDict forKey:@"Labor"];


    //characterize medical folks
    NSMutableDictionary *medicalDict = [[NSMutableDictionary alloc] init];
    [medicalDict setObject:[NSNumber numberWithInt:70] forKey:@"intelligenceLow"];
    [medicalDict setObject:[NSNumber numberWithInt:90] forKey:@"intelligenceHigh"];
    [medicalDict setObject:[NSNumber numberWithInt:60] forKey:@"toleranceLow"];
    [medicalDict setObject:[NSNumber numberWithInt:100] forKey:@"toleranceHigh"];
    [medicalDict setObject:[NSNumber numberWithInt:15] forKey:@"aggressionLow"];
    [medicalDict setObject:[NSNumber numberWithInt:35] forKey:@"aggressionHigh"];
    [medicalDict setObject:[NSNumber numberWithInt:40] forKey:@"adaptabilityLow"];
    [medicalDict setObject:[NSNumber numberWithInt:80] forKey:@"adaptabilityHigh"];
    [medicalDict setObject:[NSNumber numberWithInt:25] forKey:@"ageLow"];
    [medicalDict setObject:[NSNumber numberWithInt:60] forKey:@"ageHigh"];
    [medicalDict setObject:[NSNumber numberWithInt:88] forKey:@"healingLow"];
    [medicalDict setObject:[NSNumber numberWithInt:92] forKey:@"healingHigh"];
    [medicalDict setObject:[NSNumber numberWithInt:20] forKey:@"strengthLow"];
    [medicalDict setObject:[NSNumber numberWithInt:80] forKey:@"strengthHigh"];
    [medicalDict setObject:[NSNumber numberWithInt:0] forKey:@"tradeLow"];
    [medicalDict setObject:[NSNumber numberWithInt:30] forKey:@"tradeHigh"];
    [medicalDict setObject:[NSNumber numberWithInt:20] forKey:@"engineeringLow"];
    [medicalDict setObject:[NSNumber numberWithInt:60] forKey:@"engineeringHigh"];
    [medicalDict setObject:[NSNumber numberWithInt:60] forKey:@"techLow"];
    [medicalDict setObject:[NSNumber numberWithInt:80] forKey:@"techHigh"];
    [profDict setObject:medicalDict forKey:@"Medical"];

    //set up agriculture folks
    NSMutableDictionary *agricultureDict = [[NSMutableDictionary alloc] init];
    [agricultureDict setObject:[NSNumber numberWithInt:70] forKey:@"intelligenceLow"];
    [agricultureDict setObject:[NSNumber numberWithInt:90] forKey:@"intelligenceHigh"];
    [agricultureDict setObject:[NSNumber numberWithInt:30] forKey:@"toleranceLow"];
    [agricultureDict setObject:[NSNumber numberWithInt:70] forKey:@"toleranceHigh"];
    [agricultureDict setObject:[NSNumber numberWithInt:35] forKey:@"aggressionLow"];
    [agricultureDict setObject:[NSNumber numberWithInt:80] forKey:@"aggressionHigh"];
    [agricultureDict setObject:[NSNumber numberWithInt:75] forKey:@"adaptabilityLow"];
    [agricultureDict setObject:[NSNumber numberWithInt:85] forKey:@"adaptabilityHigh"];
    [agricultureDict setObject:[NSNumber numberWithInt:20] forKey:@"ageLow"];
    [agricultureDict setObject:[NSNumber numberWithInt:80] forKey:@"ageHigh"];
    [agricultureDict setObject:[NSNumber numberWithInt:60] forKey:@"healingLow"];
    [agricultureDict setObject:[NSNumber numberWithInt:80] forKey:@"healingHigh"];
    [agricultureDict setObject:[NSNumber numberWithInt:80] forKey:@"strengthLow"];
    [agricultureDict setObject:[NSNumber numberWithInt:90] forKey:@"strengthHigh"];
    [agricultureDict setObject:[NSNumber numberWithInt:80] forKey:@"tradeLow"];
    [agricultureDict setObject:[NSNumber numberWithInt:95] forKey:@"tradeHigh"];
    [agricultureDict setObject:[NSNumber numberWithInt:70] forKey:@"engineeringLow"];
    [agricultureDict setObject:[NSNumber numberWithInt:90] forKey:@"engineeringHigh"];
    [agricultureDict setObject:[NSNumber numberWithInt:60] forKey:@"techLow"];
    [agricultureDict setObject:[NSNumber numberWithInt:80] forKey:@"techHigh"];
    [profDict setObject:agricultureDict forKey:@"Agriculture"];


    //set up the technical folks
    NSMutableDictionary *technicalDict = [[NSMutableDictionary alloc] init];
    [technicalDict setObject:[NSNumber numberWithInt:75] forKey:@"intelligenceLow"];
    [technicalDict setObject:[NSNumber numberWithInt:85] forKey:@"intelligenceHigh"];
    [technicalDict setObject:[NSNumber numberWithInt:20] forKey:@"toleranceLow"];
    [technicalDict setObject:[NSNumber numberWithInt:80] forKey:@"toleranceHigh"];
    [technicalDict setObject:[NSNumber numberWithInt:20] forKey:@"aggressionLow"];
    [technicalDict setObject:[NSNumber numberWithInt:50] forKey:@"aggressionHigh"];
    [technicalDict setObject:[NSNumber numberWithInt:50] forKey:@"adaptabilityLow"];
    [technicalDict setObject:[NSNumber numberWithInt:90] forKey:@"adaptabilityHigh"];
    [technicalDict setObject:[NSNumber numberWithInt:20] forKey:@"ageLow"];
    [technicalDict setObject:[NSNumber numberWithInt:50] forKey:@"ageHigh"];
    [technicalDict setObject:[NSNumber numberWithInt:20] forKey:@"healingLow"];
    [technicalDict setObject:[NSNumber numberWithInt:20] forKey:@"healingHigh"];
    [technicalDict setObject:[NSNumber numberWithInt:55] forKey:@"strengthLow"];
    [technicalDict setObject:[NSNumber numberWithInt:75] forKey:@"strengthHigh"];
    [technicalDict setObject:[NSNumber numberWithInt:40] forKey:@"tradeLow"];
    [technicalDict setObject:[NSNumber numberWithInt:80] forKey:@"tradeHigh"];
    [technicalDict setObject:[NSNumber numberWithInt:10] forKey:@"engineeringLow"];
    [technicalDict setObject:[NSNumber numberWithInt:65] forKey:@"engineeringHigh"];
    [technicalDict setObject:[NSNumber numberWithInt:90] forKey:@"techLow"];
    [technicalDict setObject:[NSNumber numberWithInt:100] forKey:@"techHigh"];
    [profDict setObject:technicalDict forKey:@"Technical"];
    
    //set up the education folks
    NSMutableDictionary *educationDict = [[NSMutableDictionary alloc] init];
    [educationDict setObject:[NSNumber numberWithInt:50] forKey:@"intelligenceLow"];
    [educationDict setObject:[NSNumber numberWithInt:75] forKey:@"intelligenceHigh"];
    [educationDict setObject:[NSNumber numberWithInt:75] forKey:@"toleranceLow"];
    [educationDict setObject:[NSNumber numberWithInt:95] forKey:@"toleranceHigh"];
    [educationDict setObject:[NSNumber numberWithInt:20] forKey:@"aggressionLow"];
    [educationDict setObject:[NSNumber numberWithInt:50] forKey:@"aggressionHigh"];
    [educationDict setObject:[NSNumber numberWithInt:30] forKey:@"adaptabilityLow"];
    [educationDict setObject:[NSNumber numberWithInt:70] forKey:@"adaptabilityHigh"];
    [educationDict setObject:[NSNumber numberWithInt:25] forKey:@"ageLow"];
    [educationDict setObject:[NSNumber numberWithInt:60] forKey:@"ageHigh"];
    [educationDict setObject:[NSNumber numberWithInt:30] forKey:@"healingLow"];
    [educationDict setObject:[NSNumber numberWithInt:50] forKey:@"healingHigh"];
    [educationDict setObject:[NSNumber numberWithInt:80] forKey:@"strengthLow"];
    [educationDict setObject:[NSNumber numberWithInt:90] forKey:@"strengthHigh"];
    [educationDict setObject:[NSNumber numberWithInt:10] forKey:@"tradeLow"];
    [educationDict setObject:[NSNumber numberWithInt:40] forKey:@"tradeHigh"];
    [educationDict setObject:[NSNumber numberWithInt:30] forKey:@"engineeringLow"];
    [educationDict setObject:[NSNumber numberWithInt:70] forKey:@"engineeringHigh"];
    [educationDict setObject:[NSNumber numberWithInt:30] forKey:@"techLow"];
    [educationDict setObject:[NSNumber numberWithInt:70] forKey:@"techHigh"];
    [profDict setObject:educationDict forKey:@"Education"];
    
    //set up management
    NSMutableDictionary *managementDict = [[NSMutableDictionary alloc] init];
    [managementDict setObject:[NSNumber numberWithInt:50] forKey:@"intelligenceLow"];
    [managementDict setObject:[NSNumber numberWithInt:75] forKey:@"intelligenceHigh"];
    [managementDict setObject:[NSNumber numberWithInt:25] forKey:@"toleranceLow"];
    [managementDict setObject:[NSNumber numberWithInt:75] forKey:@"toleranceHigh"];
    [managementDict setObject:[NSNumber numberWithInt:20] forKey:@"aggressionLow"];
    [managementDict setObject:[NSNumber numberWithInt:60] forKey:@"aggressionHigh"];
    [managementDict setObject:[NSNumber numberWithInt:40] forKey:@"adaptabilityLow"];
    [managementDict setObject:[NSNumber numberWithInt:60] forKey:@"adaptabilityHigh"];
    [managementDict setObject:[NSNumber numberWithInt:25] forKey:@"ageLow"];
    [managementDict setObject:[NSNumber numberWithInt:60] forKey:@"ageHigh"];
    [managementDict setObject:[NSNumber numberWithInt:1] forKey:@"healingLow"];
    [managementDict setObject:[NSNumber numberWithInt:10] forKey:@"healingHigh"];
    [managementDict setObject:[NSNumber numberWithInt:10] forKey:@"strengthLow"];
    [managementDict setObject:[NSNumber numberWithInt:50] forKey:@"strengthHigh"];
    [managementDict setObject:[NSNumber numberWithInt:10] forKey:@"tradeLow"];
    [managementDict setObject:[NSNumber numberWithInt:30] forKey:@"tradeHigh"];
    [managementDict setObject:[NSNumber numberWithInt:10] forKey:@"engineeringLow"];
    [managementDict setObject:[NSNumber numberWithInt:50] forKey:@"engineeringHigh"];
    [managementDict setObject:[NSNumber numberWithInt:30] forKey:@"techLow"];
    [managementDict setObject:[NSNumber numberWithInt:70] forKey:@"techHigh"];
    [profDict setObject:managementDict forKey:@"Management"];
    return profDict;
    
}

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

-(void)logCharacteristics {
    
    NSLog(@"new person: %@", _profession);
    NSLog(@"intelligence: %d", _intelligence);
    NSLog(@"tolerance: %d", _tolerance);
    NSLog(@"aggression: %d", _aggression);
    NSLog(@"adaptability: %d", _adaptability);
    NSLog(@"age: %d", _age);
    NSLog(@"healing: %d", _healing);
    NSLog(@"strength: %d", _strength);
    NSLog(@"trade: %d", _trade);
    NSLog(@"engineering: %d", _engineering);
    NSLog(@"tech: %d", _tech);
    NSLog(@"has uterus: %d", _hasUterus);
    NSLog(@"can reproduce: %d", _canReproduce);

}



-(void)setName:(NSString *)aName {
    
    _name = aName;
}


@end
