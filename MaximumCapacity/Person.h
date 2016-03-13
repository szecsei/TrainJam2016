//
//  Person.h
//  MaximumCapacity
//
//  Created by denise szecsei on 3/10/16.
//  Copyright © 2016 denise szecsei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) int healthActual;
@property (nonatomic) int healthVisible;
@property (nonatomic) int age;
@property (nonatomic) BOOL canReproduce;
@property (nonatomic) BOOL hasUterus;
@property (nonatomic, strong) NSString *profession;
@property (nonatomic) int intelligence;
@property (nonatomic) int aggression;
@property (nonatomic) int adaptability;
@property (nonatomic) int tolerance;
@property (nonatomic) int healing;
@property (nonatomic) int tech;
@property (nonatomic) int strength;
@property (nonatomic) int morale;
@property (nonatomic) int trade;
@property (nonatomic) int engineering;

-(id)initWithProfession:(NSString *)prof;
-(void)setName:(NSString *)aName;
-(NSMutableDictionary *)makeDictionaries;
-(int)getRandomUniform:(int)low highValue:(int)high;
-(int)getRandomGaussian:(int)low highValue:(int)high;
-(void)logCharacteristics;


@end
