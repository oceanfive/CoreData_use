//
//  Cat.h
//  CoreData_use
//
//  Created by ocean on 16/8/9.
//  Copyright © 2016年 ocean. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Cat : NSManagedObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) double weight;

@end
