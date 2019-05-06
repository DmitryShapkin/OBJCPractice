//
//  NSAttributedString-Memory-Leak-HTML.m
//
//  Created by Dmitry Shapkin on 06/05/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//


/**
 При попытке преобразовать HTML в NSString
 Следующая строка вызывает Memory leak
 */
NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[cardItem.content dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];

/**
 Комментарии:
 https://forums.developer.apple.com/thread/115405
 
 This is a known bug in iOS.
 The bug number tracking this is 23592459.
 */
