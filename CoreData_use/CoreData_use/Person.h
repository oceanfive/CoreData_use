//
//  Person.h
//  CoreData_use
//
//  Created by ocean on 16/8/9.
//  Copyright © 2016年 ocean. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Person : NSManagedObject

@property (nonatomic, strong) NSString *name;

//@property (nonatomic, assign) int age;

@property (nonatomic, strong) NSNumber *height;

@end
