//
//  Group.h
//  MaximumCapacity
//
//  Created by denise szecsei on 3/10/16.
//  Copyright © 2016 denise szecsei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Group : NSObject

@property (nonatomic, strong) NSMutableArray *group;
@property (nonatomic, strong) NSMutableArray *professionList;
@property (nonatomic) int profChoice;

-(NSMutableArray *)getProfession;

@end
