//
//  AddTaskViewController.h
//  ObjectiveTodo
//
//  Created by Baher Tamer on 26/06/2023.
//

#import "AppendTask.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddTaskViewController : UITableViewController

@property id<AppendTask> mainVC;

@end

NS_ASSUME_NONNULL_END
