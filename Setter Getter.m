//
//  Setter Getter.m
//
//  Created by Dmitry Shapkin on 24/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

/** Сеттеры и геттеры */

// Делаем @synthesize когда перелпределяем и сеттер и геттер
@synthesize myName = _myName;

// Getter
- (NSString *)myName
{
    return [NSString stringWithFormat:@"It's me - %@", _myName];
}

// Setter
- (void)setMyName:(NSString *)myName
{
    NSLog(@"Setter setName: is called");
    _myName = [NSString stringWithFormat:@"My new name is %@", myName];
}
