//
//  MyObject.h
//  Blocks
//
//  Created by Dmitry Shapkin on 26/04/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyObject : NSObject

@property (nonatomic, copy) void (^myBlock)(void);

@end

NS_ASSUME_NONNULL_END
