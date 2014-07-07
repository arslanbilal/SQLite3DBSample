//
//  TableViewController.m
//  SQLite3DBSample
//
//  Created by Bilal ARSLAN on 06/07/14.
//  Copyright (c) 2014 Bilal ARSLAN. All rights reserved.
//

#import "TableViewController.h"
#import "DBManager.h"

@interface TableViewController ()

@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSArray *arrPeopleInfo;
@property (nonatomic) int recordIDToEdit;

-(void) loadData;
@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //  Change the <back button tint color.
    self.navigationController.navigationBar.tintColor = self.navigationItem.rightBarButtonItem.tintColor;
    
    //  Initialize the dbManager property with Database name.
    self.dbManager = [[DBManager alloc] initWithDatabaseFileName:@"db.sql"];
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addNewRecord:(id)sender
{
    // Before performing the segue, set the -1 value to the recordIDToEdit. That way we'll indicate that we want to add a new record and not to edit an existing one.
    self.recordIDToEdit = -1;
    
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}

#pragma mark - Segue for reload data
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EditInfoViewController *editInfoVC = [segue destinationViewController];
    editInfoVC.delegate = self;
    editInfoVC.recordIDToEdit = self.recordIDToEdit;
}

#pragma mark - Private Method - Select Statement
-(void)loadData
{
    //  Form the query
    NSString *query = @"select * from peopleInfo";
    
    //  Get data results.
    if (self.arrPeopleInfo != nil) {
        self.arrPeopleInfo = nil;
    }
    self.arrPeopleInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDBWithQuery:query]];
    
    //  Reload the table view.
    [self.tableView reloadData];
}

#pragma mark - EditInfoVC Delegate Method
-(void)editingInfoWasFinished
{
    //  Reload the data.
    [self loadData];
}

#pragma mark - Tableview Datasource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.arrPeopleInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  Deque the cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCell" forIndexPath:indexPath];
    
    //
    NSInteger indexOfFirstname = [self.dbManager.arrColumnNames indexOfObject:@"firstname"];
    NSInteger indexOfLasttname = [self.dbManager.arrColumnNames indexOfObject:@"lastname"];
    NSInteger indexOfAge = [self.dbManager.arrColumnNames indexOfObject:@"age"];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfFirstname], [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfLasttname]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Age: %@", [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfAge]];
    
    return cell;
}

#pragma mark - Tableview Delegate Method
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    // Get the record ID of the selected name and set it to the recordIDToEdit property.
    self.recordIDToEdit = [[[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    
    // Perform the segue.
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}

@end
