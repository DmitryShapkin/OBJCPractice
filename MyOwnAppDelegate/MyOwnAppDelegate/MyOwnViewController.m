//
//  MyOwnViewController.m
//  MyOwnAppDelegate
//
//  Created by Dmitry Shapkin on 13/03/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

#import "MyOwnViewController.h"

@interface MyOwnViewController ()

@end

@implementation MyOwnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"viewDidLoad");
    self.view.backgroundColor = UIColor.blueColor;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
