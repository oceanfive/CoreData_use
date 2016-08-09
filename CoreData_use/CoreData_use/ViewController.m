//
//  ViewController.m
//  CoreData_use
//
//  Created by ocean on 16/8/9.
//  Copyright © 2016年 ocean. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "Person.h"
#import "Cat.h"



@interface ViewController ()

@property (nonatomic, strong) NSManagedObjectModel *model;

@property (nonatomic, strong) NSPersistentStoreCoordinator *coodinator;

@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", NSHomeDirectory());
    
 
    
    
    

    
    
}

- (IBAction)initCoreData:(id)sender {
    
    //一、NSManagedObjectModel，管理对象模型，通过项目中的CoreData文件来实例化。注意使用[NSURL fileURLWithPath:fileName]
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CoreData_use" ofType:@"momd"];
#warning 这里需要使用[NSURL fileURLWithPath:fileName]
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path]];
    self.model = model;
    /*
     path 
     /Users/ocean/Library/Developer/CoreSimulator/Devices/CD98160B-DD49-493E-98A7-7E87C366B489/data/Containers/Bundle/Application/80B0F9F0-6CB0-441C-B238-4E90C217AD61/CoreData_use.app/CoreData_use.momd
     
     [NSURL fileURLWithPath:path]
     file:///Users/ocean/Library/Developer/CoreSimulator/Devices/CD98160B-DD49-493E-98A7-7E87C366B489/data/Containers/Bundle/Application/80B0F9F0-6CB0-441C-B238-4E90C217AD61/CoreData_use.app/CoreData_use.momd/
     */

    
    //二、NSPersistentStoreCoordinator，持久化存储助手，通过NSManagedObjectModel实例化。注意使用[NSURL fileURLWithPath:fileName]
    NSPersistentStoreCoordinator *coodinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    self.coodinator = coodinator;
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [filePath stringByAppendingPathComponent:@"data.sqlite"];
    NSError *error = nil;
#warning 这里需要使用[NSURL fileURLWithPath:fileName]
    [coodinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:fileName] options:nil error:&error];
    
    //三、NSManagedObjectContext，管理对象上下文，通过设置属性persistentStoreCoordinator为已经实例化的NSPersistentStoreCoordinator，执行增删改查的操作。
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
    self.context = context;
    context.persistentStoreCoordinator = coodinator;
    
    
}

- (IBAction)insert:(id)sender {
    
    for (int i = 0; i < 100; i++) {
        
        //四、NSManagedObject，管理对象，相当于数据库的一条记录，通过实体NSEntityDescription来实例化一个NSManagedObject并为每个属性设置值，注意值需要为id类型，int、float需要转为NSNumber才可以
        Person *object1 = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.context];
        object1.name = @"two";
        object1.height = [NSNumber numberWithInt:i];
        
        //五、把NSManagedObject保存到数据库中
        if ([self.context save:nil]) {
            NSLog(@"保存成功");
            
        }else {
            NSLog(@"保存失败");
            
        }
        
    }
}


- (IBAction)delete:(id)sender {
    
    NSLog(@"删除结果为-------");
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"height > 90"];
    //    fetchRequest.sortDescriptors = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:YES];
    
    NSError *error = nil;
    NSArray *array = [self.context executeFetchRequest:fetchRequest error:&error];
    [array enumerateObjectsUsingBlock:^(NSManagedObject *object1, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.context deleteObject:object1];
        
        if ([self.context save:nil]) {
            NSLog(@"删除成功");
            
            
        }else {
            NSLog(@"删除失败");
            
        
        }
        
    }];
 
}

- (IBAction)fetch:(id)sender {
    
    NSLog(@"搜索结果为-------");
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"height > 90"];
//    fetchRequest.sortDescriptors = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:YES];
    
    NSError *error = nil;
    NSArray *array = [self.context executeFetchRequest:fetchRequest error:&error];
    [array enumerateObjectsUsingBlock:^(Person *object1, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@---%@", object1.name, object1.height);
        
        
    }];

}

@end
