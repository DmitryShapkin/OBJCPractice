//
//  Block Class.m
//
//  Created by Dmitry Shapkin on 24/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

/** Классы блоков */


/**
 __NSStackBlock__
 Если захватываем внешние переменные
 */
int foo = 3;
Class class = [^{
    int foo1 = foo + 1;
} class];
NSLog(@"%@", NSStringFromClass(class));

/**
 __NSMallocBlock__
 Когда используем "copy"
 */
int foo2 = 3;
Class class2 = [[^{
    int foo1 = foo + 1;
} copy] class];
NSLog(@"%@", NSStringFromClass(class2));

/**
 __NSGlobalBlock__
 Когда НЕ захватываем внешние переменные
 */
Class class3 = [^{
} class];
NSLog(@"%@", NSStringFromClass(class3));

/**
 __NSMallocBlock__
 Вариант с ARC
 */
int foo3 = 3;
id thisIsBlock = ^{
    int foo1 = foo3 + 1;
};
Class class4 = [thisIsBlock class];
NSLog(@"%@", NSStringFromClass(class4));
