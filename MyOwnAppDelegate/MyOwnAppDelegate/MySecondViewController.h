//
//  MySecondViewController.h
//  MyOwnAppDelegate
//
//  Created by Dmitry Shapkin on 13/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MySecondViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *mySuperButton;

- (IBAction)myAction:(UIButton *)sender;


@end

NS_ASSUME_NONNULL_END
