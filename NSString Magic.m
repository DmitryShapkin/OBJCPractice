//
//  NSString Magic.m
//
//  Created by Dmitry Shapkin on 26/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

/** Магия компилятора */

NSString *a = @"123";
NSString *b = @"123";

NSLog(@"%p", a); /**< %p - проверить адрес */
NSLog(@"%p", b);
