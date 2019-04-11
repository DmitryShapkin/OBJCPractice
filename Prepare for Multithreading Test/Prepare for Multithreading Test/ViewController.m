//
//  ViewController.m
//  Prepare for Multithreading Test
//
//  Created by Dmitry Shapkin on 10/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


#import "ViewController.h"


@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**
     Мои наблюдения:
     1. Если стоит async - это значит, что сначала выполнится код после него, а потом уже он сам.
     2. Main queue - это serial queue (последовательная очередь). На ней в любой момент времени может выполняться только 1 задача.
     3. А QOS-очереди - это concurrent queues (то есть параллельные). То есть на них может выполняться несколько задач в один момент времени.
     4. Задания на очередь можно разместить с помощью функций sync (синхронное выполнение по отношению к текущей очереди) и async (асинхронное выполнение по отношению к текущей очереди).
     5. Синхронная функция sync возвращает управление на текущую очередь только после полного завершения задания, тем самым блокируя текущую очередь
     6. ПРИНЯТЬ НА ВЕРУ: Если мы на main thread (главном потоке) запускаем что либо вызывая метод sync (даже указывая BACKGROUND_QUEUE) - то с главного потока мы не уходим, а остаемся на нём.
     7. ПРИНЯТЬ НА ВЕРУ: Если на главном потоке вызываем метод sync - значит остаемся в том же потоке
     8. ПРИНЯТЬ НА ВЕРУ: Главный поток блокируется только тогда, когда вызывается sync
     9. В более высоком QOS блоки в нутри него отрабатывают раньше, чем блоки рядом с этим QOS
     10. ПРИНЯТЬ НА ВЕРУ: Если что-либо мы запускаем на main thread синхронно (sync) - мы остаемся на main thread, но переходим в другую очередь
     11. Страшно, когда мы нашу main-очередь останавливаем через sync и пытаемся в неё же поставить задачу - deadlock
     12. Мысль такая, что очередь сама решает на каком потоке запустить задачу, даже если свободен main-поток - она (очередь) запустит задачу в main-потоке
     13. Внимание! На выходе из sync он тоже забирает значение, а только потом заходит во внутренние async'и
     Также важно! Когда доходит до последнего нслога в sync'е - то выходит наружу, и только потом возвращается
     
     ЗАПОМНИ!!! КОГДА ПОДХОДИМ К КОНЦУ sync - обрабатываем то, что снаружи уже!!! ПРОВЕРЯЙ sync!!!! Всегда!
     */
    
    
    
    /**
     #1 - 1 3 2
     */
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"2");
//        });
//        NSLog(@"3");
//    });
//    NSLog(@"1");
    
    /**
     #2 - Ошибка рантайма.
     Никогда не вызывать метод sync на main thread (главном потоке)!
     */
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"1");
//    });
    
    /**
     #3 - 1 3 2
     */
//    NSLog(@"1");
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"2");
//    });
//    NSLog(@"3");
    
    /**
     #4 - 1 3 2
     */
//    NSLog(@"1");
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        NSLog(@"2");
//    });
//    NSLog(@"3");
    
    /**
     #5 - 1 2 3
     */
//    NSLog(@"1");
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        NSLog(@"2");
//        for (int i = 0; i < 10000; i++)
//        {
//            NSLog(@"%d", i);
//        }
//    });
//    NSLog(@"3"); // выполнится последним, ждем пока все завершится, даже цикл, потому что sync - блокирует текущую очередь

    /**
     #6 - D A C B
     */
//    dispatch_async(dispatch_get_main_queue(), ^
//    {
//        NSLog(@"A");
//        dispatch_async(dispatch_get_main_queue(), ^
//        {
//            NSLog(@"B");
//        });
//        NSLog(@"C");
//    });
//    NSLog(@"D");
    
    /**
     #7 - 1 2 3 4 5
     */
    
//    NSLog(@"1");
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        NSLog(@"3");
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"4");
//        });
//        NSLog(@"5");
//    });
//    NSLog(@"2");
    
    /**
     #8 - 1 3 4 12 6 7 8 9 11 10 5 2 - не правильно
     дубль два - 1 3 5 2 4 12 9 8 11 10 6 7
     */
    
//    NSLog(@"1");
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        NSLog(@"3");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"4");
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//                NSLog(@"6");
//            });
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//                NSLog(@"7");
//            });
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//                NSLog(@"8");
//            });
//            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//                NSLog(@"9");
//                dispatch_sync(dispatch_get_main_queue(), ^{
//                    NSLog(@"11");
//                });
//                NSLog(@"10");
//            });
//            NSLog(@"12");
//        });
//        NSLog(@"5");
//    });
//    NSLog(@"2");
    
    /**
     #9 - 1 3[1] 4 2 5[1] - с главного потока не уходим, всегда остаемся на нём
     */
//    NSLog(@"1");
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        NSLog(@"3");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"5");
//        });
//        NSLog(@"4");
//    });
//    NSLog(@"2");
    
    /**
     #10 - 1 2 3 4 5
     */
//    NSLog(@"1");
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        NSLog(@"3");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"5");
//        });
//        NSLog(@"4");
//    });
//    NSLog(@"2");
    
    
    
    
    
    /**
     20 тестов по многопопточности GCD
     Создать тесты с 10 нслогами
     */
    
    /**
     1/5 async main_queue
     1 2 3 далее краш из-за того, что вызываем sync на главном потоке
     */
    
//    NSLog(@"1");
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"3");
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"5");
//            dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
//                NSLog(@"7");
//            });
//            NSLog(@"8");
//            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//                NSLog(@"9");
//                dispatch_sync(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
//                    NSLog(@"10");
//                });
//                NSLog(@"11");
//            });
//            NSLog(@"6");
//        });
//        NSLog(@"4");
//    });
//    NSLog(@"2");
    
    /**
     2/5 async main_queue
     1 2 3 4 5 8 6 9 10 11 7
     Вывод: всё, что запущено в более высоком QOS - отрабатывает раньше
     */
    
//    NSLog(@"1");
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"3");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"5");
//            dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
//                NSLog(@"7");
//            });
//            NSLog(@"8");
//            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//                NSLog(@"9");
//                dispatch_sync(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
//                    NSLog(@"10");
//                });
//                NSLog(@"11");
//            });
//            NSLog(@"6");
//        });
//        NSLog(@"4");
//    });
//    NSLog(@"2");
    
    /**
     3/5 async main_queue
     1 2 3 4 5 8 6 9 10 15 11 14 7 13 12
     */
    
//    NSLog(@"1");
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"3");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"5");
//            dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
//                NSLog(@"7");
//                dispatch_sync(dispatch_get_main_queue(), ^{
//                    NSLog(@"13");
//                });
//                NSLog(@"12");
//            });
//            NSLog(@"8");
//            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//                NSLog(@"9");
//                dispatch_sync(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
//                    NSLog(@"10");
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        NSLog(@"14");
//                    });
//                    NSLog(@"15");
//                });
//                NSLog(@"11");
//            });
//            NSLog(@"6");
//        });
//        NSLog(@"4");
//    });
//    NSLog(@"2");
    
    /**
     4/5 async main_queue
     1 2 3 4 5 8 9 10 15 11 6 7 12 14 13
     */
    
//    NSLog(@"1");
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"3");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"5");
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"7");
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSLog(@"13");
//                });
//                NSLog(@"12");
//            });
//            NSLog(@"8");
//            dispatch_sync(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//                NSLog(@"9");
//                dispatch_sync(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
//                    NSLog(@"10");
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        NSLog(@"14");
//                    });
//                    NSLog(@"15");
//                });
//                NSLog(@"11");
//            });
//            NSLog(@"6");
//        });
//        NSLog(@"4");
//    });
//    NSLog(@"2");
    
    /**
     5/5 async main_queue
     1 2 3 9 10 15 11 16 4 14 5 8 17 19 6 7 12 18 13
     */
    
//    NSLog(@"1");
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"3");
//        dispatch_sync(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//            NSLog(@"9");
//            dispatch_sync(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
//                NSLog(@"10");
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSLog(@"14");
//                });
//                NSLog(@"15");
//            });
//            NSLog(@"11");
//        });
//        NSLog(@"16");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"5");
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"7");
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSLog(@"13");
//                });
//                NSLog(@"12");
//            });
//            NSLog(@"8");
//            dispatch_sync(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
//                NSLog(@"17");
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSLog(@"18");
//                });
//                NSLog(@"19");
//            });
//            NSLog(@"6");
//        });
//        NSLog(@"4");
//    });
//    NSLog(@"2");
    
    /**
     5.1 доп /5 async main_queue
     1 2 3
     */
//    NSLog(@"1");
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        NSLog(@"2");
//    });
//    NSLog(@"3");
    
    /**
     5.2 доп /5 async main_queue
     1 2 3
     */
//    NSLog(@"1");
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        NSLog(@"2");
//        NSLog(@"%@", [NSThread currentThread]);
//        NSLog(@"%@", dispatch_get_current_queue());
//    });
//    NSLog(@"3");

    /**
     6/10 sync main_queue
     1 - краш
     */
//    NSLog(@"1");
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"3");
//    });
//    NSLog(@"2");
    
    /**
     11/15 async global
     1 5 2 4 3 8 9 10 7 11 6
     1 5 3 2 4 9 8 10 7 11 6
     */
//    NSLog(@"1");
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        NSLog(@"3");
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"7");
//        });
//        NSLog(@"6");
//    });
//    NSLog(@"5");
//    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
//        NSLog(@"4");
//        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//            NSLog(@"9");
//        });
//        NSLog(@"8");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"11");
//        });
//        NSLog(@"10");
//    });
//    NSLog(@"2");
    
    /**
     16/20 sync global
     1 2 5 6 7 8 4 9 11 3 10 - не правильно
     1 2 5 6 8 4 3 9 7 11 10
     */
//    NSLog(@"1");
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        NSLog(@"2");
//        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            NSLog(@"5");
//            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"7");
//            });
//            NSLog(@"6");
//        });
//        NSLog(@"8");
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//            NSLog(@"9");
//            dispatch_sync(dispatch_get_main_queue(), ^{
//                NSLog(@"11");
//            });
//            NSLog(@"10");
//        });
//        NSLog(@"4");
//    });
//    NSLog(@"3");
    
    /**
     17/20  async global + myOwnQueue
     1 2 3 4 7 8 10 6 5 9 11
     1 2 3 4 6 7 11 5 8 9 10 - первый заход
     1 2 3 5 4 7 6 11 8 10 9 - второй заход ()
     */
    
//    dispatch_queue_t myOwnQueue = dispatch_queue_create("myOwnQueue", DISPATCH_QUEUE_CONCURRENT);
//
//    NSLog(@"1");
//    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
//        NSLog(@"3");
//        dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
//            NSLog(@"5");
//        });
//        NSLog(@"4");
//        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//            NSLog(@"6");
//        });
//        NSLog(@"7");
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//            NSLog(@"11");
//        });
//        NSLog(@"8");
//        dispatch_async(myOwnQueue, ^{
//            NSLog(@"9");
//        });
//        NSLog(@"10");
//    });
//    NSLog(@"2");
    
    /**
     18/20  async global + ph
     1 2 3
     */
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"2");
//        });
//        NSLog(@"3");
//    });
//    NSLog(@"1");
    
    /**
     19/20  async global + ph two
     3 1 2
     */
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"2");
//        });
//        NSLog(@"3");
//    });
//    NSLog(@"1");
    
    /**
     20/20  async global + ph two
     3 1 4 5 2 6
     */
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"2");
//        });
//        NSLog(@"3");
//    });
//    NSLog(@"1");
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        NSLog(@"4");
//    });
//    NSLog(@"5");
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"6");
//    });
    
    /**
     Dispatch after
     */
//    NSLog(@"1");
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC);
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//        NSLog(@"waited at least three seconds.");
//    });
//    NSLog(@"2");
    
    /**
     DispatchGroup
     Важно! Порядок выполнения в Dispatch Group не определен!
     */
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"Первый, например");
//    });
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"Второй, но это не точно");
//    });
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"Может быть третьим");
//    });
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"Все!");
//    });
}
    
- (void)someLoop
{
    for (int i = 0; i < 1000; i++)
    {
        NSLog(@"%d", i);
    }
    
    NSLog(@"%@", [NSThread currentThread]);
    NSLog(@"%@", dispatch_get_current_queue());
}


@end
