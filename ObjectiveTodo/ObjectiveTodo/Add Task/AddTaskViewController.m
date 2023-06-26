//
//  AddTaskViewController.m
//  ObjectiveTodo
//
//  Created by Baher Tamer on 26/06/2023.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()

@property UISegmentedControl *segmentedControl;
@property UITextField *textField;

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Add Task";
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addNewTask:)];
}

- (void)addNewTask:(UIBarButtonItem *)sender {
    NSInteger selectedSegmentIndex = _segmentedControl.selectedSegmentIndex;
    
    NSString *priority;
    
    switch (selectedSegmentIndex) {
        case 0:
            priority = @"High";
            break;
        case 1:
            priority = @"Medium";
            break;
        case 2:
            priority = @"Low";
            break;
            
        default:
            break;
    }
    
    [_mainVC appendTask:_textField.text andPriority:priority];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FormRow" forIndexPath:indexPath];
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width - 80;
    CGRect frame = CGRectMake(20, 10, screenWidth, 30);
    
    if (indexPath.row == 0) {
        _textField = [[UITextField alloc] initWithFrame:frame];
        _textField.placeholder = @"Task Title";
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        [_textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [cell.contentView addSubview:_textField];
    } else if (indexPath.row == 1) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"High", @"Medium", @"Low"]];
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.frame = frame;
        
        [cell.contentView addSubview:_segmentedControl];
    }
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
