//
//  ViewController.m
//  Blocks
//
//  Created by Dmitry Shapkin on 26/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import "ViewController.h"
#import "MyObject.h"

@interface ViewController ()

//@property (strong, nonatomic) NSObject *myObj;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /** Простой блок */
    void (^simpleBlock)(void);
    
    simpleBlock = ^{
        NSLog(@"Simple block");
    };
    
    simpleBlock(); /**< То же, что и: simpleBlock->impl(simpleBlock); */
    
    
    /** Узнаем класс блока */
    NSInteger age = 20;
    
    Class blockClass = [^{
        NSLog(@"Some block");
        NSLog(@"%ld", age);
    } class];
    
    NSLog(@"%@", blockClass);
    
    /**
     Тест с malloc block (ARC)
     __NSMallocBlock__ - потому что создали как id
     */
    int foo = 3;
    id thisIsBlock = ^{
        int foo2 = foo + 1;
        NSLog(@"Эта строка просто, чтобы компилятор не ругался %d", foo2);
    };
    Class class = [thisIsBlock class];
    NSLog(@"%@", class);
    
    /** Еще один тест */
    void (^someBlock)(void);
    int numBalloons = 2;
    int numClowns = 1;
    someBlock = ^{
        if (numBalloons > numClowns)
        {
            NSLog(@"before abort");
            abort();
//            NSLog(@"after abort");
        }
    };
//    someBlock();
    
    /** Верхний блок другими словами: */
    struct __block_literal_1 {
        /* other fields */
        void (*invoke)(struct __block_literal_1 *);
        /* ... */
        const int numBalloons;
        const int numClowns;
    };
    
    /** Приводим к weak вне скоупа блока
        ! Важно ! Retain cylce'а нет, но weak может стать нилом */
    __weak typeof(self) weakSelf = self;
    dispatch_block_t block =  ^{
        [weakSelf doSomething]; // weakSelf != nil
        // preemption, weakSelf turned nil
        [weakSelf doSomethingElse]; // weakSelf == nil
    };
    NSLog(@"Эта строка просто, чтобы компилятор не ругался %@", block);
    
    /** Приводим к weak вне скоупа блока + приводим к стронгу внутри блока
        ! Важно ! Retain cylce'а нет, + нилом self не станет и объект будет жить в этом блоке
        !!! Очень важно !!!
            1. Делаем weak
            2. Делаем strong внутри
            3. Проверяем существует ли strongSelf
     */
    
    MyObject *myObj = [MyObject new];

    __weak typeof(self) wweakSelf = self; /**< 1 */
    myObj.myBlock = ^{
        __strong typeof(self) strongSelf = wweakSelf; /**< 2 */
        if (strongSelf) { /**< 3 */
            [strongSelf doSomething]; // strongSelf != nil
            // preemption occurs, strongSelf still not nil
            [strongSelf doSomethingElse]; // strongSelf != nil
        } else {
            // Probably nothing...
            return;
        }
    };
    
    myObj.myBlock();
}

- (void)doSomething
{
    NSLog(@"doSomething");
}

- (void)doSomethingElse
{
    NSLog(@"doSomethingElse");
}

@end
