//
//  ViewController.m
//  ObjectiveTodo
//
//  Created by Baher Tamer on 26/06/2023.
//

#import "ViewController.h"
#import "AddTaskViewController.h"

@interface ViewController ()

@property (nonatomic) NSMutableArray *tasks;
@property NSUserDefaults *userDefaults;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.title = @"Today's Tasks";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAddTask:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleDone target:self action:@selector(clearTasks:)];
    
    // Preview Data
    /*
    self.tasks = @[
    @{
        @"name": @"📖 Study Quran",
        @"priority": @"High"
    },
    @{
        @"name": @"💻 iOS Development",
        @"priority": @"Medium"
    },
    @{
        @"name": @"👟 Jogging",
        @"priority": @"Low"
    }
    ].mutableCopy;
     */
}

- (void)viewWillAppear:(BOOL)animated {
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *loadedTasks = [self.userDefaults objectForKey:@"Tasks"];
    
    if (loadedTasks != nil) {
        self.tasks = loadedTasks.mutableCopy;
    } else {
        self.tasks = @[].mutableCopy;
    }
}

- (void)showAddTask:(UIBarButtonItem *)sender {
    AddTaskViewController *addTaskVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddTaskVC"];
    
    addTaskVC.mainVC = self;
    [self.navigationController pushViewController:addTaskVC animated:YES];
}

- (void)clearTasks:(UIBarButtonItem *)sender {
    [self.tasks removeAllObjects];
    [self reloadContent];
}

- (void)appendTask:(NSString *)name andPriority:(NSString *)priority {
    NSDictionary *newTask = @{
        @"name": name,
        @"priority": priority
    };
    
    [self.tasks insertObject:newTask atIndex:0];
    [self reloadContent];
}

- (void)reloadContent {
    if (self.tasks.count > 0) {
        NSArray *sortedTasks = [self.tasks sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *task1, NSDictionary *task2) {
            NSDictionary *priorityOrder = @{
                @"High": @0,
                @"Medium": @1,
                @"Low": @2
            };
            
            NSNumber *priorityIndex1 = priorityOrder[task1[@"priority"]];
            NSNumber *priorityIndex2 = priorityOrder[task2[@"priority"]];
            
            return [priorityIndex1 compare:priorityIndex2];
        }];
        
        [self.tasks removeAllObjects];
        [self.tasks addObjectsFromArray:sortedTasks];
    }
    
    [self saveData];
    [self.tableView reloadData];
}

- (void)saveData {
    [self.userDefaults setObject:self.tasks forKey:@"Tasks"];
}

#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskRow" forIndexPath:indexPath];
    
    NSDictionary *task = self.tasks[indexPath.row];
    
    cell.textLabel.text = task[@"name"];
    cell.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    cell.detailTextLabel.text = task[@"priority"];
    cell.detailTextLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    
    UIColor *priorityColor;
    
    if ([task[@"priority"] isEqual:@"High"]) {
        priorityColor = UIColor.redColor;
    } else if ([task[@"priority"] isEqual:@"Medium"]) {
        priorityColor = UIColor.orangeColor;
    } else {
        priorityColor = UIColor.blueColor;
    }
    
    cell.detailTextLabel.textColor = priorityColor;
    
    if ([task[@"isCompleted"] boolValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *task = [self.tasks[indexPath.row] mutableCopy];
    BOOL isCompleted = [task[@"isCompleted"] boolValue];
    
    task[@"isCompleted"] = @(!isCompleted);
    self.tasks[indexPath.row] = task;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = ([task[@"isCompleted"] boolValue]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self saveData];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tasks removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self reloadContent];
    }
}

@end
