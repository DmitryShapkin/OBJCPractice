//
//  Clean Height Without NabigationBar and TabBar..m
//
//  Created by Dmitry Shapkin on 16/05/2019.
//  Copyright © 2019 Dmitry Shapkin. All rights reserved.
//

CGFloat height = self.tableView.bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height;
height = height - self.navigationController.navigationBar.frame.size.height;
height = height - self.tabBarController.tabBar.bounds.size.height;
