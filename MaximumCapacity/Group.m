//
//  Group.m
//  MaximumCapacity
//
//  Created by denise szecsei on 3/10/16.
//  Copyright © 2016 denise szecsei. All rights reserved.
//

#import "Group.h"

@implementation Group

@synthesize group = _group;
@synthesize professionList = _professionList;

-(id)init {
    
    _group = [[NSMutableArray alloc] init];
    _professionList = self.getProfession;
    
    for (int i = 0; i < 10; i++) {
        
        //skew the probability of specific professions:
        //Medical: 5%
        //Technical: 15%
        //Agricultural: 15%
        //Education: 15%
        //Management: 15%
        //Child: 10%
        //Labor: 25%
        
        int value;
        int value1 = arc4random_uniform(100);
        if (value1 < 35) {
            
            value = value1 % 7;
            
        } else if (value1 < 65) {
            
            value = (value1 - 35) % 6;
            
        } else if (value1 < 90) {
            
            value = (value1 - 65) % 5;
            
        } else {
            
            value = 0;
        }

        NSString *myProf = [_professionList objectAtIndex:value];
        Person *aPerson = [[Person alloc] initWithProfession:myProf];
        [_group addObject:aPerson];
    }
    
    return  self;
}

-(NSMutableArray *)getProfession {
    
    NSMutableArray *professionList = [[NSMutableArray alloc] init];
    [professionList addObject:@"Labor"];
    [professionList addObject:@"Agriculture"];
    [professionList addObject:@"Technical"];
    [professionList addObject:@"Management"];
    [professionList addObject:@"Education"];
    [professionList addObject:@"Child"];
    [professionList addObject:@"Medical"];
    
    return professionList;
}


@end
