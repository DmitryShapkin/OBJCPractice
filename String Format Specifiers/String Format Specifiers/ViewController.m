//
//  ViewController.m
//  String Format Specifiers
//
//  Created by Dmitry Shapkin on 27/02/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. Objective-C object (like description)
    NSString *someString = @"Hello World";
    NSLog(@"%@", someString);
    
    // 2. '%' character
    NSLog(@"%%");
    
    // 3. Signed 32-bit integer (int) - %d or %D
    int someInteger = 7;
    NSLog(@"%d", someInteger);
    NSLog(@"%D", someInteger);
    
    // 4. Unsigned 32-bit integer (unsigned int) - %u or %U
    unsigned int someUnsignedInteger = 9;
    NSLog(@"%u", someUnsignedInteger);
    NSLog(@"%U", someUnsignedInteger);
    
    // 5. Unsigned 32-bit integer (usigned int), printed in hexadecimal using the digits 0–9 and lowercase a–f.
    // 16 - Удобно переводить в шестнадцатеричную систему
    unsigned int someHexUnsignedInteger = 77;
    NSLog(@"%x", someHexUnsignedInteger);
    
    // 6. %X - Unsigned 32-bit integer (unsigned int), printed in hexadecimal using the digits 0–9 and uppercase A–F.
    // The same as previous one but using the big letters
    unsigned int someBigHexUnsignedInteger = 54;
    NSLog(@"%X", someBigHexUnsignedInteger);
    
    // 7. %o, %O - Unsigned 32-bit integer (unsigned int), printed in octal.
    // 8 - Перевод в восьмеричную систему
    unsigned int octalUnsignedInteger = 777;
    NSLog(@"%o", octalUnsignedInteger);
    NSLog(@"%O", octalUnsignedInteger); // the same
    
    // 8. f - 64-bit floating-point number (double).
    // 6 знаков после запятой
    double someDouble = 7.8;
    NSLog(@"%f", someDouble);
    
    // 9. %e - 64-bit floating-point number (double), printed in scientific notation using a lowercase e to introduce the exponent.
    // добавляет в конце 'e+00'
    double eDouble = 5.1;
    NSLog(@"%e", eDouble);
    
    // 10. %E - 64-bit floating-point number (double), printed in scientific notation using an uppercase E to introduce the exponent.
    NSLog(@"%E", eDouble); // the same as previous but with big 'E'
    
    // 11. %g - 64-bit floating-point number (double), printed in the style of %e if the exponent is less than –4 or greater than or equal to the precision, in the style of %f otherwise.
    // Can't get for what purpose should I use it
    double gDouble = 3;
    NSLog(@"%g", gDouble);
    
    // 12. %G - 64-bit floating-point number (double), printed in the style of %E if the exponent is less than –4 or greater than or equal to the precision, in the style of %f otherwise.
    NSLog(@"%G", gDouble); // the same as previous but with big 'G'
    
    // 13. %c - 8-bit unsigned character (unsigned char).
    // Просто выводим в лог char
    char dChar = 'd';
    NSLog(@"%c", dChar);
    
    // 14. %C - 16-bit UTF-16 code unit (unichar) - (typedef unsigned short).
    unichar someUniChar = 'u';
    NSLog(@"%C", someUniChar);
    
    // 15. %s - Null-terminated array of 8-bit unsigned characters. Because the %s specifier causes the characters to be interpreted in the system default encoding, the results can be variable, especially with right-to-left languages. For example, with RTL, %s inserts direction markers when the characters are not strongly directional. For this reason, it’s best to avoid %s and specify encodings explicitly.
    NSString *str = @"你好";
    const char *cstr = [str UTF8String];
    NSLog(@"%s", cstr);
    
}


@end
